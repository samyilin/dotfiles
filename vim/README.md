# My Vim Configuration

## Introduction / Clarification

This config is based on personal config and usecase, not
meant to be a universally usable IDE-like configuration like
[spacevim](https://spacevim.org/), [Lunarvim](https://www.lunarvim.org/)
or the like.

Be warned, any vim configuration framework large enough will tend to use
a lot of packages, which depend on separate package maintaniers to keep
backward compatibility to maintain your current workflow, which is
nigh-impossibe. Mininizing dependency on other people's work should be
your priority unless the package is really good and stable, so I do not
recommend using huge projects with a complete framework and a lot of
packages. Depending on other people to do your work for you is never a
good idea.

You CAN pin your package manager to use a specific version of any
package, but then you'll miss out some new features. There's always a
tradeoff.

## Documentation

Inline documentation is hard to read(we are not doing emacs org mode),
so this is an abridged version. It is not meant to be inclusive. For
exhaustive documentation, see the actual configs.

### Basic Principles

1. Use a package manager. In a relatively modern vim version, you'll
   have a built-in package manager. However, it's very primitive. It
   doesn't really matter what package manager you use. Try different
   ones.

2. Use [vim-sensible](https://github.com/tpope/vim-sensible) as our
   default configuration layer. Many Vim configs out there have many
   lines that could have been avoided simply by using this.

3. netrw is good enough for a file explorer within Vim, although
   it has many weird quirks. For that, I use
   [vim-vinegar](https://github.com/tpope/vim-vinegar).

4. Use [vim-fugitive](https://github.com/tpope/vim-fugitive) as a git
   wrapper.

5. Modularity. Still WIP. Discussed Below.

### Modularity

Any vim or Emacs configuration sophisticated enough will turn into a
modular setup. Question here is, what do I want to do about it?

When working with Python and Bash codes, I've come to the conclusion
that

1. Vimrc will only grow exponentially in size with respect to the amount
   of language or tools you try to work with.

2. Vim needs to, and have the tools necessary to interop with a lot of
   other tools and achieve almost native coherence. It just needs to be
   implemented in the configuration layer.

   [autopep8](https://github.com/hhatto/autopep8) is a good example, by
   setting it up with equalprg, it can be a smooth experience.

   Of course LSP is a different issue, there's too many players in the
   arena of LSPs for Vim.

3. Many modular setups try to pull all dependencies down at once, which
   is BAD. You don't know that the user uses all 200 languages you're
   configuring for.
