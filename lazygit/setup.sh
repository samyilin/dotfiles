#!/bin/sh

system="$(uname -srm)"
case ${system%% *} in
Darwin)
  config_path="$HOME"/Library/Application\ Support
  ;;
*)
  config_path="$HOME"/.config
  ;;
esac
## Macos config path is different. Why?
setup_lazygit() {
  test -d "$config_path" || mkdir -p "$config_path"
  ln -sf "$config_path"/lazygit "$config_path"
}
main() {
  if [ ! -d "$config_path"/lazygit ]; then
    setup_lazygit
  elif [ -d "$config_path"/lazygit ] && [ ! -L "$config_path"/lazygit ]; then
    mv "$config_path"/lazygit "$config_path"/lazygit.bak
    printf "Your lazygit config have been backed up in lazygit.bak.\n"
    setup_lazygit
  else
    printf "lazygit is already setup, quitting\n"
  fi
  exit 0
}
main "$@"
