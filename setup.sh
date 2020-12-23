#!/bin/bash
basedir="$(dirname $(realpath "${BASH_SOURCE[0]}"))"
arch="$(uname -m)"
kernel="$(uname -s)"
if [[ "$arch" != x86_64 || "$kernel" != "Linux" ]]; then
    echo "unsupported platform: arch: $arch, kernel: $kernel"
    exit 1
fi
git submodule update --init --recursive
cd "$basedir"
if [[ -f esp-open-sdk || -d esp-open-sdk ]]; then
    echo "esp-open-sdk already exists, please remove it before running this script"
    exit 1
fi
# clone SDK
git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
# download toolchain
#curl -s 'https://drive.google.com/u/0/uc?export=download&confirm=Sdn9&id=1oyGELMDvFXwSt8o_CQn411bgDQGQNwPA' esp-toolchain.zip
esp_tc_id=1oyGELMDvFXwSt8o_CQn411bgDQGQNwPA
esp_tc_zip=esp_toolchain.zip
curl -c ./cookie.txt -s -L "https://drive.google.com/uc?export=download&id=${esp_tc_id}" > /dev/null
curl -Lb ./cookie.txt "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie.txt`&id=${esp_tc_id}" -o ${esp_tc_zip}
unzip "$esp_tc_zip"
mv opt/esp-open-sdk/xtensa-lx106-elf esp-open-sdk/
rm -rf opt/
rm -f "$esp_tc_zip"
