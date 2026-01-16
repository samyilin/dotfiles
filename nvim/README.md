# README

Revamping to not use LazyVim as Neovim configuration.

## Why?

I've opted to simplify my workflow so I can better understand what's hapapening. LazyVim sometimes work well, sometimes an upstream update on either Neovim, LazyVim or other packages will nuke my SQL settings and I don't know why.

Setting my own thing is a hassle, but Neovim community is mature enough, and Neovim is OOTB enough for me to get rid of as many dependencies as possible.

## DIY requirements

I have to install LSPs, formatters, DAPs, etc. using other means and not rely on Mason anymore. Which should've been the case anyway.

On MacOS use Homebrew, on Linux use whatever package manager you have, on Windows... WSL or scoop I think are the easiest ones.

I will later document more thoroughly the LSPs/formatters I use per file type, when this config is mature enough.

## What I'm getting rid of

I'm getting rid of package manager in favour of builtin package manager vim.pack. I think it simplifies things drastically.

I'm getting rid of a lot of UI niceties for simpler approaches, yes it isn't as pretty, but the point is to reduce dependency as much as possible.

## What I'm keeping

The "essentials", as minimal as possible, though not married to this idea.

Note that Neovim have plans to replace netrw. When that time comes, I will get rid of netrw enhancements such as vim-vinegar and netrw.lua.

## How long am I dedicating to completing this DIY project?

Try to finish it off as quick as possible in my spare time. So... Months?
