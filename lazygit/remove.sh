#!/bin/sh
rm -rf "$HOME"/.config/lazygit
if [ -f "$HOME"/.config/lazygit.bak ]; then
  mv "$HOME"/.config/lazygit.bak "$HOME"/.config/lazygit
  printf "Your lazygit configuration has been restored.\n"
fi
