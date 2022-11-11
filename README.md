# Readme

This is my personal dotfiles for any Linux box, always WIP.

## Design Principles

This project is designed based on 5 premise:

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
   symlinks, is a useful and simple feature. You get rid of it and use
   your own when you understand it all.

   Keep in mind that removing functionality won't help you uninstall
   packages, vim, emacs, etc. This is the job of your package manager. I
   might add that functionality later, but not on my roadmap right now.

4. Make it modular. Installation for each program's config is separate.

5. Make it so that repeatedly using setup script will skip the parts
   that's already been set up.

## Assumptions

There're very few assumptions here, but here are them:

1. You are running a UNIX-ish system. Any Linux or BSD-like system would
   do, including MacOS.

2. Bash is the default shell on the system, or at least it can be found
   at /bin/bash.

   This assumption COULD be wrong in some distro, but it is true most 
   of the time. Try 
   ```bash
   exec /bin/bash
   ```
   If it does something instead of throwing an error, you have bash in
   /bin/bash.
3. Your .gitconfig, .tmux.conf or .vimrc is nonexistent.

   This is true most of the times, but if not, then try to preserve your
   own copies before trying mine! I could add functionality to preserve 
   your own copy later on though.

4. You would prefer to have more than 1 ssh setup if needed.

   For example, you have multiple git instances (Gitlab for work +
   GitHub for self, or personal Gitlab account + work Gitlab account,
   etc) or multiple VM instances (either virtual machine or
   kubernetes/docker instances that you may need to constantly ssh into). It is
   generally preferred that you use a set of public+private SSH keys for
   different accounts/connections. This way, if one ssh key gets
   compromised, you don't risk compromising all your ssh connections'
   safety. 
5. Read my scripts to understand what it does. It's dead simple. Don't
   get burned by me.

## What programs are being customized/initialized?

Bash, Vim, Tmux, SSH, git.

Bash is for interactive shell, Vim for your text editor, tmux for your
screen multiplexier, ssh and git could work together or separately.

Note that my Vim setup is very simple. I make a clear distinction
between IDE and text editor, and I don't expect my editor to be an IDE,
although you can turn vim into an IDE, albeit with too much of other
people's packages that you don't have full control over. Once they
(maintainer of plugins/packages) decide to change a feature or push a
breaking change, you will be screwed, for a while. There're ways to pin
packages to a certain version, but I hate to maintain and understand
development of 50-ish plugins or even more. I will use them when I
become a full time programmer (not likely to happen in my lifetime). In
general the simpler the better. For rock solid IDE-like experience that
do not hinder your production, go to an actual IDE. There's some people
that use Vim full time, I'm not a full-time programmer, so I don't
care about that aspect enough to customize my vim that way.

## Emacs?

Tried it for a bit, I realized the following puzzle/conondrum:

1. Vim and Emacs are essentially the same. They both have some
   extensibility, albeit limited by their own design.

   Both Vim and Emacs are built around the idea of text editing, NOT
   code editing. Both of them center around the idea that everything is
   a file, aka text, aka a part of the UNIX philosophy. If you want rock
   solid experience editing text, these are excellent. Once you attempt
   to make it understand and help you write code, it's NOT built for it,
   and you have to use something else running alongside it, and such is
   the curse of DSL. 

   Vim uses Vimscript, and Emacs uses Elisp. Despite how good they are,
   they are domain specific languages designed and written to understand
   text structures, NOT code structures. They have been used as code
   editors simply because features of modern code have been designed to
   act like text. Your Python program has indents to help you understand
   structures of functions/classes, your C program have "{}" to help you
   understand its strucs, types, etc. Languages have keywords that are
   positioned at certain positions so that we can use some kind of
   regular expression to parse and highlight. These structures have been
   used by text editors to utilize their similarity with code, so you
   can delete between brackets and such. They are a TRICK of a sort to
   make it look like there's some understanding of code via syntax
   highlighting, but once you move to code completion or Language Server
   Protocol or other ideas, you realize that all this toolbox is NOT
   built to handle it, and there isn't any real incentives for either
   communities to get more specific features to understand code, so you
   rely on a NodeJS instance running in the background to do LSP, or you
   rely on a tree-sitter (no tree-sitter for vim, but yes for neovim,
   integration with Emacs is ongoing) instance running in the
   background. There's Ctags (universal ctags), which is good enough for
   many tasks and small enough, but that's not tree-sitter, even
   tree-sitter is not as good as it claims.

   There's nothing wrong with using NodeJS or tree-sitter, but once you
   use that, you are running something that is not that much different
   from an IDE with plugin systems and a multitude of processes running
   in the background, so the assumption of simplicity and running a
   small and reliable program goes away.

   If you are a full-time developer, you NEED IDE-like
   functionalities,if I were to guess, in which case this config is not
   what you are looking for.

2. But vim and Emacs are not the same. At least you can escape Vim, but
   you cannot escape emacs.

   I know "How to Quit Vim" is a meme these days, but that's the
   point.Once you learn Vim, you don't have to stick to it for
   everything. Its language, Vimscript, is designed in such a way that
   it is only comfortable for writing vim config and text manipulation.
   Emacs is a different story. People write elisp to do anything they
   please, and it's a TRAP that prevents you from learning anything
   else, so not good for beginners, and it's not fast enough. Modern
   emacs implementations (emacs-nativecomp, or Gcc-emacs) have to
   use an intermediate language to speed up the code compiliation
   and interpretation from elisp to C and finally to assembly.

   At least vim is small enough and not powerful enough. You use it to
   edit text, and it has built in functionality to communicate and call
   other programs within your system, so you can get familiar with other
   programs outside of Vim. Emacs have eshell built in there so you
   don't ever need to escape its comfort zone, and you can
   write a million programs that mimic other existing UNIX programs.
   It's not called Editor MACros for nothing. It is the equivalence of
   Golang in a sense. 

3. I just wish there were good enough Vim emulation outside of Vim
   itself so I don't have to use it. Or else Vim have actual SERVER
   MODE. Vim's clientserver is not server mode that you think.

   I know, every IDE have Vim keybindings, but they are not Vim.
   Remember our lesson before? Emulation is ALWAYS emulation, not the
   reality it emulates. The more emulation, the more trouble. Look no
   further than vim emulation plugin in VSCode. It's only mimicing vim
   motion, and it's still not feature-complete. You are relying on
   VSCode to expose an API that they do not see why they need to expose
   in order to do code folding, which is a valid concern. Ideally, you'd
   have Vim running in the background understanding text and doing text
   manipulation when you are in the buffer editing text. On the front,
   you have an IDE that understands CODE and help you do all kinds of
   stuff. However, Vim is like Windows in a sense, its GUI and backend
   are so tightly intergrated, such that any way to attempt to separate
   and decouple them have failed thus far. Hopefully Neovim
   does a better job at this so we can get the best of both worlds.
   Fingers crossed.  WASM is one hope though. In an age where everything
   is Electron, you don't really have a choice.

## Neovim?

Someday. When it's good enough at the above point.

## IDEs?

This is a minimal setup, not to have a full IDE. Try Intellij suite or
VSCode if that tickles your fancy. Or even Visual Studio. I don't care.

## How to use


```bash 
cd $HOME && git clone https://github.com/samyilin/dotfiles && cd dotfiles && ./setup 

``` 

Tries to setup several configs for several programs.

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

