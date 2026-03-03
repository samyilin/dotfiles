#!/bin/sh

config_path="$HOME"/.config
rm -rf "$config_path"/yazi
if [ -f "$config_path"/yazi.bak ]; then
  mv "$config_path"/yazi.bak "$config_path"/yazi
  printf "Your yazi configuration has been restored.\n"
fi
