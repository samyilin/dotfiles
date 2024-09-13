# README

My Neovim config using LazyVim

## Introduction

I've started to use
[LazyVim](https://github.com/LazyVim/LazyVim), a Neovim setup powered by
Lazy.nvim.

## Why Neovim AND Vim?

I'm still maintaining my Vim configuration minimally, and Vim/Neovim serves
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

## Who should use Vim, or rather, who should gravitate towards Vim?

If you work on servers a lot, work on machines that you don't have control over
a lot, constantly SSH into other machines a lot, yeah you don't have a choice
but to use Vim.

If you prefer stability a lot, you prefer out-of-the-box a lot, then you need
Vim.

If you've been comfortably using Vim for years, I'm not trying to convince you
to switch. For me, the ability to render math symbol and images in terminal and
be able to get out of Jupyter web interface are features that I can't get in
Vim, and that's why I switched.

## Emacs? Any other editors?

I hinted at Emacs a lot, but I haven't gotten around o learning it yet. Reasons:

1. I don't have time to do it. You'd think it's an excuse, but it isn't, at
   least for now.
2. In Emacs there's too many ways to do one thing. I don't know what's better,
   literate config, one giant init.el or separate file for separate package
   customization. It's all personal preferences. I haven't found one convincing
   argument that made me determine that that's the way to go.
3. Emacs can do everything yes, but the learning curve is there as well. Vim
   keybinding and internals are more familiar to me, so I stick with Neovim for
   now.

Helix and Kakoune? Well they're both model editors, one has no plugin support
and the other has poor plugin support. I want a general purpose editor, not a
code editor. Neither of them are general purpose. Neovim, vim and Emacs are
general purpose editors, and hence good plugin system, because you can't
anticipate what users would want out of your editor.
