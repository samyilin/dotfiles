#!/bin/sh
main() {
  if [ ! -f "$HOME"/.tmux.conf ]; then
    ln -sf "$PWD"/.tmux.conf "$HOME"/.tmux.conf
    echo "tmux config done,quitting"
    exit 0
  elif [ -f "$HOME"/.tmux.conf ] && [ ! -L "$HOME"/.tmux.conf ]; then
    mv "$HOME"/.tmux.conf "$HOME"/.tmux.conf.bak
    echo "Your .tmux.conf have been saved to .tmux.conf.bak"
    ln -sf "$PWD"/.tmux.conf "$HOME"/.tmux.conf
  else
    printf "Tmux config is already installed, quitting"
  fi

  exit 0
}
main "$@"
