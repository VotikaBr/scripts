#!/bin/bash

# Atualiza pacotes do sistema
sudo apt update && sudo apt upgrade -y

# Instala pacotes essenciais para compilação
sudo apt-get install -y git-core gnupg flex bison build-essential zip curl \
    zlib1g-dev libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev \
    libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig

sudo apt install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib \
    git git-lfs gnupg gperf imagemagick lib32readline-dev lib32z1-dev libelf-dev liblz4-tool \
    lz4 libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool \
    squashfs-tools xsltproc zip zlib1g-dev

# Baixa e instala ferramentas da plataforma Android
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip platform-tools-latest-linux.zip -d ~

# Configura o PATH para incluir platform-tools
cat <<EOF >> ~/.profile
if [ -d "$HOME/platform-tools" ] ; then
    PATH="$HOME/platform-tools:$PATH"
fi
EOF
source ~/.profile

# Verifica a instalação do ADB
adb version

# Instala pacotes adicionais
sudo apt install -y tmux xrdp

# Instala e configura o Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f -y

google-chrome --version

# Configura Python como Python3
sudo apt install -y python-is-python3

# Configura Git
git config --global user.email "rafael1.spindola@gmail.com"
git config --global user.name "VotikaBr"
git lfs install

# Configura ccache
cat <<EOF >> ~/.bashrc
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
EOF
source ~/.bashrc
ccache -o compression=true

# Baixa e configura repo
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# Inicializa repositório crDroid
mkdir crDroid && cd crDroid
repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

# Clona repositórios específicos do dispositivo
git clone https://github.com/thiagochizz44/android_device_motorola_odessa.git -b crdroid device/motorola/odessa
git clone https://github.com/thiagochizz44/device_motorola_sm6150-common.git -b fourteen device/motorola/sm6150-common
git clone https://github.com/thiagochizz44/android_kernel_motorola_sm6150.git -b testv8s kernel/motorola/sm6150
git clone https://github.com/thiagochizz44/proprietary_vendor_motorola.git -b qpr3 vendor/motorola

# Configuração do ambiente de build
source build/envsetup.sh
breakfast odessa

# Compilação
brunch odessa

# Limpeza de build
make clean

# Recompilação
source build/envsetup.sh
brunch odessa
