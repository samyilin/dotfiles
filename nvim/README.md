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

I'm getting rid of pickers. Yes I am trying to do that. :grep and :find is really what you're looking for.

The only thing I'm missing is quickfix on find, I will find a way to achieve this.

I'm getting rid of package manager in favour of builtin package manager vim.pack. I think it simplifies things drastically.

## What I'm keeping

The "essentials", as minimal as possible, though not married to this idea.

## How long am I dedicating to completing this DIY project?

Try to finish it off as quick as possible in my spare time. So... Months?
