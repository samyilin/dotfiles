#!/bin/sh
# Simple script to remove influence of my script in bash configs.

dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)
bashrc_custom=". ""$dir""/.bashrc.custom"
profile_line=". ""$HOME""/.profile"
if [ -f "$HOME"/.bashrc ]; then
  while IFS= read -r line; do
    if [ ! "$line" = "$bashrc_custom" ]; then
      printf "%s\n" "$line"
    fi
  done <"$HOME"/.bashrc >o
  mv o "$HOME"/.bashrc
fi
if [ -f "$HOME"/.bash_profile ]; then
  while IFS= read -r line; do
    if [ ! "$line" = "$profile_line" ]; then
      printf "%s\n" "$line"
    fi
  done <"$HOME/".bash_profile >o
  mv o "$HOME"/.bash_profile
fi
for i in .inputrc .bash_aliases; do
  if [ -f "$HOME"/"$i" ]; then
    rm -f "$HOME"/"$i"
  fi
  if [ -f "$HOME"/"$i".bak ]; then
    mv "$HOME"/"$i".bak "$HOME"/"$i"
    printf "Your default %s have been restored." "$i"
  fi
done
