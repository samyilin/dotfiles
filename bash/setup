#!/bin/sh
# function to setup bash.
# There's a lot of room for improvement here. Potentially, we can update
# this function and wrap case-ifs into a function and call that with
# arguments.
main() {
  dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)
  if [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME"/.bashrc ]; then
    while IFS= read -r line; do
      if [ "$line" = ". ""$dir""/.bashrc.custom" ]; then
        added=1
        printf "custom .bashrc already exists and is set up.\n"
      fi
    done <"$HOME/.bashrc"
    if [ "${added-0}" -eq 0 ]; then
      printf "\n. %s/.bashrc.custom\n" "$dir" >>"$HOME"/.bashrc
    fi
    printf ".bashrc setup complete.\n"
  elif [ ! -f "$HOME"/.bashrc ]; then
    cp "$dir"/.bashrc "$HOME"/.bashrc
    printf "\n. %s/.bashrc.custom\n" "$dir" >>"$HOME"/.bashrc
  fi
  # force .bash_profile to read .profile. Avoids dup code and avoids
  # .profile not being read.
  if [ -f "$HOME"/.bash_profile ] && [ ! -L "$HOME"/.bash_profile ]; then
    while IFS= read -r line; do
      if [ "$line" = ". $HOME/.profile" ]; then
        added=1
        printf ".bash_profile already exists and is set up.\n"
      fi
    done <"$HOME/.bash_profile"
    if [ "${added-0}" -eq 0 ]; then
      printf "\n. %s/.profile\n" "$HOME" >>"$HOME"/.bash_profile
    fi
  elif [ ! -f "$HOME"/.bash_profile ]; then
    cp "$dir"/.bash_profile "$HOME"/.bash_profile
    printf "\n. %s/.profile\n" "$HOME" >>"$HOME"/.bash_profile
  fi
  printf ".bash_profile is setup.\n"
  # Sets up .inputrc. It is only used by GNU Bash.
  if [ -f "$HOME"/.inputrc ] && [ ! -L "$HOME"/.inputrc ]; then
    mv "$dir"/.inputrc "$HOME"/.inputrc.bak
    printf "your default .inputrc is backed up at %s/.inputrc.bak\n" ".inputrc" "$HOME"
  fi
  ln -sf "$dir"/.inputrc "$HOME"/.inputrc
  printf ".inputrc setup complete.\n"
}
main "$@"
