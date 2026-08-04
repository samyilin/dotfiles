#!/bin/sh

system="$(uname -srm)"
case ${system%% *} in
Darwin)
  # /opt/homebrew on Apple Silicon, /usr/local/Homebrew on Intel.
  if [ ! -d /opt/homebrew ] && [ ! -d /usr/local/Homebrew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    printf "Homebrew is already installed, quitting\n"
  fi
  ;;
*) printf "Not MacOS, won't install Homebrew for the user.\n" ;;
esac
