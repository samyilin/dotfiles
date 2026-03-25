#!/bin/sh
dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)
. "$(dirname "$0")"/../common.sh
unlink_config "$HOME/.config/nvim"
rm -rf "$HOME"/.cache/nvim "$HOME"/.local/share/nvim "$HOME"/.local/state/nvim
if [ -d "$HOME"/.pyenv ] && [ -f "$HOME"/.pyenv/versions/neovim/bin/python ]; then
  pyenv uninstall neovim
elif [ -d "$HOME"/.local/share/uv ] && [ -f "$HOME"/dotfiles/nvim/neovim/bin/python ]; then
  rm -rf "$HOME"/dotfiles/nvim/neovim
  uv tool uninstall jupytext
fi
