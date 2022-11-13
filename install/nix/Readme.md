# What is this?

This is a small script/cheat-sheet so that [nix](https://nixos.org/) install can be
more or less painless. Most of this can be found in [Download Nix](https://nixos.org/download.html)
and [package search](https://search.nixos.org/packages).

## Why nix?

managing package is a pain, especially when stability of distro you use
will work against you getting the newest packages. 

The current work flow for me is as follows:

1. Install a Linux distribution that is very stable in its core. What
   that means is, install something as rock solid as Debian, or at least
   Fedora/Centos/Nobara/Silverblue, insofar that they are well packaged
   and maintained.

   I don't want to go down the Arch Linux rabbit hole, that's what I'm
   saying. Arch is good for what it does, but it's more for personal PC
   and less for industrial work. No sane person would use a rolling
   release on servers.

2. For baseline tools that are less relevant if I get the latest package
   or not, install using the system's default package manager. Does it
   matter if I have the latest version of tmux? Not really. Then I use
   system-default package using apt, dnf, pacman or other default
   package managers.

3. For userland tools that I have a specific taste for and the baseline
   distro package manager don't have the latest version for, or that it
   requires extraneous effort for ([COPR](https://copr.fedorainfracloud.org/), 
   [PPA](https://launchpad.net/ubuntu/+ppas), [AUR](https://aur.archlinux.org/)),
   I just use nix packages to simplify my life cross-platform.

## Why not [homebrew](https://brew.sh/)?

1. I don't use MacOS right now, so I don't see the point to do it.
2. As far as I know, Homebrew has its weird quirks. Can't recall a lot
   of it, but it had something to do with elevated priviledges and
   installing on a folder that shouldn't be touched. 

I'll probably change my opinion when I actually use MacOS, but it's good
enough for now.


