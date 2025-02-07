#!/bin/bash

# Atualiza os repositórios e pacotes do sistema
sudo apt update && sudo apt upgrade -y

# Instala dependências essenciais para compilação do Android
sudo apt install -y \
    bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick \
    lib32readline-dev lib32z1-dev libelf-dev liblz4-tool lz4 libsdl1.2-dev libssl-dev libxml2 libxml2-utils \
    lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev fontconfig \
    git-core libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev \
    libgl1-mesa-dev unzip python-is-python3

# Instala pacotes adicionais para desenvolvimento
sudo apt install -y libncurses5-dev libwxgtk3.0-gtk3-dev 

# Baixa e configura as ferramentas do Android SDK (ADB e Fastboot)
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip -O platform-tools.zip
unzip platform-tools.zip -d ~ && rm platform-tools.zip

# Adiciona o Android SDK ao PATH
echo 'if [ -d "$HOME/platform-tools" ]; then' >> ~/.profile
echo '    PATH="$HOME/platform-tools:$PATH"' >> ~/.profile
echo 'fi' >> ~/.profile
source ~/.profile

# Testa as versões do ADB e Fastboot
adb version

# Instala e configura o TMUX e o XRDP para acesso remoto
sudo apt install -y tmux xrdp xfce4 xfce4-goodies

echo "xfce4-session" > ~/.xsession

# Instala o Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
sudo dpkg -i chrome.deb
sudo apt-get install -f -y && rm chrome.deb

google-chrome --version

# Configura repositório do Android (repo)
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo 'if [ -d "$HOME/bin" ]; then' >> ~/.profile
echo '    PATH="$HOME/bin:$PATH"' >> ~/.profile
echo 'fi' >> ~/.profile
source ~/.profile

# Configura o Git
git config --global user.email "rafael1.spindola@gmail.com"
git config --global user.name "VotikaBr"
git lfs install

# Configura CCache para acelerar compilação
echo 'export USE_CCACHE=1' >> ~/.bashrc
echo 'export CCACHE_EXEC=/usr/bin/ccache' >> ~/.bashrc
source ~/.bashrc

ccache -M 50G
ccache -o compression=true

# Inicializa repositório do Android
mkdir -p ~/android
cd ~/android

repo init -u https://github.com/SuperiorOS/manifest.git -b fifteen-los -m stable/latest.xml --git-lfs
    
# Clona o manifesto local
git clone https://github.com/VotikaBr/local_manifest_pstar.git .repo/local_manifests

# Sincroniza repositórios com a quantidade máxima de núcleos disponíveis
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

# Carrega ambiente de build do Android

echo "Configuração concluída!"
