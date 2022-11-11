#!/bin/bash
# If not running interactively, don't do anything
case $- in
        *i*) ;;
        *) return;;
esac

# This bashrc does one thing only, referencing the actual bashrc config
if [ -f $HOME/.bashrc.personal ]; then
  . $HOME/.bashrc.personal
fi
if [ -f $HOME/.bash_aliases ]; then
  . $HOME/.bash_aliases
fi
