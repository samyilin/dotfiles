#!/bin/sh
setup_lazygit() {
  test -d "$HOME"/.config || mkdir -p "$HOME"/.config
  ln -sf "$PWD/lazygit" "$HOME/.config"
}
main() {
  if [ ! -d "$HOME"/.config/lazygit ]; then
    setup_lazygit
  elif [ -d "$HOME"/.config/lazygit ] && [ ! -L "$HOME"/.config/lazygit ]; then
    mv "$HOME"/.config/lazygit "$HOME"/.config/lazygit.bak
    printf "Your lazygit config have been backed up in lazygit.bak.\n"
    setup_lazygit
  else
    printf "lazygit is already setup, quitting\n"
  fi
  exit 0
}
main "$@"
