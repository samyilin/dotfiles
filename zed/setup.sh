#!/bin/sh

config_path="$HOME"/.config
setup_zed() {
  test -d "$config_path" || mkdir -p "$config_path"
  ln -sf "$PWD"/zed "$config_path"
}
main() {
  if [ ! -d "$config_path"/zed ]; then
    setup_zed
  elif [ -d "$config_path"/zed ] && [ ! -L "$config_path"/zed ]; then
    mv "$config_path"/zed "$config_path"/zed.bak
    printf "Your zed config have been backed up in zed.bak.\n"
    setup_zed
  else
    printf "zed is already setup, quitting\n"
  fi
  return 0
}
main "$@"
