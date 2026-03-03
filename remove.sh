#!/bin/sh
# A script to remove customizations from this dotfile repo.
dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)
if [ $# -eq 0 ]; then
  for i in "$dir"/*; do
    i="${i%*/}"
    i="${i##*/}"
    if [ -d "$i" ] && case "$i" in misc*) false ;; install*) false ;; config*) false ;; *) true ;; esac then
      if [ -f "$dir/$i/remove.sh" ]; then
        cd "$i" && ./remove.sh && printf "%s config removed.\n" "$i"
        cd "$dir" || return 1
      fi
    fi
  done
else
  while [ $# -gt 0 ]; do
    if [ -d "$dir/$1" ] && [ -f "$dir/$1/remove.sh" ]; then
      cd "$dir/$1" && ./remove.sh && printf "%s config removed.\n" "$1"
      cd "$dir" || return 1
    else
      printf "%s cannot be removed using this script.\n" "$1"
    fi
    shift
  done
fi
printf "Config removal completed, thank you for using this script.\n"
