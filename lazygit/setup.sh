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
has_difft=0
has_delta=0
command -v difft >>/dev/null 2>&1 && has_difft=1
command -v delta >>/dev/null 2>&1 && has_delta=1

if [ "$has_difft" -eq 1 ] && [ "$has_delta" -eq 1 ]; then
  if [ "${1-0}" -eq 0 ]; then
    printf "Both difft and delta are installed. Which pager would you like to use?\n"
    printf "1) difft\n"
    printf "2) delta\n"
    while true; do
      read -r choice
      case "$choice" in
      1 | difft)
        pager="difft"
        break
        ;;
      2 | delta)
        pager="delta"
        break
        ;;
      *) printf "Invalid choice, please enter 1 or 2.\n" ;;
      esac
    done
  else
    pager="difft"
  fi
elif [ "$has_difft" -eq 1 ]; then
  pager="difft"
elif [ "$has_delta" -eq 1 ]; then
  pager="delta"
else
  printf "Neither difft nor delta is installed, skipping pager config.\n"
fi

if [ -n "$pager" ]; then
  ln -sf "${pager}_config.yml" "$dir/lazygit/config.yml"
  printf "Lazygit pager set to %s.\n" "$pager"
  if [ "$pager" = "delta" ]; then
    git config --global core.pager delta
    git config --global interactive.diffFilter 'delta --color-only'
    git config --global delta.navigate true
    git config --global delta.side-by-side true
    git config --global merge.conflictStyle zdiff3
    printf "Git global config updated to use delta as pager.\n"
  fi
fi

link_config "$PWD/lazygit" "$config_path/lazygit"
