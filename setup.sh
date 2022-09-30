#!/bin/bash

# Sets up bash profile, vimrc and more. WIP
# Target endstate: Have some flags to get the config files, and some hints/help the user to set up their system, hopefully.
# Right now only CLI is considered here. If needed, can try to add some GUI setup here?
set -e
# go into home dir, if not already
cd ~
# copy bashrc and bash aliases in. 
# If argument --bash_import_method (-b) equals 'append', imports bashrc in by checking for existence and appending it to its end if there's an existent bashrc. 
# This is the default behaviour.
# If argument --bash_import_method (-b) equals 'separate', check if there's an existing bashrc/bash_aliases, if there is, then add a line at the end to source this file as well.
# If argument --bash_import_method (-b) equals 'truncate', imports bashrc in by truncating .bashrc and .bash_aliases and importing files within this one as new one
# If argument --bash_import_method (-b) equals 'link', soft link bashrc and bash_aliases in before copying and preserving existent bashrc and bash_aliases, if any.
# Copy vimrc in.
# If Vim (not vi) is not installed, echo some message and quit
# If argument --vim_import_method (-v) equals 'no', do not import vim setup. 
# If argument --vim_import_method (-v) equals 'minimal', import vim-sensible's vim-sensible.vim and put that into home directory. Echo user to use this one (TBD)
# If argument --vim_import_method (-v) equals 'full', import everything from this setup and prompt user how to use vimrc.
# This is the default behaviour.
# If argument --vim_import_method (-v) equals 'IDE', get LSP and other goodies in there before making the user aware of it. Prompts the user that they could use Neovim, Emacs or VSCode as well.
if [ -f ~/.bashrc ]; then
    
    cat dotfiles/.bashrc >> .bashrc
else
    touch .bashrc && echo '#!/bin/sh' >> .bashrc && cat dotfiles/.bashrc >> .bashrc || echo Unknown Error, Check User Priviledge
fi
if [ -f ~/.bash_aliases ]; then
    cat dotfiles/.bash_aliases >> .bash_aliases
else
    touch .bash_aliases && echo '#!/bin/sh' >> .bash_aliases && cat dotfiles/.bash_aliases >> .bash_aliases || echo Unknown Error, Check User Priviledge
fi
if ! command -v tmux &> /dev/null
then
    echo 'tmux is not installed, do you wish to install it? Not installing it would '
    # prompt the user to say yes or no, then guess which system
    sudo dnf install tmux || sudo apt-get install 
else
    cp dotfiles/.tmux.conf ~/.tmux.conf
fi
