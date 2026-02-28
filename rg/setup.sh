#!/bin/sh

main() {
  if [ ! -f "$HOME"/.ripgreprc ]; then
    ln -sf "$PWD"/.ripgreprc "$HOME"/.ripgreprc
    printf "Ripgrep config done, quitting.\n"
  elif [ -f "$HOME"/.ripgreprc ] && [ ! -L "$HOME"/.ripgreprc ]; then
    mv "$HOME"/.ripgreprc "$HOME"/.ripgreprc.bak
    printf "Your .ripgreprc have been saved to .ripgreprc.bak"
    ln -sf "$PWD"/.ripgreprc "$HOME"/.ripgreprc
  else
    printf "Ripgrep is already installed, quitting.\n"
  fi

  return 0
}
main "$@"
