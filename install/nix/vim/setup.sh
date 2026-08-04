#!/bin/sh

if ! command -v vim >/dev/null 2>&1; then
  nix-env -iA nixpkgs.vim-full
fi
