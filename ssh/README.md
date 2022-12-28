# README

SSH setup related

## Introduction

SSH is complicated. SSH is an entire network protocol. What makes it
more complicated is that openSSH uses file ~/.ssh/config instead of any
kind of sane documentation/API structure to manage per-connection
setting AND have fuzzy matching, so some other tools need to be invented
or dependencies need to be introduced to write a sane wrapper for SSH.
Pure shell isn't going to cut it (shell doesn't parse text very well).
ANSI C or Go would be the right language for this job. Regardless, this
is not the place to write that.

One way to have a sane cross-platform solution with as little
dependencies as possible is:

1. Write a TUI program as the base wrapper to openSSH.
   [ncurses](https://invisible-island.net/ncurses/announce.html) maybe.

2. At the initialization of the program, use YAML or JSON to actually
   store the per-connection settings and fuzzy patterns. YAML or JSON
   are saner configuration formats.

3. Each time the program is called and changes are made to SSH
   configurations, remove existing ~/.ssh/config and create a new one
   off of the information stored in configuration file.

4. Potentially, make it so that this configuration file can only be
   read and modified by the user.

There IS a tool like this
[ssh-config](https://github.com/1and1/ssh-config). Never tried it, but
it being written in Java is a bit less cross-platform than what I'd
like.

A different question is, can we have a tool to do ssh configuration PLUS
managing your git connection so you know how many git repos have heen
created on your setup and where they are, and can this tool understand
how many of them are pulled using which SSH config and where these repos
are? Plugins in vim or tmux or a lot of other softwares use git to
actually make them work.  What this requires is to write a wrapper for
git, albeit very lightweight one, so that whenever git is called, our
bespoke application is called first to store configuration sate
information and then git runs. Your system git would be a symlink to
this application, or something like that, which then calls git. This
ensures that all other applications calling git would actually call our
program.

There's a lot involved here, and a lot of testing is needed to make sure
that this works on different architectures and Operating Systems. So
really, this deserves its own repo, whenever I have time to do so.

Instead, SSH related cheatsheet/tutorial will be documented in my
[cheatsheet](https:///github.com/samyilin/cheatsheets) when I have the
time to do some writing.

## What about this script?

This is just a wrapper for a ssh+git workflow. This script is
self-explanatory already. I will add more documentation here if needed.
