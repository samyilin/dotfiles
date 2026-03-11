#!/bin/sh
# Shared utility functions for dotfiles setup and removal.

# Creates a symlink from $1 (source) to $2 (destination), backing up
# any existing non-symlink file or directory at the destination.
link_config() {
  src="$1"
  dest="$2"
  name="$(basename "$dest")"
  if [ -L "$dest" ]; then
    printf "%s is already set up, skipping.\n" "$name"
    return 0
  fi
  if [ -e "$dest" ]; then
    mv "$dest" "$dest.bak"
    printf "Your %s config has been backed up to %s.bak\n" "$name" "$name"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -sf "$src" "$dest"
  printf "%s config done.\n" "$name"
}

# Removes a symlink at $1, restoring any .bak backup if present.
unlink_config() {
  dest="$1"
  name="$(basename "$dest")"
  if [ -L "$dest" ]; then
    rm "$dest"
    if [ -e "$dest.bak" ]; then
      mv "$dest.bak" "$dest"
      printf "Restored %s config from backup.\n" "$name"
    else
      printf "Removed %s config.\n" "$name"
    fi
  else
    printf "%s is not a symlink, skipping.\n" "$name"
  fi
}
# Helper to determine if a certain required program is missing from user
# setup. Checks if the command/program exists and if is an executable.
# This is more POSIX compliant than "which" or "type" in shell scripts.
has() {
  # if it is not an executable, then search in aliases to see if it's an
  # alias. If it's an alias, then it can be configured.
  case "$(type "$1" >>/dev/null 2>&1)" in
  *alias*) return 0 ;;
  *) ;;
  esac
  command -v "$1" >>/dev/null 2>&1 && test -x "$(command -v "$1")" >>/dev/null 2>&1 && return 0 || return 1
}
