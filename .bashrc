#!/bin/bash
##################################################################
# This is my personal bash profile section, nothing to see here.
# launch emacs in server mode if it's not running

# If not running interactively, don't do anything
case $- in
        *i*) ;;
        *) return;;
esac
# launches emacs in server mode if not already running.
if ! pgrep -x "emacs" > /dev/null
then
    emacs --daemon > /dev/null || echo 'emacs is not installed in your system, quitting'
fi
if ! command -v neofetch &> /dev/null; then
    echo 'neofetch is not installed, quitting.'
else
  neofetch
fi

# Loads aliases after Emacs launch to avoid naming collision
# loads default bashrc existent on system if it's there
for file in ~/.{bash_aliases,bashrc.bak}; do
        if [[ -r "$file" ]] && [[ -f "$file" ]]; then
                # shellcheck source=/dev/null
                . "$file"
        fi
done
unset file

