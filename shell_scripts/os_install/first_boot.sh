#!/bin/bash
set -x #echo on

dpkg-reconfigure grub-efi-amd64
# Select (using the space bar) all of the ESP partitions (partition 1 on
# each of the pool disks).

username=jonrurka

UUID=$(dd if=/dev/urandom bs=1 count=100 2>/dev/null |
    tr -dc 'a-z0-9' | cut -c-6)

ROOT_DS=$(zfs list -o name | awk '/ROOT\/ubuntu_/{print $1;exit}')

zfs create -o com.ubuntu.zsys:bootfs-datasets=$ROOT_DS \
    -o canmount=on -o mountpoint=/home/$username \
    rpool/USERDATA/${username}_$UUID

adduser $username

cp -a /etc/skel/. /home/$username
chown -R $username:$username /home/$username
usermod -a -G adm,cdrom,dip,lpadmin,lxd,plugdev,sambashare,sudo $username

apt dist-upgrade --yes

apt install --yes ubuntu-standard

for file in /etc/logrotate.d/* ; do
    if grep -Eq "(^|[^#y])compress" "$file" ; then
        sed -i -r "s/(^|[^#y])(compress)/\1#\2/" "$file"
    fi
done

