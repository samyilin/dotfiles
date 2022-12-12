# README
SSH setup related

## Introduction

SSH is complicated. SSH is an entire network protocol. Although I
inteneded to write a wrapper for OpenSSH only, it is still vastly more
complicated than what I'd hoped for. What makes it more complicated is
that openSSH uses file ~/.ssh/config instead of any kind of sane
documentation/API structure to manage per-connection setting AND have
fuzzy matching, so some other tools need to be invented or dependencies
need to be introduced to write a sane wrapper for SSH.  Pure shell isn't
going to cut it (shell doesn't parse text very well).  ANSI C maybe?
Regardless, this is not the place to write that.

One way to have a sane cross-platform solution
with as little dependencies as possible is:

1. Write a TUI program as the base wrapper to openSSH.
   [ncurses](https://invisible-island.net/ncurses/announce.html) maybe.

2. At the initialization of the program, use
   [sqlite](https://www.sqlite.org/index.html) or some cross-platform
   and minimal database to actually store the per-connection settings
   and fuzzy patterns.

3. Each time the program is called and changes are made to SSH
   configurations, remove existing ~/.ssh/config and create a new one
   off of the information stored in sqlite.

4. Make sure that this sqlite database can only be read and written to
   by the user.

There's a lot involved here, and a lot of testing is needed to make sure
that this works on different architectures and Operating Systems. So
really, this deserves its own repo, whenever I have time to do so.

If you want an end-to-end solution right now, try
[assh](https://github.com/moul/assh). Haven't used it myself, but it
should be a good wrapper. Written in Go, which is cross-platform enough.

If I only want to care about git + SSH setup though:

Every git provider (GitHub, GitLab and so on) have a lot of practical
instructions on how to set up git with SSH. Encryption method they
prefer could change as well. SSH itself is even more complicated.  

Instead, SSH related cheatsheet/tutorial will be documented in my
[cheatsheet](https:///github.com/samyilin/cheatsheets) when I have the
time to do some writing.
