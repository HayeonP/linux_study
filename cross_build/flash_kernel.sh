#!/bin/bash

echo "update permission"
sudo chmod 775 ./boot/*dtb
sudo chmod 775 ./boot/overlays/*dtb*
sudo chmod 775 ./boot/kernel8.img

echo "flash kernel"
sudo cp -r /boot /boot_backup
sudo cp -r /home/pi/kernel/boot/*.dtb /boot
sudo cp -r /home/pi/kernel/boot/kernel8.img /boot
sudo cp -r /home/pi/kernel/boot/overlays/*.dtb* /boot/overlays