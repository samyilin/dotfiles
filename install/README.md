# README

## Purpose of this folder?

This project is mainly aimed at setting up configs, not installing
packages. But certain installation scripts need to be maintained
somewhere, hence this folder. 

My setup scripts will not touch this folder, so this folder contains
optional install scripts that are useful for certain setups. 

Currently, this includes:

1. Nix. 
2. Homebrew. Once Nix is good enough on Apple silicon, this will be
   redundant(ish).


## Automate installation of packages or softwares?

No. Packages change name all the time, so it won't be wise to do this.
Nix recently changed vim full version's name from VimHugeX to vim-full,
for example. So it doesn't make sense to automate this stuff. 
