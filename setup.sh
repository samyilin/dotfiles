#!/bin/sh
# Sets up bash profile, vimrc and more.
# Helper to determine if a certain required program is missing from user
# setup. Checks if the command/program exists and if is an executable.
# This is more POSIX compliant than "which" or "type" in shell scripts.
has() {
  # if it is not an executable, then search in aliases to see if it's an
  # alias. If it's an alias, then it can be configured.
  case "$(type "$1" >>/dev/null 2>&1)" in
  *alias*) return 0 ;;
  *) ;;
  esac
  command -v "$1" >>/dev/null 2>&1 && test -x "$(command -v "$1")" >>/dev/null 2>&1 && return 0 || return 1
}
# Other setups exist in their own folders. This script checks for
# existence of the program to be installed before calling the
# appropriate scripts.
setup() {
  if [ "$1" != profile ]; then
    if has "$1"; then
      # special logic to handle vim full version detection. Vim without
      # full version cannot  cannot leverage its true potential.
      # vim-plug.vim also needs git to function.
      if [ "$1" = vim ]; then
        if ! has vimtutor; then
          printf "Full vim is not installed, quitting vim setup.\n"
          printf "Vim won't be installed by nix to avoid name collision.\n"
          return 1
        elif ! has git; then
          printf "git is required for vim install, quitting. \n"
          return 1
        fi
      elif [ "$1" = alacritty ] && ! has git; then
        printf "git is required for alacritty theme install, quitting. \n"
        return 1
      # Setup vim alongside nvim, because our nvim config is back
      # compatible with vim
      elif [ "$1" = nvim ]; then
        cd vim && ./setup.sh "$2" && printf "%s setup complete.\n" "vim" && cd "$dir" || printf "%s setup complete.\n" "vim"
      fi
    elif [ "$1" = lazygit ] && ! has difft; then
      printf "Lazygit config is unnecessary if difftastic is not installed, quitting. \n"
    else
      printf "%s is not installed in your system, quitting.\n" "$1"
      return 1
    fi
    printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
    printf "Initializing %s setup.\n" "$1"
  fi
  # set up config for programs.
  cd "$1" && ./setup.sh "$2" && printf "%s setup complete.\n" "$1" || printf "%s setup failed.\n" "$1"
  sleep 1
  cd "$dir" || return 1
}
init_user() {
  printf "Script detected that you are running as root.\n"
  printf "This script will set your user as an administrator.\n"
  printf "and help you setup password.\n"
  name="you"
  printf "Preferred User Name (%s): \n" "${name}"
  printf "Please use alphanumerical characters and no whitespace.\n"
  while true; do
    read -r val
    case "$val" in
    *\ *) printf "Username cannot contain space, try again.\n" ;;
    "") printf "No input was given, please try again.\n" ;;
    **) break ;;
    esac
  done <"/etc/shells"
  test -n "${val}" && name="${val}"
  unset "$val"
  shell="/bin/sh"
  printf "Installed shells are:\n\n"
  cat /etc/shells
  printf "Please enter your preferred interactive shell: \n"
  while true; do
    read -r val
    while IFS= read -r line; do
      if [ "$val" = "$line" ]; then
        shell="$val"
        break
      fi
    done
    printf "%s is not an available shell. Please type shell's full path.\n" "$val"
  done
  test -n "${val}" && shell="${val}"
  unset "$val"
  # dirty way to set admin priviledge to user. Don't like it, but will
  # have to optimize later.
  adduser -G wheel "$name" -s "$shell" >/dev/null 2>&1 || adduser -G sudo "$name" -s "$shell" >/dev/null 2>&1
  # Endlessly prompt for password until password matches. Could use
  # cracklib to enforce/recommend better password, but at this year this
  # should be common knowledge.
  until passwd "$name"; do :; done
  # make user's home dir
  test -d "/home/$name" || mkdir "/home/$name"
  # CAREFUL! This is for WSL only.
  # Make sure you know what you are doing, and your install contains SYSTEMD
  # and your WSL version supports systemd!!!
  case "$(uname -r)" in
  *microsoft*)
    printf "\n[user]\ndefault = %s\n" "$name" >>/etc/wsl.conf
    has systemctl && printf "\n [boot]\nsystemd=true\n" | tee -a /etc/wsl.conf
    ;;
  esac
  # change home folder's ownership so default user can have rwx access
  # to it.
  chown -R "${name}:wheel" "/home/$name" >/dev/null 2>&1 || chown -R "${name}:sudo" "/home/$name" >/dev/null 2>&1
}
print_help() {
  printf "Usage: ./setup [options] [programs to set up]\n"
  printf "Available options:\n"
  printf "  -h: prints this help document\n"
  printf "  -d: default/docker mode. Do not prompt user for input.\n"
  printf "      Useful for default or non-interactive setup.\n"
  printf "Available programs to set up:\n"
  printf "if no argument given, all programs will be set up.\n"
  printf "  bash: Basic customization for Bash interactive shell\n"
  printf "  profile: basic shell startup\n"
  printf "  vim: Command Line Interface Editor\n"
  printf "  git: Modern VCS Tool for Programmers\n"
  printf "  tmux: Terminal/CLI Multiplexer\n"
  return 0
}
main() {
  # handles options/getopts. Currently supports -h for print help and -d
  # for default/docker install mode.
  while getopts "hd" opt; do
    case "$opt" in
    h)
      print_help
      exit 0
      ;;
    d) default=1 ;;
    *)
      print_help
      exit 1
      ;;
    esac
    shift
  done
  # Default variable has value no matter what.
  default=${default-0}
  # Safe way to ensure we have current working directory correctly.
  dir=$(cd -- "$(dirname -- "$0")" >>/dev/null 2>&1 && pwd)
  cd "$dir" || exit 0
  # non-default mode logic.
  if [ "$default" -eq 0 ]; then
    # in non-default mode, if user is running as root, help user set up
    if [ "$(id -u)" -eq 0 ]; then
      if (has useradd || has adduser) && has passwd; then
        setup_user
        # after successfully setting up the user, re-execute this script
        # under the user's new credential.
        exec su - "$name" -C "$dir/setup"
      else
        printf "You are running as root but your setup doesn't have useradd/adduser or passwd.\n"
        printf "Configs will be set to /root directory for now.\n"
      fi
    fi
  fi
  # default mode and non-default, root user.
  name=${name-${USER-$(whoami)}}
  if [ $# -eq 0 ]; then
    for i in "$dir"/*; do
      i="${i%*/}"
      i="${i##*/}"
      if [ -d "$i" ] && case "$i" in misc*) false ;; install*) false ;; config) false ;; *) true ;; esac then
        setup "$i" "$default"
      fi
    done
  else
    while [ $# -gt 0 ]; do
      case "$1" in
      *)
        if [ -d "$dir"/"$1" ]; then
          setup "$1" "$default"
        else
          printf "%s cannot be configured using this script." "$1"
          exit 1
        fi
        ;;
      esac
      shift
    done
  fi
  printf "Setup complete, thank you for using this script.\n"
  sleep 1
  if [ "$default" -eq 1 ] && [ "$name" != "$USER" ]; then
    exec su - "${name}"
  else
    . "$HOME"/.profile
  fi
}
main "$@"
