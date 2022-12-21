# My Vim Configuration

## Introduction / Clarification:

This config isn't original at all. No configuration is. 

1. You look at how other people configures stuff and takes the best bit
   you agree with. 

2. Vim configurations are written using vimscript, a custom DSL designed
   to write non-original configurations that vim allows and exposes
   those APIs for you to configure. 

I will add their (other people who I took bits of configuration from)
name and/or git repository links in due time.

Furthermore, this config is based on personal config and usecase, not
meant to be a universally usable IDE-like configuration like
[spacevim](https://spacevim.org/), [Lunarvim](https://www.lunarvim.org/)
or the like. 

Be warned, any vim configuration framework large enough will tend to use
a lot of packages, which depend on separate package maintaniers to keep
backward compatibility to maintain your current workflow, which is
nigh-impossibe. Mininizing dependency on other people's work should be
your priority unless the package is really good and stable, so I do not
recommend using huge projects with a complete framework and a lot of
packages. Depending on other people to do your work for you is never a
good idea. 

You CAN pin your package manager to use a specific version of any
package, but then you'll miss out some new features. There's always a
tradeoff.

## Documentation

Inline documentation is hard to read(we are not doing emacs org mode),
so this is an abridged version. It is not meant to be inclusive. For
exhaustive documentation, see the actual configs.

### Basic Principles

1. Use a package manager. In a relatively modern vim version, you'll
   have a built-in package manager. However, it's very primitive. It
   doesn't really matter what package manager you use. Try different
   ones.

   Right now I use [dein](https://github.com/Shougo/dein.vim). Shougo is
   an interesting character, although a lot of what he writes are in
   Japanese. You can also check out
   [plug](https://github.com/junegunn/vim-plug),
   [vim-pathogen](https://github.com/tpope/vim-pathogen) or
   [Vundle](https://github.com/VundleVim/Vundle.vim). Vim-plug and dein
   are the more modern ones.

2. Use [vim-sensible](https://github.com/tpope/vim-sensible) as our
   default configuration layer. Many Vim configs out there have many
   lines that could have been avoided simply by using this. Not much to
   disagree on there, very stable package.

3. netrw (:help netrw inside vim's normal mode, a built-in file explorer
   within Vim) is good enough for a file explorer within Vim, although
   it has many weird quirks. For that, I use
   [vim-vinegar](https://github.com/tpope/vim-vinegar).

   Alternatives, nonexhaustive, are
   [dirvish](https://github.com/justinmk/vim-dirvish),
   [nerdtree](https://github.com/preservim/nerdtree) and
   [coc-explorer](https://github.com/weirongxu/coc-explorer). Dirvish is
   the most minimal one, nerdtree is the most popular one, and
   coc-explorer I'm not too familiar with, but it's allegedly very good. 

4. Use [vim-fugitive](https://github.com/tpope/vim-fugitive) as a git
   wrapper. I've stopped using git from command line altogether because
   of this.

5. Modularity. Still WIP. Discussed Below.

### Modularity

Any vim or Emacs configuration sophisticated enough will turn into a
modular setup. Question here is, what do I want to do about it? 

When working with Python and Bash codes, I've come to the conclusion
that 

1. Vimrc will only grow exponentially in size with respect to the amount
   of language or tools you try to work with.

2. Vim needs to, and have the tools necessary to interop with a lot of
   other tools and achieve almost native coherence. It just needs to be
   implemented in the configuration layer. 

   [autopep8](https://github.com/hhatto/autopep8) is a good example, by
   setting it up with equalprg, it can be a smooth experience. 

   Of course LSP is a different issue, there's too many players in the
   arena of LSPs for Vim.

3. Many modular setups try to pull all dependencies down at once, which
   is BAD. You don't know that the user uses all 200 languages you're
   configuring for, for example. What would be the best way to achieve
   this? Still thinking about this.
