#!/bin/bash
sudo dnf upgrade
sudo dnf install dnf-plugin-system-upgrade
sudo dnf system-upgrade download --releasever=36
sudo dnf system-upgrade reboot
sudo dnf install remove-retired-packages
remove-retired-packages
sudo dnf install -y vim git util-linux passwd cracklib-dicts shadow-utils procps-ng iputils iproute findutils ncurses busybox man man-pages texinfo dnf-plugins-core
sudo dnf copr enable deathwish/emacs-pgtk-nativecomp
sudo dnf install emacs
