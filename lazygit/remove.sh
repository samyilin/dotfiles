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

dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)

unlink_config "$config_path/lazygit"

if [ -L "$dir/lazygit/config.yml" ]; then
  target=$(readlink "$dir/lazygit/config.yml")
  rm "$dir/lazygit/config.yml"
  printf "Removed lazygit pager config symlink.\n"
  if [ "$target" = "delta_config.yml" ]; then
    git config --global --unset core.pager
    git config --global --unset interactive.diffFilter
    git config --global --remove-section delta 2>/dev/null
    git config --global --unset merge.conflictStyle
    printf "Removed delta git global config.\n"
  fi
fi
