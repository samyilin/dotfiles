#!/bin/sh
# setup .profile. Chances are, you would at least want to set up
# .profile. Use profile.d to store aliase and other things that are not
# bash-specific setup.
main() {
  dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)
  profile_default=". ""$dir""/.profile.default"
  if [ -f "$HOME/.profile" ] && [ ! -L "$HOME"/.profile ]; then
    while IFS= read -r line; do
      if [ "$line" = "$profile_default" ]; then
        added=1
        printf "custom .profile already exists and is set up.\n"
      fi
    done <"$HOME/.profile"
    if [ "${added-0}" -eq 0 ]; then
      printf "\n%s\n" "$profile_default" >>"$HOME"/.profile
    fi
    printf ".profile setup complete.\n"
  elif [ ! -f "$HOME"/.profile ]; then
    cp "$dir"/.profile "$HOME"/.profile
    printf "\n%s\n" "$profile_default" >>"$HOME"/.profile
  fi
}
main "$@"
