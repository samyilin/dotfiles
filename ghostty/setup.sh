#!/bin/sh

config_path="$HOME"/.config
setup_ghostty() {
  test -d "$config_path" || mkdir -p "$config_path"
  ln -sf "$config_path"/ghostty "$config_path"
}
main() {
  if [ ! -d "$config_path"/ghostty ]; then
    setup_ghostty
  elif [ -d "$config_path"/ghostty ] && [ ! -L "$config_path"/ghostty ]; then
    mv "$config_path"/ghostty "$config_path"/ghostty.bak
    printf "Your ghostty config have been backed up in ghostty.bak.\n"
    setup_ghostty
  else
    printf "ghostty is already setup, quitting\n"
  fi
  exit 0
}
main "$@"
