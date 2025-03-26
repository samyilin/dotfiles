#!/bin/sh
setup_python_virtualenv() {
  pyenv install 3.12
  pyenv virtualenv 3.12 neovim
  pyenv global neovim
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  pyenv activate neovim
  pip install -r "$HOME"/dotfiles/nvim/requirement.txt
  pyenv deactivate
  printf "Pyenv venv installation complete."
}
setup_nvim() {
  test -d "$HOME"/.config || mkdir -p "$HOME"/.config
  dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)
  for i in "$dir"/*; do
    i="${i%*/}"
    i="${i##*/}"
    if [ -d "$i" ] && case "$i" in neovim*) false ;; *) true ;; esac then
      if [ -d "$HOME"/.config/"$i" ] && [ ! -L "$HOME"/.config/"$i" ]; then
        mv "$HOME"/.config/"$i" "$HOME"/.config/"$i".bak
        printf "Your Neovim config have been backed up in nvim.bak.\n"
      elif [ ! -d "$HOME"/.config/"$i" ]; then
        ln -sf "$PWD"/"$i" "$HOME/.config"
        printf "%s config has been installed.\n" "$i"
        printf "Please check .bashrc.custom to see if it is properly aliased and nvims function works.\n"
      else
        printf "%s config is already installed.\n" "$i"
      fi
    fi
  done
}

setup_python_virtualenv_uv() {
  uv python install
  uv venv neovim
  . "$HOME"/dotfiles/nvim/neovim/bin/activate
  uv pip install -r "$HOME"/dotfiles/nvim/requirement.txt
  uv tool install jupytext
  uv tool update-shell
  deactivate

  printf "UV venv installation complete."
}
main() {
  setup_nvim
  if [ -d "$HOME"/.pyenv ] && [ ! -f "$HOME"/.pyenv/versions/neovim/bin/python ]; then
    setup_python_virtualenv
  elif [ -d "$HOME"/.local/share/uv ] && [ ! -f "$HOME"/dotfiles/nvim/neovim/bin/python ]; then
    setup_python_virtualenv_uv
  fi
  exit 0
}
main "$@"
