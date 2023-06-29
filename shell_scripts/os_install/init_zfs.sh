#!/bin/bash
set -x #echo on

sudo gsettings set org.gnome.desktop.media-handling automount false

apt install --yes debootstrap gdisk zfsutils-linux

systemctl stop zed

#export DISK0=/dev/disk/by-id/nvme-WDC_CL_SN720_SDAQNTW-512G-2000_21060X802821
#export DISK1=/dev/disk/by-id/nvme-WDC_CL_SN720_SDAQNTW-512G-2000_21060X801103

swapoff --all

sgdisk --zap-all $DISK0
sgdisk --zap-all $DISK1
