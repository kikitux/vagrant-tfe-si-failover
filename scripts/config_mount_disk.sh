#!/usr/bin/env bash

disk=/dev/sdb
mount=/mnt

# check for format

blkid ${disk}
if [ $? -ne 0 ]; then
  mkfs.ext4 ${disk}
fi

#mount disk
mountpoint ${mount}
if [ $? -ne 0 ]; then
  mkdir -p /mnt
  mount ${disk} /mnt
fi

df -Ph ${mount}
