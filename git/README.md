# README

A very simple global configuration tool for git

## Introduction

Git configuration can be quite long, but this is a simple wrapper to set a
global core configuration for git. It assumes you use 1 git profile (email+name)
to work with git + ssh, but if you work with more than one git profile, for
example you have no dedicated work laptop and have to use git for both personal
and work projects, then you'd have to set that per repo connection yourself. Not
too difficult.

## What does this script do?

Helps you set up name, email used by your git/ssh and your git editor. The
editor setting is not really needed. If you use git,
[vim-fugitive](https://github.com/tpope/vim-fugitive) is your best friend. If
you use emacs, [magit](https://magit.vc/) or
[eaf-git](https://github.com/emacs-eaf/eaf-git) should be suffice for you.
