# README

This is my dotfile. Usable both as a standalone Git repository or work in a
Docker environment.

This repo has 2 purposes:

1. This is my personal dotfile. I do try to make it as distro/OS-agnostic as
   possible though.

2. To be able to run development container(s). This is not a priority.

## Design Principles

1. Do not overwrite existing configuration if there were any. This is
   because sometimes various configurations are already present when you
   start to configure.

2. Leave shell config for programs to abuse. These are sourced rather
   than linked.

3. Use links for customizations that won't have a default configuration
   at all, at least not in the user context.

4. Make sure it (this config) is easy to delete. After deleting this config,
   you should have a default (or non-existent) config.

   Keep in mind that removing this config won't help you uninstall packages
   such as vim, emacs, etc. This is the job of your package manager.

5. Make it modular. Scripts/configs for each program are be separated by
   folder to make maintenance easier.

6. Make it so that using setup script(s) repeatedly will skip the parts that's
   already been set up.

7. Make it as simple and cross-platform as possible. What does cross-platform
   even mean? Hard to tell these days. But I choose POSIX shell for now.

## Assumptions

There're very few assumptions here, not in any particular order:

1. You are running a UNIX-ish system.

2. You would prefer to have more than 1 ssh setup if needed. Separation of work
   and life account is typically needed, amongst other reasons.

3. At least you have Busybox or similar minimal environment.

## Non-assumptions

1. You have bash as your interactive shell. If you don't have bash in
   your system, then .profile is loaded only assuming a POSIX shell
   would be used.. If you do use bash, then:

   1. .bash_profile is loaded, and it will load .profile.
   2. .profile does what it's supposed to do, and load in .bashrc.

   This is to ensure that .profile will be loaded no matter what.

## Goals/Programs configuring in this setup?

Bash, Vim, Neovim, tmux, SSH, git. A "complete" CLI working environment.

These days I dabble in Zed, etc., so whatever other configurable
programs.

This script can also helps you set up your user name and password where applicable.
Good for initializing things on WSL or other root systems.

Bash for interactive shell, Vim/Neovim for text editor, tmux for screen
multiplexer, ssh and git could work together or separately.

SSH setup script here is a wrapper to allow users to set up git and SSH so we
can SSH into git repos easier, and nothing else.

## Non-goals?

1. dircolors. I realize they exist, I just don't care about them enough to
   write one.

2. Zsh or fish. I try to minimize working directly within shell CLI  because
   nowadays I live in Vim/Neovim/Emacs whenever possible. So I don't even
   heavily rely on Bash at all.

3. IDEs/Full programming environment setup.

## Setup

There's 2 ways to set up this config.

1. Using this dotfile on an existing install. In other words, not a container
   setup.

   To pull this repo to your OS:

   ```bash
   cd $HOME git clone https://github.com/samyilin/dotfiles.git
   ```

   To set up everything:

   ```sh
   cd $HOME/dotfiles ./setup && . "$HOME"/.profile
   ```

   To setup additional programs after initial setup, i.e. your initial setup
   did not install vim but now it does, do

   ```sh
   cd $HOME/dotfiles ./setup YOUR_PROGRAM
   ```

   Design principles above will make sure no repeated install would happen.

   To get the latest from this setup, do

   ```sh
   cd $HOME/dotfiles git pull
   ```

   If you want to remove this config:

   ```sh
   cd $HOME/dotfiles ./remove && . "$HOME"/.bash_profile
   ```

   If you want to remove config for a certain program, i.e. vim, then

   ```sh
   cd $HOME/dotfiles ./remove YOUR_PROGRAM
   ```

   To remove this repo from your setup altogether, do

   ```sh
   rm -rf $HOME/dotfiles
   ```

   Additional mode:
   Docker/default mode. Skips over interactive mode that the user need to
   intervene, i.e. setting up username/password, git and ssh. This is the
   default on Docker setup. More about this below.

   To install using non-interactive mode:

   ```sh
   cd $HOME/dotfiles ./setup -d
   ```

