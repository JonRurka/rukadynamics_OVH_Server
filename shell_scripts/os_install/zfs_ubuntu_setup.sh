#!/bin/bash
set -x #echo on

#systemctl reboot --firmware-setup

#call init.sh first
#call zfs_ubuntu_setup.sh from ssh

sudo -i

source ./set_vars.sh
source ./init_zfs.sh
source ./create_partitions.sh
source ./create_zfs_pools.sh
source ./create_zfs_datasets.sh

debootstrap focal /mnt

source ./do_install.sh
#source ./config_install.sh
#source ./grub_install.sh

echo "Install script finished"
