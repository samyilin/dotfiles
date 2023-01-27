# README

## Introduction

Neovim is a relatively new project. Vimscript plugins can be directly used in
Neovim, but Neovimmers tend to use plugins written in pure Lua. However, so many
development is happening in Neovim side that the most basic operations or APIs
within Neovim itself could change at any moment, not mentioning plugins. Best
practice within Neovim is always subject to which Neovim version you're speaking
to. 

It's for this reason that I used [kickstar.nvim](https://github.com/nvim-lua/kickstart.nvim), a
good enough starter kit for Neovim. Apart from this, other configs are scattered
here according to Neovim's specs. 

Apart from this, it is a good enough IDE-like configuration, with LSP and
everything! What's not so good is, you'll have to install Python/npm
dependencies by yourself. Consult Dockerfiles in this project for basic
pre-requisite system packages required by this setup. Will refine if I ever need
further functionalities.
