#!/bin/sh
# Simple script to remove influence of my script in bash configs.

. "$(dirname "$0")"/../common.sh

dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)
bashrc_custom=". ""$dir""/.bashrc.custom"
profile_line=". ""$HOME""/.profile"
if [ -f "$HOME"/.bashrc ]; then
  while IFS= read -r line; do
    if [ ! "$line" = "$bashrc_custom" ]; then
      printf "%s\n" "$line"
    fi
  done <"$HOME"/.bashrc >"$HOME"/.bashrc.tmp
  mv "$HOME"/.bashrc.tmp "$HOME"/.bashrc
fi
if [ -f "$HOME"/.bash_profile ]; then
  while IFS= read -r line; do
    if [ ! "$line" = "$profile_line" ]; then
      printf "%s\n" "$line"
    fi
  done <"$HOME/".bash_profile >"$HOME"/.bash_profile.tmp
  mv "$HOME"/.bash_profile.tmp "$HOME"/.bash_profile
fi
unlink_config "$HOME/.inputrc"
