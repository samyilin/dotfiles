#!/bin/sh
main() {
  if [ ! -f "$HOME"/.wezterm.lua ]; then
    ln -sf "$PWD/.wezterm.lua" "$HOME/.wezterm.lua"
    # Per instruction here: https://wezfurlong.org/wezterm/config/lua/config/term.html
    tempfile=$(mktemp) &&
      curl -o "$tempfile" https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo &&
      tic -x -o ~/.terminfo "$tempfile" &&
      rm "$tempfile"
    echo "wezterm config done, quitting"
    exit 0
  fi
}
main "$@"
