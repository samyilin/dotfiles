#!/bin/bash
sudo dnf upgrade
sudo dnf install dnf-plugin-system-upgrade
# Upgrade to the next release rather than a hardcoded one, so this
# never goes stale.
releasever="$(rpm --eval '%{fedora}')"
sudo dnf system-upgrade download --releasever="$(( releasever + 1 ))"
printf "System upgrade downloaded.\n"
read -r -p "Reboot now to apply the upgrade? [y/N] " answer
case "$answer" in
[Yy]*) sudo dnf system-upgrade reboot ;;
*) printf "Run 'sudo dnf system-upgrade reboot' manually when ready.\n" ;;
esac
sudo dnf install remove-retired-packages
remove-retired-packages
sudo dnf install -y vim git util-linux passwd cracklib-dicts shadow-utils procps-ng iputils iproute findutils ncurses busybox man man-pages texinfo dnf-plugins-core
sudo dnf copr enable deathwish/emacs-pgtk-nativecomp
sudo dnf install emacs
