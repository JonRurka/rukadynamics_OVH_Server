#!/bin/bash
set -x #echo on

# run first: grub-probe /boot

update-initramfs -c -k all

vi /etc/default/grub
# Add init_on_alloc=0 to: GRUB_CMDLINE_LINUX_DEFAULT
# Comment out: GRUB_TIMEOUT_STYLE=hidden
# Set: GRUB_TIMEOUT=5
# Below GRUB_TIMEOUT, add: GRUB_RECORDFAIL_TIMEOUT=5
# Remove quiet and splash from: GRUB_CMDLINE_LINUX_DEFAULT
# Uncomment: GRUB_TERMINAL=console

update-grub

grub-install --target=x86_64-efi --efi-directory=/boot/efi \
    --bootloader-id=ubuntu --recheck --no-floppy
    
systemctl mask grub-initrd-fallback.service

mkdir /etc/zfs/zfs-list.cache
touch /etc/zfs/zfs-list.cache/bpool
touch /etc/zfs/zfs-list.cache/rpool
ln -s /usr/lib/zfs-linux/zed.d/history_event-zfs-list-cacher.sh /etc/zfs/zed.d
zed -F &






