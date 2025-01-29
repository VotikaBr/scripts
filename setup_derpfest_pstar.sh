#!/bin/bash

# Criando diretórios necessários
mkdir -p ~/bin
mkdir -p ~/android/DerpFest

# Configuração do Git
git config --global user.email "rafael1.spindola@gmail.com"
git config --global user.name "VotikaBr"

# Clonando Dolby para DerpFest
cd ~/android/DerpFest
git clone -b v1.1-daxappui https://github.com/userariii/hardware_Motorola_Dolby.git hardware/motorola/dolby

# Renomeando arquivos
mv hardware/motorola/dolby/dolby-setup.mk hardware/motorola/dolby/setup.mk

# Pstar - crDroid
## Vendor
git clone https://github.com/crdroidandroid/proprietary_vendor_motorola_pstar.git vendor/motorola/pstar
## Device
git clone https://github.com/crdroidandroid/android_device_motorola_pstar.git device/motorola/pstar

# sm8250 - crDroid
## Device
git clone https://github.com/crdroidandroid/android_device_motorola_sm8250-common.git device/motorola/sm8250-common
## Kernel
git clone https://github.com/crdroidandroid/android_kernel_motorola_sm8250.git kernel/motorola/sm8250-common
## Vendor
git clone https://github.com/crdroidandroid/proprietary_vendor_motorola_sm8250-common.git vendor/motorola/sm8250-common

# Pstar - Lineage
## Vendor
git clone https://github.com/TheMuppets/proprietary_vendor_motorola_pstar.git vendor/motorola/pstar
## Device
git clone https://github.com/LineageOS/android_device_motorola_pstar.git device/motorola/pstar

# sm8250 - Lineage
## Device
git clone https://github.com/LineageOS/android_device_motorola_sm8250-common.git device/motorola/sm8250-common
## Kernel
git clone https://github.com/LineageOS/android_kernel_motorola_sm8250.git kernel/motorola/sm8250
## Vendor
git clone https://github.com/TheMuppets/proprietary_vendor_motorola_sm8250-common.git vendor/motorola/sm8250-common

# Clonando hardware Motorola
git clone https://github.com/vullk4n/hardware_motorola.git hardware/motorola

# Mensagem de conclusão
echo "Setup concluído!"
