#!/bin/bash
set -x #echo on

passwd

sudo apt update
sudo apt install --yes openssh-server vim

sudo systemctl enable ssh
sudo systemctl start ssh

sudo gsettings set org.gnome.desktop.media-handling automount false
