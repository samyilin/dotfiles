#!/bin/sh
##################################################################
# This is my personal bash profile section, nothing to see here.
# launch emacs in server mode if it's not running
if ! pgrep -x "emacs" > /dev/null
then
    emacs --daemon 2>&1 >> /dev/null || echo 'emacs is not installed in your system, quitting'
fi
# Loads aliases after Emacs launch to avoid naming collision
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

# loads default bashrc existent on system if it's there

find ~/.bashrc.bak >/dev/null && . ~/.bashrc.bak
