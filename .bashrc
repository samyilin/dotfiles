#!/bin/bash
##################################################################
# This is my personal bash profile section, nothing to see here.
# stops bash execution if it runs into errors.
set -e
# loads bash if it's present
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi
# launch emacs in server mode if it's not running. If it gives an error, would echo and quit
if ! pgrep -x "emacs" > /dev/null
then
    emacs --daemon || echo 'emacs is not installed in your system, quitting'
fi
