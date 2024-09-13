# README

This is my dotfile. Usable both as a standalone Git repository or work in a
Docker environment as a development container.

This repo has 3 purposes:

1. This is my personal dotfile. I do try to make it as distro/OS-agnostic as
   possible though.

2. To force myself to learn shell programming, tmux configuration, etc.

3. To be able to run development container(s).

## Design Principles

1. Do not overwrite existing configuration. This is a common scenario in
   Linux/MacOS environments:

   1. Various configurations are already there when personal configuration
      begins. Some systems would create .bashrc in your home directory
      automatically.

   2. Programs love to spew lines to .bashrc or .profile, so they cannot be
      assumed to be static.

2. Leave shell config for programs to abuse. These are copied to home
   directory rather than linked.

3. Use links for customizations that are not related to application abuse.

4. Make sure it (this config) is easy to delete. After deleting this config,
   you should have a default or non-existent config.

   Keep in mind that removing this config won't help you uninstall packages
   such as vim, emacs, etc. This is the job of your package manager.

5. Make it modular. Scripts/configs for each program should be separated by
   folder to make maintenance easy.

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

1. You have bash as your interactive shell. If you don't have bash in your
   system, then .profile is loaded only. If you do use bash, then:

   1. .bash_profile is loaded, and it will load .profile.
   2. .profile does what it's supposed to do, and load in .bashrc.

   This is to ensure that .profile will be loaded no matter what.

## Goals/Programs configuring in this setup?

Bash, Vim, Neovim, tmux, SSH, git. A "complete" CLI working environment.

This script can also helps you set up your user name and password where applicable.
Good for initializing things on WSL or other root systems.

Bash for interactive shell, Vim/Neovim for text editor, tmux for screen
multiplexer, ssh and git could work together or separately.

SSH setup script here is a wrapper to allow users to set up git and SSH so we
can SSH into git repos easier, and nothing else.

## Non-goals/Programs Not Configuring in this setup?

1. dircolors. I realize they exist, I just don't care about them enough to
   write one.

2. Zsh or fish. I try to minimize working directly within shell CLI  because
   nowadays I live in Vim/Neovim/Emacs whenever possible. So I don't even
   heavily rely on Bash at all.

3. Emacs. It deserves its own config repo.

4. IDEs/Full programming environment setup?

   Try IntelliJ suite if that tickles your fancy. Or even Visual Studio.

## How to Set up and Use

There's 2 ways to set up this config.

1. Using this dotfile on an existing install. In other words, not a container
   setup.

   To pull this repo to your OS:

   ```bash
   cd $HOME git clone https://github.com/samyilin/dotfiles.git
   ```

   To set up everything:

   ```bash
   cd $HOME/dotfiles ./setup && . "$HOME"/.profile
   ```

   To setup additional programs after initial setup, i.e. your initial setup
   did not install vim but now it does, do

   ```bash
   cd $HOME/dotfiles ./setup YOUR_PROGRAM
   ```

   Design principles above will make sure no repeated install would happen.

   To get the latest from this setup, do

   ```bash
   cd $HOME/dotfiles git pull
   ```

   If you want to remove this config:

   ```bash
   cd $HOME/dotfiles ./remove && . "$HOME"/.bash_profile
   ```

   If you want to remove config for a certain program, i.e. vim, then

   ```bash
   cd $HOME/dotfiles ./remove YOUR_PROGRAM
   ```

   To remove this repo from your setup altogether, do

   ```bash
   rm -rf $HOME/dotfiles
   ```

   Additional mode:
   Docker/default mode. Skips over interactive mode that the user need to
   intervene, i.e. setting up username/password, git and ssh. This is the
   default on Docker setup. More about this below.

   To install using non-interactive mode:

   ```bash
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

   ```bash
   cd $HOME git clone https://github.com/samyilin/dotfiles cd dotfiles
   docker build -f Dockerfile.DISTRO -t IMAGE_NAME
   ```

   Podman requires using buildah to build image, so:

   ```bash
   cd $HOME git clone https://github.com/samyilin/dotfiles cd dotfiles
   buildah build -f Dockerfile.DISTRO -t IMAGE_NAME
   ```

   To enter this image, use

   ```bash
   docker run -it --rm localhost/IMAGE_NAME
   ```

   On podman, use

   ```bash
   podman run -it --rm localhost/IMAGE_NAME
   ```

   Default container/docker install would not help you set up ssh and git.
   These belong in your host system so you don't have to reset your ssh every
   time you spin up a container. To mount host's ssh and git configurations,
   use something like

   ```bash
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
