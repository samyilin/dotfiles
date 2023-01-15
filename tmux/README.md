# README

Tmux config. Unstable ATM.

# Introduction/Clarification

This is not a thorough setup like
[oh-my-tmux](https://github.com/gpakosz/.tmux). This is a very
preliminary setup so that I could gradually learn how to proceed
customizing tmux to my liking. Oh-my-tmux has a lot of
prerequisites/dependencies in order to use tmux (awk perl and sed,
common utilities, but still). [TPM](https://github.com/tmux-plugins/tpm)
is also an overkill. What do I need [battery
information](https://github.com/tmux-plugins/list) for? Many of these
tools require Python or node, not cross-platform or minimal for my
taste.

# Documentation

1. A lot of people prefer using Ctrl-a over Ctrl-b as the prefix due to
   Ctr-a being the default on [GNU
   Screen](https://www.gnu.org/software/screen/). I don't really care
   for either, so I've used Ctrl-b as my prefix.

2. Default keybinding Ctrl-b ? gives abridged version of list-keys, but
   I've forced it to print out all the nitty-gritty details of key maps.

3. use copy-mode-vi to force vi-like key bindings.



## Tutorial?

A lot of great tmux tutorials exist out there. One that I like is [tmux
tutorial](https://protechnotes.com/comprehensive-tmux-tutorial-for-beginners-with-a-cheat-sheet/).
Not going to write one here.

## Style/colorscheme?

One can tweak tmux to no end, hence I've half-assed it. 

Colorscheme used here is Gruvbox, I've barely grabbed the palette from
[Gruvbox](https://github.com/morhetz/gruvbox) itself. Would I write a
wrapper for it later on? Maybe.  

## TODO
