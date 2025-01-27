# Vim Configuration

## Introduction / Clarification

This config is based on personal config and use case.

## Documentation

Inline documentation is hard to read(we are not doing emacs org mode),
so this is an abridged version. It is not meant to be inclusive. For
exhaustive documentation, see the actual configs.

### Starting Point

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
