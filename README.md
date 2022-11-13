# Readme

This is my personal dotfiles for any Linux box, always WIP.

## Design Principles

This project is designed based on 5 premise:

1. Overriding existing .bashrc is bad. Whenever possible, try to preserve
   existing config.

   I've been burned so many times by this. Very often I'll have an
   existing Linux box with whatever distribution, sometimes a cloud
   instance, sometimes a VM instance, sometimes WSL, that:
   1. I simply don't have full control over, or
   2. I can't have docker set up, or
   3. .bashrc is just not empty when I can start to configure it.

   I can't simply assume there's no existing configuration file on
   there.  Therefore, I have to assume that there's some kind of default
   .bashrc or .profile within there already.

   Plus, certain programs (Yes gcloud, I'm talking about you) loves to
   spew lines into .bashrc. So the idea is, we preserve a copy of the
   default .bashrc and .profile for programs to write to, and write our
   own configs on top of that on separate file(s) that get loaded after
   the fact. This way, we preserve system-specific configs and have our
   own configs be able to be pulled from git when new changes have been
   made, so we get the best of both worlds.
2. Whenever possible, try to use links. This follows the previous
   principle, insofar that if certain programs love to spew into our
   .bashrc, then keep the default .bashrc in place and load the link.
3. Make sure it is easy to delete. Most dotfiles in the wild never
   considers this, and just assumes that either:
   1. This dotfile is used for perpetuity, or
   2. This dotfile is used in containers or VMs anyways, so who cares?

   Having a dotfile that you can completely get rid of, including
   symlinks, is a useful and simple feature. You get rid of it and use
   your own when you understand it all.

   Keep in mind that removing functionality won't help you uninstall
   packages such as vim, emacs, etc. This is the job of your package
   manager. There're way too many package managers for me to cover all
   the corner cases, so this is a non-goal for this dotfile.

4. Make it modular. Installation for each program's config should be
   separate. This way we make sure we have a manageable set of scripts
   instead of one huge script that does everything.

5. Make it so that repeatedly using setup script(s) will skip the parts
   that's already been set up. Good for testing, good for when we need to
   pull down a new update.

6. Make it simple and as cross-platform as possible. Certain programs
   make it way too hard to stay cross-platform. Docker is a primary
   non-target for this dotfile even though I do use it occasionally,
   precisely because there's many ways to set up docker. Command line
   only? Docker Desktop? Systemd or no systemd(WSL have no systemd until
   Windows 11, sucks so much)? Or even podman + buildah? Don't know your
   preference.

## Assumptions

There're very few assumptions here, but here are them:

1. You are running a UNIX-ish system. Any Linux or BSD-like system would
   do, including MacOS. Not Windows.

2. Bash is the default shell on the system, or at least it can be found
   at /bin/bash.

   This assumption COULD be wrong in some distro, but it is true most
   of the time. Try
   ```bash
   exec /bin/bash
   ```
   If it does something instead of throwing an error, you have bash in
   /bin/bash. If your command line prompt changed when you ran it, you
   were probably using a different shell.  Zsh maybe (default on MacOS)?
   I don't use zsh, but a lot of people use
   [oh-my-zsh](https://ohmyz.sh/). I generally consider zsh and
   oh-my-zsh to be bloat, but it's up to you.

   Executing
   ```bash
   ps -p $$
   ```
   should tell you exactly what you are running. Unless it's a symlink
   to another program in your environment, or your distro's shipped "ps"
   does not use the -p flag, which may be possible. In which case, use
   ```bash
   readlink /proc/$$/exe
   ```
   should be a universal solution. It even works in Busybox!

3. You would prefer to have more than 1 ssh setup if needed.

   For example, you have multiple git instances (Gitlab for work +
   GitHub for self, or personal Gitlab account + work Gitlab account,
   etc) or multiple VM instances (either virtual machine or
   kubernetes/docker instances that you may need to constantly ssh into). It is
   generally preferred that you use a set of public+private SSH keys for
   different accounts/connections. This way, if one ssh key gets
   compromised, you don't risk compromising all your ssh connections'
   safety. 

4. You are NOT using a similar setup or other people's config at the
   same time. I know, my design principle stated that we can't assume
   the configs to be empty, but I don't expect this structure (symlink
   plus custom configs) or non-auto-generated configs to be existent
   either. If you use a symlink setup similar to mine, you may run into
   issues. Anyways, your configs should be relatively clean and not
   heavily hand-grokked and modified by someone else. I can't test
   everything, you know.

## What programs are being customized/initialized?

Bash, Vim, tmux, SSH, git.

Bash is for interactive shell, Vim for your text editor, tmux for your
screen multiplexer, ssh and git could work together or separately.

Vim setup is a continuously changing setup.

## What programs/files am I NOT customizing?

1. dircolors. I realize they exist, I just don't care about them enough
   to write one.  

   Most terminal emulators have customization capabilities that are good
   enough to get a working gruvbox or other color schemes in terminal
   anyways, and fine tuning that is something that is a non-goal at the
   moment. Once I consider this to be important, I will put this into
   TODO.

2. Terminal emulator. They are easy enough to customize, mostly, and I
   don't customize them extensively beyond color schemes at this point.
   Plus, I don't really use a certain one cross-platform right now (I
   don't think a good cross-platform terminal emulator exists ATM,
   even), so don't really want to set up a lot of settings.json file or
   similar files just for color schemes. 

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

## IDEs?

This is a minimal setup, not to have a full IDE, although I'm exploring
options within Vim. There's plenty of LSP options within Vim, and
tree-sitter integration within Neovim. Using a suite of tools is
complicated to setup from scratch, but maybe I will try it one day.

Try IntelliJ suite or VSCode if that tickles your fancy. Or
even Visual Studio. I don't care.

My opinion? IDEs are better at being IDEs than editors, and vice versa.
Therefore, manage your expectations of what your tool can do and what
tool your team expects you to use, take these two factors into
consideration when considering working for an organization.

## How to use


This config tries to setup several configs for several programs.
One-liner like this should work. 

```bash
cd $HOME && git clone https://github.com/samyilin/dotfiles && cd dotfiles && ./setup

```
If you installed a new program that this config customizes, or if you
want to get the latest updates:

```bash
cd $HOME/dotfiles && git pull && ./setup
```

Design principles above will ensure no repeated install will
happen.

If you want to remove this config, then

```bash

cd $HOME/dotfiles && ./remove

```
will do it. If you wish to delete this git repo from your hard drive
altogether, then do

```bash
rm -rf $HOME/dotfiles
```
## TODO

1. Finish up SSH config. SSH config is harder than I imagined, but not
   too much harder. I just want to write an SSH wrapper of some kind to
   ease its use.
2. Overhaul Vim experience. I want to use some plugins to enable LSP or
   other IDE-like features. Might use Neovim? Who knows? I might come up
   with an init.lua just for Neovim.
3. Multiple git setup or more complicated git setup. Might abandon this
   altogether though. 
4. Overhaul tmux settings to incorporate more VIM-like or EMACS-like
   keybindings? But tmux setting overhaul is definitely needed.
5. Shellcheck! This is very important. I do want my bash files to be
   more or less cross-platform and POSIX-compliant. Not a priority at
   the moment, just want to have a working dotfile right now.
