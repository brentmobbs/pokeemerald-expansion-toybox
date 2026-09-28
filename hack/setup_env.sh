#!/bin/bash
# Installs everything needed to build the ROM on Ubuntu/Debian
# (Claude Code cloud sessions and GitHub Actions). Safe to run repeatedly.
set -e

if command -v arm-none-eabi-gcc >/dev/null 2>&1 && [ -f /usr/include/png.h ]; then
    echo "Toolchain already installed."
    exit 0
fi

SUDO=""
if [ "$(id -u)" -ne 0 ]; then
    SUDO="sudo"
fi

# Some cloud images list extra package sources that are blocked; ignore those errors.
$SUDO apt-get update -qq || true
$SUDO env DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    build-essential binutils-arm-none-eabi gcc-arm-none-eabi libnewlib-arm-none-eabi \
    libpng-dev python3

arm-none-eabi-gcc --version | head -n 1
