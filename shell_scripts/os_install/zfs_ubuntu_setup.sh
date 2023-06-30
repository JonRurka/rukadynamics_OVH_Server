#!/bin/bash
set -x #echo on

#systemctl reboot --firmware-setup

#call init.sh first
#call zfs_ubuntu_setup.sh from ssh

#sudo -i

# run on host with root
source ./set_vars.sh
source ./init_zfs.sh
source ./create_partitions.sh
source ./create_zfs_pools.sh
source ./create_zfs_datasets.sh
source ./do_install.sh

echo "Install script finished"

chroot /mnt /usr/bin/env DISK=$DISK0 UUID=$UUID bash --login

# ----- Run in chroot -----

#source ./config_install.sh

# verify grub: grub-probe /boot

#source ./grub_install.sh

# Wait a while and verify with:
#cat /etc/zfs/zfs-list.cache/bpool
#cat /etc/zfs/zfs-list.cache/rpool

# if empty run:
#zfs set canmount=on bpool/BOOT/ubuntu_$UUID
#zfs set canmount=on rpool/ROOT/ubuntu_$UUID

#once files have data, run "fg", wait a bit, and ctrl+C

# eliminate /mnt in paths with:
# sed -Ei "s|/mnt/?|/|" /etc/zfs/zfs-list.cache/*

# exit chroot: exit

--------------

# unmount in host:
#mount | grep -v zfs | tac | awk '/\/mnt/ {print $3}' | \
#    xargs -i{} umount -lf {}
#zpool export -a

# Reboot system

