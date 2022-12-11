# What is this?

This is a small set of scripts/cheat-sheet so that
[nix](https://nixos.org/) install can be more or less painless. Most of
this can be found in [Download Nix](https://nixos.org/download.html) and
[package search](https://search.nixos.org/packages). They don't do a
good job of covering the basics though, hence why this.

## Why nix?

managing package is a pain, especially when stability of distro you use
will work against you getting the newest packages. 

The current work flow for me is as follows:

1. Install a Linux distribution or WSL distro that is very stable or at
   least not unstable. What that means is, install something as rock
   solid as Debian, or at least Fedora, insofar that they are well
   packaged and maintained and NOT a rolling release.

2. For baseline tools that are less relevant if I get the latest package
   or not, install using the system's default package manager. Does it
   matter if I have the latest version of tmux or bash? Not really. Then
   I use system-default package using apt, dnf, pacman or other default
   package managers.

3. For userland tools that I have a specific taste for and the baseline
   distro package manager don't have the latest version for, or that it
   requires extraneous effort for ([COPR](https://copr.fedorainfracloud.org/), 
   [PPA](https://launchpad.net/ubuntu/+ppas), [AUR](https://aur.archlinux.org/)),
   I just use nix packages to simplify my life cross-platform.

Hopefully I'll get to documenting this in my other repos.

## Why not [homebrew](https://brew.sh/)?

1. I don't use MacOS right now, so I don't see the point to do it.

2. As far as I know, Homebrew has its weird quirks. Can't recall a lot
   of it, but it had something to do with elevated privilege and
   installing on a folder that shouldn't be touched. /usr/bin I think.

I'll probably change my opinion when I actually use MacOS, but it's good
enough for now.
