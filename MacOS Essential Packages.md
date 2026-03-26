# What is This?

Some packages are essential for CLI in a modern MacOS system, including
my own setup. Documenting them here.

## 1. Neovim requirements

Neovim requires:

1. tree-sitter-cli
2. rustup from its own installation script (not in Homebrew)
3. ripgrep (regex finder)
4. imagemagick (for image display, if you need it)
5. mmdc (for mermaid rendering, if you need it)
6. latex suite (for latex rendering, if you need it)
7. fd
8. lazygit delta (for now)

## 2. Neovim LS + formatter requirements

1. lua-language-server stylua
2. shfmt shellcheck
3. sqlfluff

## 3. other requirements

1. pyenv or uv for Python dev
2. starship for prompt
3. bash, bash-completion and git (for up-to-date modern packages)
4. vim and neovim
5. A good font (maple for now, have Chinese support)
6. Terminal (ghostty/kitty)

## 4. List xcode-select tools

```sh
ls "$(xcode-select --print-path)/usr/bin"
```

## 5. Setting default bash to Homebrew bash

```sh
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/bash"

```

## Making sure that homebrew packages are used first in bash scripts

Also, coreutils would alias all their installs with a g (ggrep instead
of grep), so make sure you adjust any script to use to use those. This
is within my .profile.

```sh
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
```
