#!/bin/sh
dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)
profile_default=". ""$dir""/.profile.default"
if [ -f "$HOME"/.profile ]; then
  while IFS= read -r line; do
    if [ ! "$line" = "$profile_default" ]; then
      printf "%s\n" "$line"
    fi
  done <"$HOME"/.profile >o
  mv o "$HOME"/.profile
fi
