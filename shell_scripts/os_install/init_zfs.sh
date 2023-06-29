#!/bin/bash
set -x #echo on

apt install --yes debootstrap gdisk zfsutils-linux

systemctl stop zed

echo "export DISK0=/dev/disk/by-id/nvme-WDC_CL_SN720_SDAQNTW-512G-2000_21060X802821" > /etc/profile.d/java.sh
echo "export DISK1=/dev/disk/by-id/nvme-WDC_CL_SN720_SDAQNTW-512G-2000_21060X801103" > /etc/profile.d/java.sh

swapoff --all

sgdisk --zap-all $DISK0
sgdisk --zap-all $DISK1
