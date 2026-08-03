#!/bin/sh
. "$(dirname "$0")"/../common.sh
dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)
setup_pyenv_virtualenv() {
  pyenv install 3.12
  pyenv virtualenv 3.12 neovim
  pyenv global neovim
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  pyenv activate neovim
  pip install -r "$dir"/requirement.txt
  pyenv deactivate
  printf "Pyenv venv installation complete.\n"
}
setup_uv_virtualenv() {
  uv python install
  uv venv "$dir"/neovim
  . "$dir"/neovim/bin/activate
  uv pip install -r "$dir"/requirement.txt
  uv tool install jupytext
  uv tool update-shell
  deactivate

  printf "UV venv installation complete.\n"
}
setup_nvim() {
  link_config "$PWD/nvim" "$HOME/.config/nvim"
}

main() {
  setup_nvim
  if [ -d "$HOME"/.pyenv ] && [ ! -f "$HOME"/.pyenv/versions/neovim/bin/python ]; then
    setup_pyenv_virtualenv
  elif [ -d "$HOME"/.local/share/uv ] && [ ! -f "$dir"/neovim/bin/python ]; then
    setup_uv_virtualenv
  fi
  return 0
}
main "$@"
