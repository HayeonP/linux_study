#!/bin/bash

echo "configure path"

KERNEL_TOP_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
OUTPUT="$KERNEL_TOP_PATH/out"
MODULES="$KERNEL_TOP_PATH/modules"

REMOTE_PORT=2223
REMOTE_USER="pi@147.46.125.14"
REMOTE_PATH="/home/pi/kernel"
REMOTE_PASSWD="root"

echo "create remote directories"
sshpass -p $REMOTE_PASSWD ssh -p $REMOTE_PORT $REMOTE_USER mkdir -p $REMOTE_PATH
sshpass -p $REMOTE_PASSWD ssh -p $REMOTE_PORT $REMOTE_USER mkdir -p $REMOTE_PATH/boot
sshpass -p $REMOTE_PASSWD ssh -p $REMOTE_PORT $REMOTE_USER mkdir -p $REMOTE_PATH/boot/overlays
# sshpass -p $REMOTE_PASSWD ssh -p $REMOTE_PORT $REMOTE_USER mkdir $REMOTE_PATH/lib
# sshpass -p $REMOTE_PASSWD ssh -p $REMOTE_PORT $REMOTE_USER mkdir $REMOTE_PATH/lib/modules

cd $OUTPUT

echo "tarnsport kernel"
sshpass -p $REMOTE_PASSWD scp -P $REMOTE_PORT ../flash_kernel.sh $REMOTE_USER:/$REMOTE_PATH
sshpass -p $REMOTE_PASSWD scp -P $REMOTE_PORT arch/arm64/boot/dts/broadcom/*.dtb $REMOTE_USER:/$REMOTE_PATH/boot
sshpass -p $REMOTE_PASSWD scp -P $REMOTE_PORT arch/arm64/boot/dts/overlays/*.dtb* $REMOTE_USER:/$REMOTE_PATH/boot/overlays
sshpass -p $REMOTE_PASSWD scp -P $REMOTE_PORT arch/arm64/boot/Image $REMOTE_USER:/$REMOTE_PATH/boot/kernel8.img

# cd $MODULES
# echo "transport modules"
# zip -r modules.zip lib/modules/5.4.83-v8+
# sshpass -p $REMOTE_PASSWD scp -P $REMOTE_PORT -r modules.zip $REMOTE_USER:/$REMOTE_PATH/lib/modules
# sshpass -p $REMOTE_PASSWD ssh -p $REMOTE_PORT $REMOTE_USER unzip $REMOTE_PATH/lib/modules/modules.zip
# sshpass -p $REMOTE_PASSWD ssh -p $REMOTE_PORT $REMOTE_USER rm $REMOTE_PATH/lib/modules/modules.zip
# sshpass -p $REMOTE_PASSWD ssh -p $REMOTE_PORT $REMOTE_USER mv $REMOTE_PATH/modules $REMOTE_PATH/5.4.83-v8+

#echo "flash modules"

cd $KERNEL_TOP_PATH

