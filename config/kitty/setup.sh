#!/bin/sh
setup_kitty() {
  test -d "$HOME"/.config || mkdir -p "$HOME"/.config
  ln -sf "$PWD/kitty" "$HOME/.config"
}
main() {
  if [ ! -d "$HOME"/.config/kitty ]; then
    setup_kitty
  elif [ -d "$HOME"/.config/kitty ] && [ ! -L "$HOME"/.config/kitty ]; then
    mv "$HOME"/.config/kitty "$HOME"/.config/kitty.bak
    printf "Your Kitty config have been backed up in kitty.bak.\n"
    setup_kitty
  else
    printf "Kitty is already setup, quitting\n"
  fi
  exit 0
}
main "$@"
