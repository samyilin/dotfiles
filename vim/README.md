# My Vim Configuration

## Introduction / Clarification:

This config isn't original at all. No configuration is. 

1. You look at how other people configures stuff and takes the best bit
   you agree with. 

2. Vim configurations are written using vimscript, a custom DSL designed
   to write non-original configurations that vim allows and exposes
   those APIs for you to configure. Not an easy language to write
   original code in.

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

I have been trying to make my vim configuration to be as modular as
possible, it has been a work in progress for some time though.

## Documentation

Inline documentation is hard to read(we are not doing emacs org mode),
so this is an abridged version. It is not meant to be inclusive. For
exhaustive documentation, see the actual configs.

### Basic Principles

1. Use a package manager. In a relatively modern vim version, you'll
   have a built-in package manager. However, it's very primitive and not
   that far away from either vim-pathogen or vundle (see link below). It
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
   [coc-explorer](https://github.com/weirongxu/coc-explorer). 

TODO
