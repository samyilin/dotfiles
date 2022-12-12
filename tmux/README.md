# README

# Introduction/Clarification

This is not a thorough setup like
[oh-my-tmux](https://github.com/gpakosz/.tmux). This is a very
preliminary setup so that I could gradually learn how to proceed
customizing tmux to my liking. Oh-my-tmux has a lot of
prerequisites/dependencies in order to use tmux (awk perl and sed,
common utilities, but still). [TPM](https://github.com/tmux-plugins/tpm)
is also an overkill. What do I need [battery
information](https://github.com/tmux-plugins/list) for?

# Documentation

Unlike Emacs or other programs, keymaps are not really dynamically
displayed when you hit ctrl-b ? (question mark) when in tmux session. So 

```bash
tmux show-options -g
```
is the only way to know what your settings are, and even that is not
good enough insofar that it is NOT what your .tmux.conf will look like. 

Therefore it is better to document them here.


# Style/colorscheme?

One can tweak tmux to no end, hence I've half-assed it. 

Implemented what is cross-platform from
[tmux-gruvbox](https://github.com/egel/tmux-gruvbox/blob/main/tmux-gruvbox-dark.conf).
This requires usage of [Hack
Font](https://github.com/source-foundry/Hack). If you want to use those
instead, go ahead. You can use TPM (link provided above) with
combination as well.

## TODO
