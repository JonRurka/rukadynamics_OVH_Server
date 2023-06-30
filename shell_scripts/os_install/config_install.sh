#!/bin/bash
set -x #echo on

#chroot /mnt /usr/bin/env DISK=$DISK0 UUID=$UUID bash --login

apt update
sleep 3

dpkg-reconfigure locales tzdata keyboard-configuration console-setup
sleep 3

apt install --yes nano
apt install --yes vim
sleep 3

apt install --yes dosfstools
sleep 3

mkdosfs -F 32 -s 1 -n EFI ${DISK0}-part1
mkdosfs -F 32 -s 1 -n EFI ${DISK1}-part1
sleep 3

mkdir /boot/efi
echo /dev/disk/by-uuid/$(blkid -s UUID -o value ${DISK0}-part1) \
    /boot/efi vfat defaults 0 0 >> /etc/fstab
cat /etc/fstab
sleep 3

mount /boot/efi
sleep 3

apt install --yes \
    grub-efi-amd64 grub-efi-amd64-signed linux-image-generic \
    shim-signed zfs-initramfs zsys
sleep 3

passwd

apt purge --yes os-prober
sleep 3

apt install --yes mdadm
sleep 3

# Adjust the level (ZFS raidz = MD raid5, raidz2 = raid6) and
# raid-devices if necessary and specify the actual devices.
# TODO: specify device
#mdadm --create /dev/md0 --metadata=1.2 --level=mirror \
#    --raid-devices=2 ${DISK1}-part2 ${DISK2}-part2
#mkswap -f /dev/md0
#echo /dev/disk/by-uuid/$(blkid -s UUID -o value /dev/md0) \
#    none swap discard 0 0 >> /etc/fstab


cp /usr/share/systemd/tmp.mount /etc/systemd/system/
systemctl enable tmp.mount
sleep 3

addgroup --system lpadmin
addgroup --system lxd
addgroup --system sambashare
sleep 3

apt install --yes openssh-server
sleep 3

echo "Set PermitRootLogin in sshd_config"
vim /etc/ssh/sshd_config
# Set: PermitRootLogin yes
sleep 3


