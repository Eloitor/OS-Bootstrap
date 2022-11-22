#!/bin/bash

# LiveG OS Bootstrap Toolchain
# 
# Copyright (C) LiveG. All Rights Reserved.
# 
# https://liveg.tech/os
# Licensed by the LiveG Open-Source Licence, which can be found at LICENCE.md.

# Make a backup
if [ -e cache/$PLATFORM/system.img ]; then
    rsync --info=progress2 cache/$PLATFORM/system.img build/$PLATFORM/system.img
else
    rsync --info=progress2 build/$PLATFORM/system.img cache/$PLATFORM/system.img
fi

sudo umount build/$PLATFORM/rootfs || /bin/true
sudo mount -o loop,offset=1048576 build/$PLATFORM/system.img build/$PLATFORM/rootfs

sudo cp host/$PLATFORM/isogrub.cfg build/$PLATFORM/rootfs/boot/grub/grub.cfg
sudo cp host/$PLATFORM/isofstab build/$PLATFORM/rootfs/etc/fstab
sudo cp host/$PLATFORM/initoverlay.sh build/$PLATFORM/rootfs/sbin/initoverlay

sudo grub-mkrescue -o build/$PLATFORM/system.iso build/$PLATFORM/rootfs --directory=build/$PLATFORM/rootfs/usr/lib/grub/i386-pc -- \
    -volid LiveG-OS-IM \
    -chmod a+rwx,g-w,o-w,ug+s,+t,g-s,-t /usr/bin/sudo -- \
    -chmod a+rwx /usr/sbin/initoverlay --

sudo umount build/$PLATFORM/rootfs

# TODO: Make next parts optional depending if wanting to test to see if
# succeeded (if we automate, then next part should be skipped so script exits
# when everything is complete).

qemu-img create cache/$PLATFORM/test.img 4G

bash -c "qemu-system-$ARCH \
    -m 2G \
    -cdrom build/$PLATFORM/system.iso \
    -hdb cache/$PLATFORM/test.img \
    -boot order=d \
    $QEMU_ARGS"