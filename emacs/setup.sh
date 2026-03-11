#!/bin/sh
. "$(dirname "$0")"/../common.sh
link_config "$PWD/.emacs.d" "$HOME/.emacs.d"
if [ "$(uname -s)" = "Darwin" ] && has brew; then
  link_config "$PWD/emacs-plus" "$HOME/.config/emacs-plus"
  printf "Emacs plus patch installec, consider reinstalling emacs plus. \n"
fi
