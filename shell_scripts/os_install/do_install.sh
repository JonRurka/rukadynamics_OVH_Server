#!/bin/bash
set -x #echo on


# install first:
debootstrap focal /mnt

mkdir /mnt/etc/zfs
cp /etc/zfs/zpool.cache /mnt/etc/zfs/

hostname rukadynamics
hostname > /mnt/etc/hostname

echo "Set host in /mnt/etc/hosts"
cp hosts /mnt/etc/

echo "Set name in /mnt/etc/netplan/01-netcfg.yaml"
cp 01-netcfg.yaml /mnt/etc/netplan/

echo "Set package sources in /mnt/etc/apt/sources.list"
cp sources.list /mnt/etc/apt/

mount --make-private --rbind /dev  /mnt/dev
mount --make-private --rbind /proc /mnt/proc
mount --make-private --rbind /sys  /mnt/sys
