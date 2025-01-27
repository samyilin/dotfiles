# Intro

This is an abridged but long document about setting up Neovim in a way
that is plugin-agnostic.

The biggest distro in the space of Neovim are
[Lazyvim](https://www.lazyvim.org), [NvChad](https://nvchad.com) and
[AstroNvim](https://astronvim.com). I've examined all 3 distros and how
[mini.nvim](https://github.com/echasnovski/mini.nvim) and how its
creator does things. Couple of patterns start to emerge:

1. LazyVim is tightly integrated with Lazy.nvim and Snacks, although
   some Snacks can be swapped out with mini.nvim components. The main
plugin directory uses some util function in the util directory. This is
because, primarily, that Lazy.nvim is a plugin manager based on
manipulating tables, and so it naturally enforces a certain way of
writing out configs: return a table per directory, and write out all
functions and table manipluation in another file, to maintain a clean
config, so to speak. The problem is that
this approach hides the complexity of writing functions for plugins'
functionalities under the rug. Of course you can look at the source code
to understand what's really going on, but beginners who didn't realize
the importance of RTFM got this illusion that writing table config is
all what Neovim is all about. This is what I thought.

2. NvChad is a bit too barebone, but what's interesting about it is its
   base46 and ui repository. Basically this repo separates out UI components
into separate repos. The author has some ambition for sure, but the
problem is that these are too tightly integrated at the moment. What can
be nice is if there's a pure UI enhancement library for all the popular
plugins out there, that'll work regardless of any other plugin. So a
prettifier plugin.

3. AstroNvim. This one I haven't thoroughly examined, but from face
   value it feels a lot like LazyVim. This is to be expected. Using
Lazy.nvim will result in re-using their configuration style, but there
IS a bit of separation between Core and Community. The Community portion
has a lot of presets for different code runners, completion engines,
etc. That's great, but a lot of presets means no presets in my mind.
You're showing users that many presets, eventually either two things are
going to happen. Either you have too many presets to maintain for the
community, or someone realizes that they've read enough presets to start
their own config and abandon AstroNvim.


