#!/bin/sh

config_path="$HOME"/.config
rm -rf "$config_path"/zed
if [ -f "$config_path"/zed.bak ]; then
  mv "$config_path"/zed.bak "$config_path"/zed
  printf "Your zed configuration has been restored.\n"
fi
