#!/bin/bash
# I don't use a huge amount of aliases, only 2 at the moment.
#
# emacs is set so that any displayed emacs window we see are actually
# client, so that they could load faster.
# optional, but can be enabled if you are using emacs

# if [ -x emacs ] && pgrep emacs >/dev/null; then
#   alias emacs='emacsclient -c -e "(fancy-startup-screen)"'
# fi
if [ -f "$HOME"/.pyenv/versions/poetry/bin/poetry ]; then
  alias poetry="/Users/yilinwu/.pyenv/versions/poetry/bin/poetry"
fi
# Add this for WSL corporate desktop. There's annoyance on corporate Windows.
if [ -d /proc ]; then
  version="$(cat /proc/version)"
  case "$version" in
  *microsoft*)
    alias network="sudo chattr -i /etc/resolv.conf && sudo vim /etc/resolv.conf && sudo chattr +i /etc/resolv.conf"
    ;;
  **) ;;
  esac
fi
