#!/bin/bash

apt install --yes debootstrap gdisk zfsutils-linux

systemctl stop zed

DISK0=/dev/disk/by-id/nvme-WDC_CL_SN720_SDAQNTW-512G-2000_21060X802821
DISK1=/dev/disk/by-id/nvme-WDC_CL_SN720_SDAQNTW-512G-2000_21060X801103

export DISK0
export DISK1

swapoff --all

sgdisk --zap-all $DISK0
sgdisk --zap-all $DISK1
