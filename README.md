## Design Principles

1. Overwriting existing config is bad. Whenever possible, try to
   preserve existing config.

   I've been burned so many times by this. Very often I'll have an
   existing Linux box (WSL included) that:

   1. I simply don't have full control over, or
   2. Various configs are just not empty when I start to configure it,
      or
   3. Programs have already spewed lines to .bashrc.

2. Whenever possible, try to use links. This follows the previous
   principle. Additionally, .bashrc, .bashrc_profile or .profile should be left for
   programs to spew lines into in a per-setup basis, hence why links.

3. Make sure it is easy to delete. You get rid of my setup and use your
   own when you understand it all without having to think twice.

   Keep in mind that removing this config won't help you uninstall
   packages such as vim, emacs, etc. This is the job of your package
   manager. 

4. Make it modular. Installation for each program's config should be
   separate to make maintenance easy. 

5. Make it so that using setup script(s) repeatedly will skip the parts
   that's already been set up. This way, there's a global entry to setup
   everything. Plus, we have Point 2 to ensure smooth setup.

6. Make it as simple and cross-platform as possible. Certain programs
   make it way too hard to stay cross-platform.

7. Stay away from GNU coreutils. This follows the previous principle.
   GNU coreutils is good, but not cross-platform enough.

## Assumptions

There're very few assumptions here, but here are them, not in any
particular order:

1. You are running a UNIX-ish system. Any Linux or BSD-like system would
   do, including MacOS. You don't need this on Windows.

2. At least you have bash shell in /bin/bash.  Try

   ```bash
   exec /bin/bash
   ```
   
   If it does something instead of throwing an error, then you have bash
   in /bin/bash. Your interactive shell could be zsh (default on MacOS).
   I don't use zsh, but a lot of people use
   [oh-my-zsh](https://ohmyz.sh/) when using zsh. Far as I understand,
   zsh is NOT POSIX-compliant.  Executing
   
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
   package manager and nix.  Nix is cross-platform enough. 

5. You would follow [XDG Base
   Directory](https://wiki.archlinux.org/title/XDG_Base_Directory)
   standards. Linked is not the XDG Base Directory Specification, but
   practical places of where you SHOULD place your configurations. 

6. At least you have Busybox utils or similar minimal environment. This
   means a grep, some minimal shell (ash or dash) and other utility
   programs should be present. 

## Non-assumptions

1. You are running GNU/Linux.

   I try to use programs that are not GNU-specific. Haven't thoroughly
   tested this, though. I will try  to use sh instead of bash for setup
   scripts in the future. Not a priority at the moment.

2. You have bash as your interactive shell. Your .profile would be
   loaded first, then .bashrc. If you don't use .bashrc, then it just
   won't be loaded. By default a symlink to my .bashrc would be created,
   but that's about it.

## Goals/Programs configuring in this setup?

Bash, Vim, tmux, SSH, git.

Bash for interactive shell, Vim for text editor, tmux for screen
multiplexer, ssh and git could work together or separately.

Note: I will only configure Bash as an interactive shell for you. Zsh or
fish is not something I would consider as a good interactive shell, and there
isn't much to configure for ash or dash or other non-interactive shells.

## Non-goals/Programs Not Configuring in this setup?

1. dircolors. I realize they exist, I just don't care about them enough
   to write one.  

   Most terminal emulators have customization capabilities that are good
   enough to get a working color scheme in terminals anyways, and fine
   tuning that is a non-goal at the moment. 

2. Terminal emulator. They are easy enough to customize, mostly, and I
   don't customize them extensively beyond color schemes at this point.

3. Zsh.  

4. Emacs. Tried it for a bit, I realized the following puzzle/conundrum
   that :
  
   1. Vim and Emacs are essentially the same. They both have some
      extensibility, albeit limited by their own design (usage of DSL
      instead of general programming language. Neovim users, I know what
      you are going to say).

   2. But vim and Emacs are not the same. At least you can escape Vim,
      but you cannot escape emacs.


5. Neovim. Someday I will have time to write a separate init.lua for it. Maybe?

6. IDEs/Full programming environment setup

   Try IntelliJ suite or VSCode if that tickles your fancy. Or even
   Visual Studio. Usually your workplace will have a preference, weak
   or strong.

   My opinion on which IDE/editor to use? 
   
   1. IDEs are better at being IDEs than editors, and vice versa. 

   2. Manage your expectations of what your tool can do and what tool
      your team expects you to use.

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

Design principles above will ensure no repeated install will
happen.

If you want to remove this config, then

```bash
cd $HOME/dotfiles && ./remove

```
will do it. Re-running terminal emulator instance, logging out and then
logging out or restarting your machine will reset it. If you wish to
delete this git repo from your hard drive altogether, then do

```bash
rm -rf $HOME/dotfiles
```
## TODO

Based on personal priority:

1. Make the master setup script have command line arguments, so that it
   can only setup certain tools instead of others. Will update this
   document whenever this change has taken effect. 

2. Shellcheck! This is very important. I do want my bash files to be
   more or less cross-platform and POSIX-compliant. Not a priority at
   the moment, just want to have a working dotfile right now.

3. Overhaul tmux keybindings. I've always disliked the default config.
   However, I do want to make this setup as universally acceptable as
   possible, so still thinking about this.

4. Overhaul Vim experience. Use some plugins to enable LSP or other
   IDE-like features. Make modular vim setup. Might use Neovim? Who
   knows?

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
