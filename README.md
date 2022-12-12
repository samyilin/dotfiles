# README

This is my dotfile. Always WIP.

## Why?

This repo has 2 purposes:

1. This is my dotfile that is more or less personal. I do try to make it
   as distro/OS-agnostic as possible though, so opinionated setups will
   be of a less priority here.

2. To force myself to learn bash programming, tmux configuration and so
   much more. I had a less than perfect config before, so I use this to
   motivate myself to learn more and live ( more or less) in the command
   line when it comes to coding or editing text. 
   
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

2. Whenever possible, try to use links. This follows the previous
   principle. .bashrc, .bashrc_profile or .profile should be left for
   programs to spew lines into in a per-setup basis, hence why links.

3. Make sure it (configuration(s)) is easy to delete. You get rid of my
   setup and use your own when you understand it all without having to
   think twice.

   Keep in mind that removing this config won't help you uninstall
   packages such as vim, emacs, etc. This is the job of your package
   manager. 

4. Make it modular. Installation for each program's config should be
   separate to make maintenance easy. 

5. Make it so that using setup script(s) repeatedly will skip the parts
   that's already been set up. This way, there's a global entry to setup
   everything. Plus, we have Point 2 to ensure smooth setup.

6. Make it as simple and cross-platform as possible. Certain programs
   make it way too hard to be configured in this repo.

7. Stay away from GNU coreutils. This follows the previous principle.
   GNU coreutils is good, but not cross-platform enough. Grep is a POSIX
   complaint tool if you use it carefully.

## Assumptions

There're very few assumptions here, but here are them, not in any
particular order:

1. You are running a UNIX-ish system. Any Linux or BSD-like system would
   do, including MacOS, WSL. You don't need this on Windows.

2. At least you have bash shell in /bin/bash. Try

   ```bash
   exec /bin/bash
   ```
   
   If it does something instead of throwing an error, then you have bash
   in /bin/bash. Your interactive shell could be zsh (default on MacOS).
   I don't use zsh, but a lot of people use
   [oh-my-zsh](https://ohmyz.sh/) when using zsh. Executing
   
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
   package manager and nix. Nix is only checked if your PATH doesn't
   have the program I'm looking for. I use it sporadically.

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

4. Emacs. Not now at least. It deserves its own config repo.

5. Neovim. Someday I will have time to write a separate init.lua for it. Maybe?

6. IDEs/Full programming environment setup

   Try IntelliJ suite or VSCode if that tickles your fancy. Or even
   Visual Studio. Usually your workplace will have a preference, weak
   or strong.

   My opinion on which IDE/editor to use? 
   
   1. IDEs are better at being IDEs than editors, and vice versa. 

   2. Manage your expectations of what your tool can do and what tool
      your team expects you to use.
7. File lock checking, aka race condition. Realistically, user should
   know better to not execute this program in two different shell
   sessions.

## How to Set up and Use

This config tries to setup several configs for several programs.
One-liner like this should be suffice for initial setup:

```bash
cd $HOME && git clone https://github.com/samyilin/dotfiles && cd dotfiles && ./setup && cd ->/dev/null
```

If you installed a program that this setup customizes after running
setup script first, or if you want to get the latest updates:

```bash
cd $HOME/dotfiles && git pull && ./setup && cd ->/dev/null
```
If you only want to configure 1 or 2 programs, simply do

```bash
cd $HOME/dotfiles && ./setup YOUR_PROGRAM1 YOUR_PROGRAM2
```

Design principles above will ensure no repeated install will
happen.

If you want to remove this config, then

```bash
cd $HOME/dotfiles && ./remove

```
will do it. Re-running terminal emulator instance, logging out and then
logging out or restarting your machine will reset your bash setup. If
you wish to delete this git repo from your hard drive altogether, then
do

```bash
rm -rf $HOME/dotfiles
```
## TODO

Based on personal priority:

1. ~~Make the master setup script have command line arguments, so that it
   can only setup certain tools instead of others. Will update this
   document whenever this change has taken effect.~~

   Completed, but documention needs to be updated.

2. ~~Shellcheck! This is very important. I do want my bash files to be
   more or less cross-platform and POSIX-compliant. Not a priority at
   the moment, just want to have a working dotfile right now.~~

   New objective: Write a pre-commit hook that is ran everytime a commit
   happens to make sure shellcheck passes before I commit.
   
3. Overhaul tmux keybindings and/or other settings. I do want to make
   this setup as universally acceptable as possible, so still thinking
   about this.

   WIP.

4. Overhaul Vim experience. Use some plugins to enable LSP or other
   IDE-like features. Make modular vim setup. Might use Neovim? Who
   knows?

   WIP.

5. Finish up SSH + git config. SSH config is harder than I imagined, but
   not too much harder. I just want to write a cheatsheet or wrapper
   script to make using SSH + git a bit easier. Most git services (GitHub,
   GitLab or others) have instructions on how Git should work with SSH.

6. SSH configuration for usage other than git. SSH into other machines?
   X11 forwarding? SSH config is complicated, because there're many use
   cases for it.  

7. Setup for X11/Wayland/Graphic User Interfaces in general. This is a
   very low priority item, because I don't have a Linux machine at the
   moment.

   Also, this repo is meant to be an universal CLI setting(s) repo, not
   meant as a personal repo. GUI settings are more personal than
   universal, so it should be somewhere else? Still thinking on it.
