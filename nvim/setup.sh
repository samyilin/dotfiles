#!/bin/sh
. "$(dirname "$0")"/../common.sh
link_config "$PWD/kitty" "$HOME/.config/kitty"
setup_pyenv_vurtualenv() {
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
setup_uv_virtualenv() {
  uv python install
  uv venv neovim
  . "$HOME"/dotfiles/nvim/neovim/bin/activate
  uv pip install -r "$HOME"/dotfiles/nvim/requirement.txt
  uv tool install jupytext
  uv tool update-shell
  deactivate

  printf "UV venv installation complete."
}
setup_nvim() {
  link_config "$PWD/nvim" "$HOME/.config/nvim"
}

main() {
  setup_nvim
  if [ -d "$HOME"/.pyenv ] && [ ! -f "$HOME"/.pyenv/versions/neovim/bin/python ]; then
    setup_python_virtualenv
  elif [ -d "$HOME"/.local/share/uv ] && [ ! -f "$HOME"/dotfiles/nvim/neovim/bin/python ]; then
    setup_python_virtualenv_uv
  fi
  return 0
}
main "$@"
