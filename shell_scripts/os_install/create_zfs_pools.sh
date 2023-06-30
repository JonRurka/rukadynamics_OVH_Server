#!/bin/bash
set -x #echo on

zpool create \
    -o cachefile=/etc/zfs/zpool.cache \
    -o ashift=12 -o autotrim=on -d \
    -o feature@async_destroy=enabled \
    -o feature@bookmarks=enabled \
    -o feature@embedded_data=enabled \
    -o feature@empty_bpobj=enabled \
    -o feature@enabled_txg=enabled \
    -o feature@extensible_dataset=enabled \
    -o feature@filesystem_limits=enabled \
    -o feature@hole_birth=enabled \
    -o feature@large_blocks=enabled \
    -o feature@lz4_compress=enabled \
    -o feature@spacemap_histogram=enabled \
    -O acltype=posixacl -O canmount=off -O compression=lz4 \
    -O devices=off -O normalization=formD -O relatime=on -O xattr=sa \
    -O mountpoint=/boot -f -R /mnt \
    bpool mirror \
    ${DISK0}-part3 \
    ${DISK1}-part3
sleep 5

zpool create \
    -o ashift=12 -o autotrim=on \
    -O acltype=posixacl -O canmount=off -O compression=lz4 \
    -O dnodesize=auto -O normalization=formD -O relatime=on \
    -O xattr=sa -O mountpoint=/ -f -R /mnt \
    rpool mirror \
    ${DISK0}-part4 \
    ${DISK1}-part4
sleep 5
