#!/bin/sh
# Short script to install package manager.
if [ ! -d "$HOME"/.nix-profile ]; then
  tempfile=$(mktemp) &&
    curl -o "$tempfile" https://nixos.org/nix/install &&
    sh "$tempfile" --no-daemon &&
    rm "$tempfile"
  printf "\nDefaults   env_keep += %s/.nix-profile/bin" "$HOME" | sudo tee -a /etc/sudoers >>/dev/null || printf "Nix install failed, check if you have tar and xz installed.\n"
  . "$HOME"/.nix-profile/etc/profile.d/nix.sh
fi
