#!/bin/bash

# Configurar identidade do Git
git config --global user.email "rafael1.spindola@gmail.com"
git config --global user.name "VotikaBr"

# Clonar repositórios para o dispositivo Motorola Odessa
echo "Clonando repositórios para o dispositivo Motorola Odessa..."
git clone https://github.com/leole0leoleo/vendor_motorola_odessa.git vendor/motorola/odessa
git clone https://github.com/sm6150-motorola/android_device_motorola_odessa.git device/motorola/odessa

git clone https://github.com/sm6150-motorola/android_device_motorola_sm6150-common.git device/motorola/sm6150-common
git clone https://github.com/sm6150-motorola/android_kernel_motorola_sm6150.git kernel/motorola/sm6150
git clone https://github.com/moto-common/android_vendor_motorola_sm6150-common.git vendor/motorola/sm6150-common

# Clonar repositórios alternativos para crDroid
echo "Clonando repositórios para crDroid..."
git clone https://github.com/thiagochizz44/android_device_motorola_odessa.git -b crdroid device/motorola/odessa
git clone https://github.com/thiagochizz44/device_motorola_sm6150-common.git -b fourteen device/motorola/sm6150-common
git clone https://github.com/thiagochizz44/android_kernel_motorola_sm6150.git -b testv8s kernel/motorola/sm6150
git clone https://github.com/thiagochizz44/proprietary_vendor_motorola.git -b qpr3 vendor/motorola

# Clonar repositório de hardware da Motorola
echo "Clonando repositório de hardware da Motorola..."
git clone https://github.com/vullk4n/hardware_motorola.git hardware/motorola

echo "Configuração concluída!"
