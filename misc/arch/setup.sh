#!/bin/sh
sudo pacman-key --init
# Some brain-dead distros have really outdated keyrings, hence why this
sudo pacman-key --refresh-keys
sudo pacman-key --populate
sudo pacman -Syu

# Arch linux is absurdingly tiny in the sense that some commonly used
# things are missing, such as openssh and which
sudo pacman -S git tmux vim emacs openssh busybox neovim

if ! grep -q '^en_US.UTF-8 UTF-8$' /etc/locale.gen; then
  printf "\nen_US.UTF-8 UTF-8\n" >>/etc/locale.gen
fi
locale-gen
