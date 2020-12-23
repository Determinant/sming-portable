#!/bin/bash
basedir="$(dirname $(realpath "${BASH_SOURCE[0]}"))"
cd "$basedir"
source env.sh
make
