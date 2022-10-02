#!/bin/bash

# Sets up bash profile, vimrc and more. WIP
# Target endstate: Have some flags to get the config files, and some hints/help the user to set up their system, hopefully.
# Right now only CLI is considered here. If needed, can try to add some GUI setup here?
# quit script if error occurs
set -e
# go into home dir, if not already
cd ~
# copy bashrc and bash aliases in.
echo "This program is not meant to be used repetitively."
echo "if some programs weren't installed during initial setup, go to this repository's "
echo "subfolder with the programs' name to execute the appropriate setup file."
touch .profile && mv -f .profile .profile.bak
touch .bashrc && mv -f .bashrc .bashrc.bak

ln -sf "$PWD/.profile" "$HOME/.profile"
ln -sf "$PWD/.bashrc" "$HOME/.bashrc"

for i in vim lynx gh git tmux docker podman iam; do
  cd $i && ./setup
  cd -
done

if ! command -v tmux &> /dev/null; then
    echo 'tmux is not installed, quitting'
else
    cp dotfiles/.tmux.conf ~/.tmux.conf
fi
