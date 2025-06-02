#!/bin/sh
main() {
  if [ ! -f "$HOME"/.gitconfig ]; then
    if [ "$1" -eq 0 ]; then
      printf "Type in your first and last name (no accent or special characters - e.g. 'ç'): \n"
      read -r full_name

      printf "Type in your email address (the one used for your work/life git account): \n"
      read -r email

      while true; do
        printf "Which editor would you like to use to edit git commit messages?\n"
        read -r edit
        if ! command -v "$edit" >>/dev/null 2>&1; then
          printf "Editor %s is not installed in your system, git commit editor is not set up properly.\n" "$edit"
        else
          git config --global core.editor "$edit"
          break
        fi
      done
      git config --global user.email "$email"
      git config --global user.name "$full_name"
      # Default to merge instead of rebase when pulling from master.
      git config --global pull.rebase false
      printf "Basic git setup done, quitting\n"
    else
      printf "Git configuration is skipped in non-default mode.\n"
    fi
  else
    printf "There's an existing .gitconfig file in your home directory, quitting.\n"
  fi
}
main "$@"
