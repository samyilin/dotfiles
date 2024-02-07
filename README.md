# README

This is my dotfile. Usable both as a standalone Git repository or work
in a Docker environment.

What is a dotfile? By tradition, on Unix systems (Linux, BSDs, Mac, etc.)
configurations per application are stored in user's home directory and typically
started with a ".", which operating systems set these as hidden by convention.
If you use ls in your home directory, you won't see these files unless you use
flags that would show hidden files as well. So dotfiles are user customization
per application for Unix users.

## Why?

This repo has 3 purposes:

1. This is my dotfile that is more or less personal. I do try to make it
   as distro/OS-agnostic as possible though, so opinionated setups will
   be of a less priority here.

2. To force myself to learn shell programming, tmux configuration and so
   much more. I had a less than perfect config before, so I use this
   project to motivate myself to learn more and live ( more or less) in
   the command line when it comes to coding or editing text. 


3. To have a containerized development environment. I want to try out
   projects or programming setups/tools without "polluting" my base
   setup and lead to dependency hell. The hope is that this will serve
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

2. Leave shell config for the local programs to abuse. These are copied
   to home directory rather than linked.

3. Use links for customizations that are not related to application abuse.

4. Make sure it (this config) is easy to delete. 

   Keep in mind that removing this config won't help you uninstall
   packages such as vim, emacs, etc. This is the job of your package
   manager. 

5. Make it modular. scripts/configs for each program should be
   separated by folder to make maintenance easy. 

6. Make it so that using setup script(s) repeatedly will skip the parts
   that's already been set up.  

7. Make it as simple and cross-platform as possible. It is for this
   reason that POSIX shell scripts are preferred over Bash scripts.

8. Stay away from GNU coreutils. Not cross-platform enough. 

## Assumptions

There're very few assumptions here, but here are them, not in any
particular order:

1. You are running a UNIX-ish system. Any Linux or BSD-like system would
   do. You don't need this on Windows.

2. At least you have a POSIX shell in /bin/sh. Very safe assumption on UNIXes.

3. You would prefer to have more than 1 ssh setup if needed.

   For example, you have multiple git instances or multiple VMs/docker
   instances that you would need to constantly ssh into. It is generally
   preferred that you use a set of public+private SSH keys for different
   accounts/connections. This way, if one ssh key gets compromised, you
   don't risk compromising all your ssh connections' safety. 


4. You would follow XDG Base Directory standards. 

5. At least you have Busybox or similar minimal environment. This
   means some minimal shell (ash or dash) and other utility programs
   should be present. 

## Non-assumptions

1. You are running GNU/Linux. Tested on Busybox ash.

2. You have bash as your interactive shell. If you don't have bash in
   your system, then .profile is loaded only. If you do use bash, then:

   1. .bash_profile is loaded, and it will load .profile.
   2. .profile does what it's supposed to do, and load in .bashrc.

   This is to ensure that .profile will be loaded no matter what.

## Goals/Programs configuring in this setup?

Bash, Vim, Neovim, tmux, SSH, git. A "complete" CLI working environment. 

This script also helps you set up your user name and password. Good for
initializing things on WSL or other root systems.On WSL it will help you
do a few more things. If you have systemd installed, it will enable 
systemd on functionality. STILL TESTING WSL FEATURES.

Bash for interactive shell, Vim/Neovim for text editor, tmux for screen
multiplexer, ssh and git could work together or separately.

SSH setup script here is a wrapper to allow users to set up git and SSH
so we can SSH into git repos easier, and nothing else. More in the SSH
folder.

I've also configured a simple PS1 prompt for shells other than bash 

## Non-goals/Programs Not Configuring in this setup?

1. dircolors. I realize they exist, I just don't care about them enough
   to write one. 

   Most terminal emulators have customization capabilities that are good
   enough to get a working color scheme in terminals anyways, and fine
   tuning that is a non-goal at the moment. 

2. Zsh or fish.  

3. Emacs. It deserves its own config repo. Someday?

