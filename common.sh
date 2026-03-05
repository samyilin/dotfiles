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
