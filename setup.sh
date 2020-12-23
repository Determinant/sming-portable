#!/bin/bash
basedir="$(dirname $(realpath "${BASH_SOURCE[0]}"))"
arch="$(uname -m)"
kernel="$(uname -s)"
git submodule update --init --recursive
cd "$basedir"
if [[ -f toolchain || -d toolchain ]]; then
    echo "toolchain already exists, please remove it before running this script"
    exit 1
fi
if [[ "$arch" == x86_64 && "$kernel" == "Linux" ]]; then

# NOTE: this esp-open-sdk is too old...
false && {
    # clone SDK
    git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
    # download toolchain
    #curl -s 'https://drive.google.com/u/0/uc?export=download&confirm=Sdn9&id=1oyGELMDvFXwSt8o_CQn411bgDQGQNwPA' esp-toolchain.zip
    esp_tc_id=1oyGELMDvFXwSt8o_CQn411bgDQGQNwPA
    esp_tc_zip=esp_toolchain.zip
    curl -c ./cookie.txt -s -L "https://drive.google.com/uc?export=download&id=${esp_tc_id}" > /dev/null
    curl -Lb ./cookie.txt "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie.txt`&id=${esp_tc_id}" -o ${esp_tc_zip}
    unzip "$esp_tc_zip"
    mv opt/esp-open-sdk/xtensa-lx106-elf toolchain/
    rm -rf opt/
    rm -f "$esp_tc_zip"
}

esp_tc_tar=esp_toolchain.tar.gz
mkdir -p toolchain
curl -sL "https://github.com/SmingHub/SmingTools/releases/download/1.0/x86_64-linux-gnu.xtensa-lx106-elf-e6a192b.201211.tar.gz" -o "$esp_tc_tar"
tar xvf "$esp_tc_tar" -C toolchain

elif [[ "$arch" == x86_64 && "$kernel" == "Darwin" ]]; then

esp_tc_tar=esp_toolchain.tar.gz
mkdir -p toolchain
curl -sL "https://github.com/SmingHub/SmingTools/releases/download/1.0/x86_64-apple-darwin14.xtensa-lx106-elf-e6a192b.201211.tar.gz" -o "$esp_tc_tar"
tar xvf "$esp_tc_tar" -C toolchain

else
    echo "unsupported platform: arch: $arch, kernel: $kernel"
    exit 1
fi