4. IDEs/Full programming environment setup?

   Try IntelliJ suite or VSCode if that tickles your fancy. Or even
   Visual Studio. Usually your workplace will have a preference.

   My opinion:
   
   1. IDEs are better at being IDEs than editors, and vice versa. 

   2. Manage your expectation of what your tool can do and what tool your team
      expects you to use.

7. File lock checking, aka race condition. Realistically, user should
   know better to not execute this program in two different shell
   sessions.

8. Being able to curl/wget/download a setup file and go about installing config.
   I don't see its value though. If being up to date is required, which it is
   for any config, then git is still needed regardless, so such a setup do not
   reduce dependency but just make dependency less explicit.

## How to Set up and Use

I try to be very explicit here. If it's not explicit enough, let me
know.

There's 2 flavours to setting up this config.

1. Using this dotfile on an existing install. In other words, not a
   container setup.

   To pull this repo to your OS:


   ```bash
   cd $HOME
   git clone https://github.com/samyilin/dotfiles.git
   ```


   To set up everything:


   ```bash
   cd $HOME/dotfiles 
   ./setup && . "$HOME"/.profile
   ```


   To setup additional programs after initial setup, i.e. your initial
   setup did not install vim but now it does, do 


   ```bash
   cd $HOME/dotfiles
   ./setup YOUR_PROGRAM 
   ```


   Design principles above will make sure no repeated install would
   happen. 

   To get the latest from this setup, do

   ```bash
   cd $HOME/dotfiles
   git pull
   ```


   If you want to remove this config, then


   ```bash
   cd $HOME/dotfiles
   ./remove && . "$HOME"/.profile
   ```


   If you want to remove config for a certain program, i.e.
   vim, then

   ```bash
   cd $HOME/dotfiles
   ./remove YOUR_PROGRAM
   ```

   To remove this repo from your setup altogether, do

   ```bash
   rm -rf $HOME/dotfiles
   ```
   
   Additional mode:

   Docker/default mode. Skips over interactive mode that the user need to
   intervene, i.e. setting up username/password, git and ssh.  This is
   the default on Docker setup. More about this below. 


   To install using non-interactive mode, use


   ```bash
   cd $HOME/dotfiles
   ./setup -d 
   ```

2. Using this dotfile to setup a docker/podman image. This is good for
   developing in a container and avoid "dependency hell."

   To use this method, you would need to install docker or podman on
   your setup. I would suggest podman.

   I have 3 Dockerfile here, one Ubuntu based (more stable-ish, although I use
   the latest Ubuntu release), one Fedora rawhide based (cutting-edge, good for
   testing latest software) and one Archlinux based (bleeding-edge, good for
   testing development software)

   Using the appropriate Dockerfile name, the below code would generate a docker
   image:


   ```bash
   cd $HOME
   git clone https://github.com/samyilin/dotfiles
   cd dotfiles
   docker build -f Dockerfile.DISTRO -t IMAGE_NAME
   ```

   Podman requires using buildah to build image, so:


   ```bash
   cd $HOME
   git clone https://github.com/samyilin/dotfiles
   cd dotfiles
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


   Default container/docker install would not help you set up ssh and
   git. These belong in your host system so you don't have to reset your
   ssh every time you spin up a container. To mount host's ssh and git
   configurations, use something like 


   ```bash
   docker run -it --rm -v $HOME/.ssh:$HOME/.ssh \
      -v $HOME/.gitconfig $HOME/.gitconfig \
      localhost/IMAGE_NAME

   ```

   You can use a similar process to mount your git repo to the container
   so you don't have to keep copying your repo over. Writing a basic Bash script
   for this is trivial and won't be covered here.

## Systems Tested


I've tested this setup in Alpine, Arch, Ubuntu and Fedora Linux
containers. I would try this in VMs one day. Tested this on MacOS.


Will try to test this on BSD VMs one day. 

## TODO

Based on personal priority:

1. Write a pre-commit hook that is ran every time a commit happens to
   make sure shellcheck passes before I commit. May try to use Gitlab
   Runner or other systems. 