2. Using this dotfile to setup a docker/podman image. This is good for
   developing in a container and avoid "dependency hell."

   To use this method, you would need to install docker or podman on your
   setup. I would suggest podman.

   I have 3 Dockerfile here, one Ubuntu based (more stable-ish, although I use
   the latest Ubuntu release), one Fedora rawhide based (cutting-edge, good for
   testing latest software) and one Archlinux based (bleeding-edge, good for
   testing development software)

   Using the appropriate Dockerfile name, the below code would generate a
   docker image:

   ```sh
   cd $HOME git clone https://github.com/samyilin/dotfiles cd dotfiles
   docker build -f Dockerfile.DISTRO -t IMAGE_NAME
   ```

   Podman requires using buildah to build image, so:

   ```sh
   cd $HOME git clone https://github.com/samyilin/dotfiles cd dotfiles
   buildah build -f Dockerfile.DISTRO -t IMAGE_NAME
   ```

   To enter this image, use

   ```sh
   docker run -it --rm localhost/IMAGE_NAME
   ```

   On podman, use

   ```sh
   podman run -it --rm localhost/IMAGE_NAME
   ```

   Default container/docker install would not help you set up ssh and git.
   These belong in your host system so you don't have to reset your ssh every
   time you spin up a container. To mount host's ssh and git configurations,
   use something like

   ```sh
   docker run -it --rm -v $HOME/.ssh:$HOME/.ssh \ -v $HOME/.gitconfig
   $HOME/.gitconfig \ localhost/IMAGE_NAME

   ```

   You can use a similar process to mount your git repo to the container so you
   don't have to keep copying your repo over. Writing a basic Bash script for
   this is trivial and won't be covered here.

## Systems Tested

I've tested this setup in Alpine, Arch, Ubuntu and Fedora Linux containers.
Also MacOS. I would try this in VMs one day.

Will try to test this on BSD VMs one day.

## Misc

If you really want the greybeards' power tools, read up [The
Grymoire](https://www.grymoire.com/index.html). This is a series of
practical guide for Unix/Linux tools that is actually pleasant to read,
unlike the [POSIX standard
specification](https://pubs.opengroup.org/onlinepubs/9699919799/) (which you
have to read if you found Grymoire not clear enough).

## WSL Notes

Windows is such a pain to work with when it comes to WSL. A part of the
reason is because WSL2 is a virtual machine, so network/internet access
becomes a problem, especially when under corporate network.

I have 1 alias called "netowrk" in .bash_aliases that address the DNS
forwarding problem in corporate network, but still has SSL certification
problem when using Git (Git itself or package managers who use git) or
anything that uses opensssl. Here's the actual fix, don't disable SSL
globally to try to fix this:

[Reference](https://stackoverflow.com/questions/72167566/wsl-docker-curl-60-ssl-certificate-problem-unable-to-get-local-issuer-certi) here:
Basically:

1. run certmgr.msc.
2. go to Trusted Root Certification Authorities\Certifiactes
3. Find entries here that has certificate template of "CA"
4. Export them to a folder using DER coded x.509, call it whatever.
   cert.cer for example.
5. Use the below code:

```sh
openssl x509 -inform DER -in /mnt/d/cert.cer -out ./eset.crt
```

If under Ubuntu, do

```sh
sudo cp eset.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

If under [Arch](https://wiki.archlinux.org/title/User:Grawity/Adding_a_trusted_CA_certificate), do

```sh
sudo trust anchor --store ~/cert.crt
```

## Macos Notes

Some packages are essential for CLI in a modern MacOS system, including
my own setup.

There're some particularities about MacBook setup.

Documenting all of them here.

### 1. Neovim requirements

Neovim requires:

1. tree-sitter-cli
2. rustup from its own installation script (not in Homebrew)
3. ripgrep (regex finder)
4. imagemagick (for image display, if you need it)
5. mmdc (for mermaid rendering, if you need it)
6. latex suite (for latex rendering, if you need it)
7. fd
8. lazygit delta (for now)

### 2. Neovim LS + formatter requirements

1. lua-language-server stylua
2. shfmt shellcheck
3. sqlfluff

### 3. other requirements

1. pyenv or uv for Python dev (whatever else for formatter, etc.,
   depending on repo setup, etc.)
2. starship for prompt
3. bash, bash-completion and git (for up-to-date modern packages)
4. vim and neovim
5. A good font (maple for now, have Chinese support)
6. A modern terminal (ghostty/kitty for me)

### 4. List xcode-select tools

```sh
ls "$(xcode-select --print-path)/usr/bin"
```

## 5. Setting default bash to Homebrew bash

```sh
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/bash"

```

## 6. Making sure that homebrew packages are used first in bash scripts

Also, coreutils would alias all their installs with a g (ggrep instead
of grep), so make sure you adjust any script to use to use those. This
is within my .profile.

```sh
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
```

## 6. Homebrew shenanighan

This specific package manager I have to use everyday, documenting some
common commands here.

```sh
# turn off analytics
brew analytics off
# Uninstall formulae that were only installed as a dependency of another
# formula and are now no longer needed.
brew autoremove
# perform cleanup
brew cleanup
# debug potential problems
brew doctor
# list all 'independent' formulae
brew link
# check for missing dependencies
brew missing
# homebrew can enable background services using launchctl
brew services
```
