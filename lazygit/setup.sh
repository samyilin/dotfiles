#!/bin/sh
. "$(dirname "$0")"/../common.sh

system="$(uname -srm)"
case ${system%% *} in
Darwin)
  config_path="$HOME/Library/Application Support"
  ;;
*)
  config_path="$HOME/.config"
  ;;
esac
link_config "$PWD/lazygit" "$config_path/lazygit"
