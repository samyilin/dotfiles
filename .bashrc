##################################################################
# This is my personal bash profile section, nothing to see here.
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi
# launch emacs in server mode if it's not running
if ! pgrep -x "emacs" > /dev/null
then
    emacs --daemon || echo 'emacs is not installed in your system, quitting'
fi
