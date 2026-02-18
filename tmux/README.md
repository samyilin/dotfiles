# README

Tmux configuration.

## Introduction/Clarification

This is not a thorough setup like
[oh-my-tmux](https://github.com/gpakosz/.tmux).
[TPM](https://github.com/tmux-plugins/tpm) is also an overkill.

## Documentation

1. A lot of people prefer using Ctrl-a over Ctrl-b as the prefix due to Ctr-a
   being the default on [GNU Screen](https://www.gnu.org/software/screen/). I
   don't really care for either, so I've used Ctrl-b as my prefix.

2. Default keybinding "Ctrl-b ?" gives abridged version of list-keys, but I've
   forced it to print out all the nitty-gritty details of key maps.

3. use copy-mode-vi to force vi-like key bindings. Does it matter? Meh. I don't
   use bash's vi-like keybindings either even though I have set them up.

## Style/colorscheme?

Colorscheme used here is Gruvbox, I've barely grabbed the palette from
[Gruvbox](https://github.com/morhetz/gruvbox) itself.

## [Zellij](https://zellij.dev/)?

TBH I don't even use tmux that often, so no.

These days I use Wezterm/Kitty's local functionalities most of the time anyways.
