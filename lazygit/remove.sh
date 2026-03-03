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
unlink_config "$config_path/lazygit"
