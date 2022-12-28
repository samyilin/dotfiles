# README

This is my dotfile. Usable both as a standalone Git repository or work
in a Docker environment.

## Why?

This repo has 3 purposes:

1. This is my dotfile that is more or less personal. I do try to make it
   as distro/OS-agnostic as possible though, so opinionated setups will
   be of a less priority here.

2. To force myself to learn bash programming, tmux configuration and so
   much more. I had a less than perfect config before, so I use this
   project to motivate myself to learn more and live ( more or less) in
   the command line when it comes to coding or editing text. 


3. To have a containerized development environment. I want to try out
   projects or programming setups/tools without "polluting" my base
   setup and lead to "dependency hell". The hope is that this will serve
   as the base for future containerized development environments.
   

I do realize that [GNU Stow](https://www.gnu.org/software/stow/),
[chezmoi](https://www.chezmoi.io/) and the like exists. I can't assume
that the platform I'll be using would have those tools. Git and basic
shell utilities outside of GNU should be the only things I need. It's
not a complicated setup.

## Design Principles

1. Overwriting existing config is bad. Whenever possible, try to
   preserve existing config.

   I've been burned so many times by this. Very often I'll have an
   existing Linux box (WSL included) that:

   1. I don't have full control over, or
   
   2. Various configs are not empty when I start to configure, or

   3. Programs have already spewed lines to .bashrc or .bash_profile.

2. Leave shell config to the local programs to abuse.

3. Whenever possible, use links for customizations that are not related
   to application abuse.


3. Make sure it (this config) is easy to delete. You get rid of my setup
   and use your own when you understand it all without having to think
   twice.

   Keep in mind that removing this config won't help you uninstall
   packages such as vim, emacs, etc. This is the job of your package
   manager. 

4. Make it modular. Installation for each program's config should be
   separate to make maintenance easy. 

5. Make it so that using setup script(s) repeatedly will skip the parts
   that's already been set up. This way, there's a global entry to setup
   everything. 

6. Make it as simple and cross-platform as possible. Certain programs
   make it way too hard to be configured in this repo.

7. Stay away from GNU coreutils.  GNU coreutils is good, but not
   cross-platform enough. Grep is a POSIX complaint tool if you use it
   carefully.

## Assumptions

There're very few assumptions here, but here are them, not in any
particular order:

1. You are running a UNIX-ish system. Any Linux or BSD-like system would
   do, including MacOS, WSL. You don't need this on Windows.

2. At least you have a POSIX shell in /bin/sh. Try

   ```bash
   exec /bin/sh
   ```
   
   If it does something instead of throwing an error, then you have
   shell in /bin/sh. It's very likely that it's not actually sh, but
   another shell symlinked as sh.  Executing
   

   ```bash 
   readlink /proc/$$/exe 
   ```
   
   would tell you what your current interactive shell is. I think it
   works on modern MacOS as well.


3. You would prefer to have more than 1 ssh setup if needed.


   For example, you have multiple git instances or multiple VMs/docker
   instanes that you would need to constantly ssh into. It is generally
   preferred that you use a set of public+private SSH keys for different
   accounts/connections. This way, if one ssh key gets compromised, you
   don't risk compromising all your ssh connections' safety. 


4. You are using two system package managers maximum: Your system
   package manager and nix. Nix local install path is only checked if
   your PATH doesn't have the program I'm looking for. I use it
   sporadically.

5. You would follow [XDG Base
   Directory](https://wiki.archlinux.org/title/XDG_Base_Directory)
   standards. Linked is not the XDG Base Directory Specification, but
   practical places of where you SHOULD place your configurations. 

6. At least you have Busybox utils or similar minimal environment. This
   means a grep, some minimal shell (ash or dash) and other utility
   programs should be present. 

## Non-assumptions

1. You are running GNU/Linux. I try to use programs that are not
   GNU-specific. Tested on Busybox ash.

2. You have bash as your interactive shell. If you don't have bash in
   your system, then .profile is loaded only. If you do use bash, then:
   1. .bash_profile is loaded, and it will load .profile.
   2. .profile does what it's supposed to do, and load in .bashrc.

   This is to ensure that .profile will be loaded no matter what.

## Goals/Programs configuring in this setup?

Bash, Vim, tmux, SSH, git. A "complete" CLI working environment. 

Bash for interactive shell, Vim for text editor, tmux for screen
multiplexer, ssh and git could work together or separately.

Note: I will only configure Bash as an interactive shell for you. Zsh or
fish is not going to be configured here, and there isn't much to
configure for ash or dash or other non-interactive shells. I might try
to configure them later though. No promises here.

## Non-goals/Programs Not Configuring in this setup?

1. dircolors. I realize they exist, I just don't care about them enough
   to write one.  

   Most terminal emulators have customization capabilities that are good
   enough to get a working color scheme in terminals anyways, and fine
   tuning that is a non-goal at the moment. 

2. Terminal emulator. They are easy enough to customize, mostly, and I
   don't customize them extensively beyond color schemes at this point.

3. Zsh or fish.  

4. Emacs. It deserves its own config repo. Someday?

5. Neovim. I have a tiny install script for neovim here if you want to
   give it a shot, though. NOT TESTED AT THE MOMENT.

6. IDEs/Full programming environment setup?

   Try IntelliJ suite or VSCode if that tickles your fancy. Or even
   Visual Studio. Usually your workplace will have a preference.

   My opinion on which IDE/editor to use? 
   
   1. IDEs are better at being IDEs than editors, and vice versa. 

   2. Manage your expectations of what your tool can do and what tool
      your team expects you to use.

7. File lock checking, aka race condition. Realistically, user should
   know better to not execute this program in two different shell
   sessions.

## How to Set up and Use

There's 2 flavours to setting up this config.

1. Using this dotfile on an existing install. In other words, not a
   container setup.

   To pull this repo to your setup:
   ```bash
   cd $HOME
   git clone https://github.com/samyilin/dotfiles
   ```

   To set up everything:

   ```bash
   cd $HOME/dotfiles 
   ./setup
   ```

   To setup additional programs after initial setup, i.e. your initial
   setup did not install vim but now it does, do 

   ```bash
   cd $HOME/dotfiles
   ./setup 

   ```
   Design principles above will make sure no repeated install would
   happen. It'll skip over bits already configured.

   To get the latest from this setup, do

   ```bash
   cd $HOME/dotfiles
   git pull
   ```
   If you want to remove this config, then

   ```bash
   cd $HOME/dotfiles
   ./remove

   ```
   will do it. Re-running terminal emulator instance, logging out and then
   logging out or restarting your machine will reset your bash setup. If
   you wish to delete this git repo from your hard drive altogether, then
   do

   ```bash
   rm -rf $HOME/dotfiles
   ```

   Default/non-interactive mode. Skips over interactive mode that the
   user need to intervene. This is the default on Docker setup. More
   about this below. 

   To install using non-interactive mode, use


   ```bash
   cd $HOME/dotfiles
   ./setup -d 
   ```


2. Using this dotfile to setup a docker/podman image. This is good for
   developing in a container and avoid "dependency hell."

   To use this method, you would need to install docker or podman on
   your setup. I would suggest podman.

   The below code would generate a docker image

   ```bash
   cd $HOME
   git clone https://github.com/samyilin/dotfiles
   cd dotfiles
   docker build -f Dockerfile -t IMAGE_NAME
   ```
   Podman requires using buildah to build image, so:


   ```bash
   cd $HOME
   git clone https://github.com/samyilin/dotfiles
   cd dotfiles
   buildah build -f Dockerfile -t IMAGE_NAME
   ```


   To enter this image, use


   ```bash
   docker run -it --rm localhost/IMAGE_NAME

   ```

   On podman, use


   ```bash
   podman run -it --rm localhost/IMAGE_NAME
   ```


   Default container/docker install would not help you set up ssh and
   git. These belong in your host system so you don't have to reset your
   ssh every time you spin up a container. To mount host's ssh and git,
   use something like 

   ```bash
   docker run -it --rm -v $HOME/.ssh:$HOME/.ssh -v $HOME/.gitconfig
   $HOME/.gitconfig localhost/IMAGE_NAME

   ```


## TODO

Based on personal priority:


1. Write a pre-commit hook that is ran every time a commit happens to
   make sure shellcheck passes before I commit.
   

2. Overhaul tmux keybindings and/or other settings or configs. 


3. Overhaul Vim experience. Use some plugins to enable LSP or other
   IDE-like features. Make modular vim setup. Might use Neovim? Who
   knows?

4. Proof-read READMEs. LOL

5. Fine-tune remove scripts. Not a priority at the moment, as I'm
   actively tuning setup scripts.
