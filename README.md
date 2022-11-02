# Readme\

This is my personal dotfiles for any Linux box, always WIP.

## Design Principles\

This project is designed based on 3 premise:

1. Overriding existing .bashrc is bad. Whenever possible, try to preserve
   existing config.

   I've been burned so many times by this. Very often I'll have an
   existing Linux box with whatever distribution, sometimes a cloud
   instance, sometimes a VM instawnce, sometimes WSL, that:
   1. I simply don't have full control over, or
   2. I can't have docker set up, or
   3. .bashrc is just not empty when I can start to configure it.

   I can't simply assume there's no existing configuration file on
   there.  Therefore, I have to assume that there's some kind of default
   .bashrc or .profile within there already.

   Plus, certain programs (Yes gcloud, I'm talking about you) loves to
   spew stuff into .bashrc. So the idea is, we preserve a copy of the
   default .bashrc and .profile for programs to write to, and write our
   own configs on top of that on separate file(s) that get loaded after
   the fact. This way, we preserve system-specific configs and have our
   own configs be able to be pulled from git when new changes have been
   made.
2. Whenever possible, try to use links. This follows the previous
   principle, insofar that if certain programs love to spew into our
   .bashrc, then keep that clean and load the link.
3. Make sure it is easy to delete. Most dotfiles in the wild never
   considers this, and just assumes that either:
   1. This dotfile is used for perpetuity, or
   2. This dotfile is used in containers or VMs anyways, so who cares?

   Having a dotfile that you can completely get rid of, including
   symlinks, is a useful and simple feature.


## How to use

```bash 
cd $HOME && git clone https://github.com/samyilin/dotfiles && cd dotfiles && ./setup 

``` 

Tries to setup several configs for several
programs.

If program is not installed during setup, i.e. vim, then install vim
first, then do

```bash 
cd $HOME/dotfiles && ./setup
``` 

will do it. 

If you are not happy with how this dotfile works, simply do

```bash

cd $HOME/dotfiles && ./remove

```
will do it. If you wish to delete this git repo altogether, then do

```bash
rm -rf $HOME/dotfiles
```


