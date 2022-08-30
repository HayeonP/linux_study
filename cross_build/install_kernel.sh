#!/bin/bash

KERNEL_TOP_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
MOD_OUTPUT="$KERNEL_TOP_PATH/modules"
OUTPUT="$KERNEL_TOP_PATH/out"

cd linux

sudo make O=$OUTPUT ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- modules_install INSTALL_MOD_PATH=$MOD_OUTPUT