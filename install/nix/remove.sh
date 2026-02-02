#!/bin/sh
# Short script to get rid of nix install altogether.
# Warning: This will remove all locally installed packages!
sudo rm -rf /nix
rm -rf "$HOME"/.nix-channels "$HOME"/.nix-defexpr "$HOME"/.nix-profile
