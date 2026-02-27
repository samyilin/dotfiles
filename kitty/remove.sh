#!/bin/sh
rm -rf "$HOME"/.config/kitty
if [ -f "$HOME"/.config/kitty.bak ]; then
  mv "$HOME"/.config/kitty.bak "$HOME"/.config/kitty
  printf "Your kitty configuration has been restored.\n"
fi
