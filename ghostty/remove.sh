#!/bin/sh

## Macos config path is different. Why?
config_path="$HOME"/.config
rm -rf "$config_path"/ghostty
if [ -f "$config_path"/ghostty.bak ]; then
  mv "$config_path"/ghostty.bak "$config_path"/ghostty
  printf "Your ghostty configuration has been restored.\n"
fi
