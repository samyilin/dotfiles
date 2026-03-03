#!/bin/sh

config_path="$HOME"/.config
setup_yazi() {
  test -d "$config_path" || mkdir -p "$config_path"
  ln -sf "$PWD"/yazi "$config_path"
}
main() {
  if [ ! -d "$config_path"/yazi ]; then
    setup_yazi
  elif [ -d "$config_path"/yazi ] && [ ! -L "$config_path"/yazi ]; then
    mv "$config_path"/yazi "$config_path"/yazi.bak
    printf "Your yazi config have been backed up in yazi.bak.\n"
    setup_yazi
  else
    printf "yazi is already setup, quitting\n"
  fi
  return 0
}
main "$@"
