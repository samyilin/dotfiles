#!/bin/sh

## Macos config path is different. Why?
system="$(uname -srm)"
case ${system%% *} in
Darwin)
  config_path="$HOME"/Library/Application\ Support
  ;;
*)
  config_path="$HOME"/.config
  ;;
esac
rm -rf "$config_path"/lazygit
if [ -f "$config_path"/lazygit.bak ]; then
  mv "$config_path"/lazygit.bak "$config_path"/lazygit
  printf "Your lazygit configuration has been restored.\n"
fi
