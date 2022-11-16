# Readme

This is my personal dotfiles for any Linux box, always WIP.

## Design Principles

This project is designed based on these premises:

1. Overriding existing .bashrc is bad. Whenever possible, try to preserve
   existing config.

   I've been burned so many times by this. Very often I'll have an
   existing Linux box (WSL included) that:

   1. I simply don't have full control over, or
   2. I can't have docker set up, or
   3. .bashrc is just not empty when I start to configure it.

   I can't simply assume there's no existing configuration at all on any
   setup. Therefore, I have to assume that there's some kind of default
   .bashrc or .profile or other configs there already.

   Plus, many programs loves to spew lines into .bashrc or .profile. So
   the idea is, we preserve a copy of the default .bashrc and .profile
   for programs to write to, and write our own global configs on top of that on
   separate file(s) that get loaded after the fact. 

2. Whenever possible, try to use links. This follows the previous
   principle.

3. Make sure it is easy to delete. Most dotfiles in the wild never
   considers this, and just assumes that either:
   1. This dotfile is used for perpetuity, or
   2. This is a personal dotfile, so it doesn't matter, or
   2. This dotfile is used in containers or VMs anyways, so who cares?

   You get rid of my setup and use your own when you understand it all
   without having to think twice.

   Keep in mind that removing functionality won't help you uninstall
   packages such as vim, emacs, etc. This is the job of your package
   manager. 

4. Make it modular. Installation for each program's config should be
   separate to make maintenance easy. 

5. Make it so that using setup script(s) repeatedly will skip the parts
   that's already been set up. This way, there's a global entry to setup
   everything.

6. Make it as simple and cross-platform as possible. Certain programs
   make it way too hard to stay cross-platform.

   In order for our fetch program to run basically everywhere,
   I've opted to using [pfetch](https://github.com/dylanaraps/pfetch)
   instead of [neofetch](https://github.com/dylanaraps/neofetch) as a
   first-class citizen. It'll opt for pfetch first, then neofetch.

## Assumptions

There're very few assumptions here, but here are them:

1. You are running a UNIX-ish system. Any Linux or BSD-like system would
   do, including MacOS. You don't need this on Windows.

2. Bash is the default shell on the system, or at least it can be found
   at /bin/bash.

   This assumption COULD be wrong in some distro, but it is true most
   of the time. Try
   ```bash
   exec /bin/bash
   ```
   If it does something instead of throwing an error, then you have bash
   in /bin/bash. Your interactive shell could be zsh (default on MacOS).
   I don't use zsh, but a lot of people use
   [oh-my-zsh](https://ohmyz.sh/). I generally consider zsh and
   oh-my-zsh to be bloat, but it's up to you.

   Executing
   ```bash
   readlink /proc/$$/exe
   ```
   would tell you what your interactive shell is. I think it works on
   MacOS.

3. You would prefer to have more than 1 ssh setup if needed.

   For example, you have multiple git instances (Gitlab for work +
   GitHub for self, or personal Gitlab account + work Gitlab account,
   etc) or multiple VMs/docker instanes that you may need to constantly ssh into. It is
   generally preferred that you use a set of public+private SSH keys for
   different accounts/connections. This way, if one ssh key gets
   compromised, you don't risk compromising all your ssh connections'
   safety. 

4. Your configs should be relatively clean, machine-generated or
   non-existent, and not heavily hand-grokked and modified by someone
   else. I can't test everything.

5. You are using two package managers maximum: Your system package
   manager and nix. Again, I can't test everything. Nix is
   cross-platform enough. 


6. You would follow [XDG Base
   Directory](https://wiki.archlinux.org/title/XDG_Base_Directory)
   standards. Linked is not the XDG Base Directory Specification, but
   practical places of where you SHOULD place your configurations. 

## Non-assumptions

1. You are running GNU/Linux.

   I try to use programs that are not GNU-specific. Haven't thoroughly
   tested this, though. I will try  to use sh instead of bash for setup
   scripts in the future. Not a priority at the moment.

## Goals/Programs configuring in this setup?

Bash, Vim, tmux, SSH, git.

Bash is for interactive shell, Vim for your text editor, tmux for your
screen multiplexer, ssh and git could work together or separately.

Vim setup is a continuously changing setup.

## Non-goals/Programs Not Configuring in this setup?

1. dircolors. I realize they exist, I just don't care about them enough
   to write one.  

   Most terminal emulators have customization capabilities that are good
   enough to get a working gruvbox or other color schemes in terminal
   anyways, and fine tuning that is something that is a non-goal at the
   moment. 

2. Terminal emulator. They are easy enough to customize, mostly, and I
   don't customize them extensively beyond color schemes at this point.

## Emacs?

Tried it for a bit, I realized the following puzzle/conundrum:

1. Vim and Emacs are essentially the same. They both have some
   extensibility, albeit limited by their own design (usage of DSL
   instead of general programming language. Neovim users, I know what
   you are going to say).

2. But vim and Emacs are not the same. At least you can escape Vim, but
   you cannot escape emacs.

Regardless, emacs is a very interesting piece of software, and I'm
generally intrigued by lisp in general. Might give them (lisp
language/tools) a more thorough try one day.

## Neovim?

Someday I will have time to write a separate init.lua for it. Maybe?

## IDEs/Full programming setup?

This is a minimal setup, not a full IDE-like setup, although I'm exploring
options within Vim.  

Try IntelliJ suite or VSCode if that tickles your fancy. Or
even Visual Studio. They are easy enough to setup quickly.

My opinion on which IDE/editor to use? IDEs are better at being IDEs
than editors, and vice versa. Therefore, manage your expectations of
what your tool can do and what tool your team expects you to use.

## How to Set up and Use

This config tries to setup several configs for several programs.
One-liner like this should work:

```bash
cd $HOME && git clone https://github.com/samyilin/dotfiles && cd dotfiles && ./setup && cd ->/dev/null
```
If you installed a program that this setup customizes after running
setup script first, or if you want to get the latest updates:

```bash
cd $HOME/dotfiles && git pull && ./setup && cd ->/dev/null
```

Design principles above will ensure no repeated install will
happen.

If you want to remove this config, then

```bash

cd $HOME/dotfiles && ./remove

```
will do it. Re-running shell instance, logging in and out or restarting
your machine will reset it. If you wish to delete this git repo from
your hard drive altogether, then do


```bash
rm -rf $HOME/dotfiles
```
## TODO

Based on personal priority:

1. Finish up SSH + git config. SSH config is harder than I imagined, but
   not too much harder. I just want to write a cheatsheet or wrapper
   script to make using SSH + git a bit easier. Most git services (GitHub,
   GitLab or others) have instructions on how Git should work with SSH.

2. Overhaul Vim experience. Use some plugins to enable LSP or other
   IDE-like features. Make modular vim setup. Might use Neovim? Who
   knows?

3. Overhaul tmux settings to incorporate more VIM-like or EMACS-like
   keybindings? But tmux setting overhaul is definitely needed.

4. Shellcheck! This is very important. I do want my bash files to be
   more or less cross-platform and POSIX-compliant. Not a priority at
   the moment, just want to have a working dotfile right now.

5. SSH configuration for usage other than git. SSH into other machines?
   X11 forwarding? SSH config is complicated, because there're many use
   cases for it. I will tackle point 1 on TODO first. 

6. Setup for X11/Wayland/Graphic User Interfaces in general. This is a
   very low priority item, because I don't have a Linux machine at the
   moment.
