#!/bin/bash

# Sets up bash profile, vimrc and more. WIP
# Target endstate: Have some flags to get the config files, and some hints/help the user to set up their system, hopefully.
# quit script if error occurs
set -e
# go into home dir, if not already
cd ~
# copy bashrc and bash aliases in.
echo "This program is not meant to be used repetitively."
echo "if some programs weren't installed during initial setup, go to this repository's "
echo "subfolder with the programs' name to execute the appropriate setup file."
sleep 3
# if there's existing .profile, then move it to a backup
find .profile 2>/dev/null && mv -f .profile .profile.bak
find .bashrc 2>/dev/null && mv -f .bashrc .bashrc.bak

ln -sf "$PWD/.profile" "$HOME/.profile"
ln -sf "$PWD/.bashrc" "$HOME/.bashrc"

for i in vim gh git tmux; do
  cd $i && ./setup
  cd -
done
