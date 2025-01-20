# README

My Neovim config using LazyVim

## Introduction

I've started to use
[LazyVim](https://github.com/LazyVim/LazyVim), a Neovim setup powered by
Lazy.nvim.

For system requirement from Lazyvim, read their [front page](https://www.lazyvim.org/).

## Why Neovim AND Vim?

I'm still maintaining my Vim configuration minimally, and they serves
different purposes.

## Why LazyVim though? You don't use a distribution for Vim

 Vim has been around longer, so tpope's plugins will not be deprecated anytime
 soon, for example. Also, Vim plugins, LSP shenanigans aside, don't need a huge
 amount of glue code for cohesiveness. On the contrary, Neovim packages get
 deprecated very quickly (relatively speaking, most are here to stay for a
 while) and I don't have time to re-configure my packages and re-write my glue
 code just because
 [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) have been
 deprecated, for example.

LazyVim is a distribution for sure, but if you're careful enough, you CAN just
use it as a starting point to configure your own thing! The pieces that need
heavy tweaking are the things that you want. For me, it's Jupyter notebook
integration (I HATE Jupyter) that I have to write heavy customization for, which
Emacs has [this](https://github.com/astoff/code-cells.el). The rest I pretty
much use the defaults as-is. Also, I don't use directory trees, so I turn that
off and use oil.nvim instead. Neo-tree isn't loaded anywhere so I don't have to
care.
