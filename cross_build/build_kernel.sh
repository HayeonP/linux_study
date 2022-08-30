#!/bin/bash

echo "configure build output path"

KERNEL_TOP_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
OUTPUT="$KERNEL_TOP_PATH/out"
MOD_OUTPUT="$KERNEL_TOP_PATH/modules"

KERNEL=kernel8
BUILD_LOG="$KERNEL_TOP_PATH/rpi_build_log.txt"

echo "build kernel"
cd linux
make O=$OUTPUT ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  bcmrpi3_defconfig
make -j16 O=$OUTPUT ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs 2>&1 | tee $BUILD_LOG

# echo "install modules"
# sudo make O=$OUTPUT ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- modules_install INSTALL_MOD_PATH=$MOD_OUTPUT