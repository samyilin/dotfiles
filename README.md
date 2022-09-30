# Readme
This is my personal dotfiles, still in the works.
## How to use
It is advised to not soft- or hard-link the configs into another laptop directly, as that might override local configs that are of importance.

Context is, many programs (such as google-cloud-sdk or pyenv) loves to spew code into your .bashrc, and it is dependent upon your work setup. You might not even need it on a different machine. Sometimes it's just too late to realize that after the fact that many programs have been installed. WSL Ubuntu default setup, or a lot of auto-installed desktop environments loves to spew code into your .bashrc as well, so you need to preserve some or all of that code that is there. 

Instead, I've named these configs differently, such that if local configs need to be preserved, we can preserve the local configs and override them if necessary.

Simply do:

```bash
cd ~ && git clone https://github.com/samyilin/dotfiles.git

if [ -f ~/.bashrc]; then
    cat dotprofiles/.bashrc >> .bashrc
else
    touch .bashrc && echo '#!/bin/sh' >> .bashrc && cat dotfiles/.bashrc >> .bashrc || echo Unknown Error, Check User Priviledge
fi
```
would either append this bashrc or create a new file as bashrc.

You typically won't have a vimrc in the personal folder, so it shouldn't matter. Just override it.

But when you have to, let's say you are on someone else's laptop, do this:

1. defaults.vim. Good enough as a starting point without too much baggage on others' system. Just download it and 
```bash
git https://github.com/tpope/vim-sensible && cp vim-sensible/plugin/sensible.vi ~/sensible.vim
vim -u ~/sensible.vim
```
Should be a good enough minimal starting kit as a plain text editor. Missing some functionalities and themes, but it's a start.
2. Help the user setup your dotfile, question mark?

## Future State

All this is really unnecessary, thinking about getting a separate installation script for this purpose. When I have time, I will carve time to do that.

That way, a single ./install.sh with some arguments will do the trick.
