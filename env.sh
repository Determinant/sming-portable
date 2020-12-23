#!/bin/bash

basedir="$(dirname $(realpath "${BASH_SOURCE[0]}"))"
#export ESP_HOME=/opt/esp-open-sdk/
export ESP_HOME="$basedir/toolchain"
export SMING_HOME="$basedir/Sming/Sming"
