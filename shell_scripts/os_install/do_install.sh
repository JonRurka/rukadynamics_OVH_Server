# install first:
#debootstrap focal /mnt

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
chroot /mnt /usr/bin/env DISK=$DISK0 UUID=$UUID bash --login

apt update

dpkg-reconfigure locales tzdata keyboard-configuration console-setup 

apt install --yes nano
apt install --yes vim

apt install --yes dosfstools
apt install --yes \
    grub-efi-amd64 grub-efi-amd64-signed linux-image-generic \
    shim-signed zfs-initramfs zsys

apt install --yes mdadm

apt install --yes curl patch
apt install --yes openssh-server


mkdosfs -F 32 -s 1 -n EFI ${DISK0}-part1
mkdosfs -F 32 -s 1 -n EFI ${DISK1}-part1
mkdir /boot/efi
echo /dev/disk/by-uuid/$(blkid -s UUID -o value ${DISK}-part1) \
    /boot/efi vfat defaults 0 0 >> /etc/fstab
mount /boot/efi

passwd

# Adjust the level (ZFS raidz = MD raid5, raidz2 = raid6) and
# raid-devices if necessary and specify the actual devices.
# TODO: specify device
mdadm --create /dev/md0 --metadata=1.2 --level=mirror \
    --raid-devices=2 ${DISK1}-part2 ${DISK2}-part2
mkswap -f /dev/md0
echo /dev/disk/by-uuid/$(blkid -s UUID -o value /dev/md0) \
    none swap discard 0 0 >> /etc/fstab


#cp /usr/share/systemd/tmp.mount /etc/systemd/system/
#systemctl enable tmp.mount

addgroup --system lpadmin
addgroup --system lxd
addgroup --system sambashare

#echo "Set PermitRootLogin in sshd_config"
#vi /etc/ssh/sshd_config
# Set: PermitRootLogin yes



