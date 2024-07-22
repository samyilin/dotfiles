# README

This is my dotfile. Usable both as a standalone Git repository or work in a
Docker environment as a development container.

What is a dotfile? By tradition, on Unix systems (Linux, BSDs, Mac, etc.)
configuration folder(s) are stored in user's home directory and typically
started with a ".", and operating systems set these folder(s) as hidden by
convention. If you use ls in your home directory, you won't see these files
unless you use certain flags. So dotfiles are user customization per
application for Unix users.

This repo has 3 purposes:

1. This is my personal dotfile. I do try to make it as distro/OS-agnostic as
   possible though.

2. To force myself to learn shell programming, tmux configuration, etc.

3. To be able to run development container(s).

I do realize that [GNU Stow](https://www.gnu.org/software/stow/),
[chezmoi](https://www.chezmoi.io/) and the like exists. Chezmoi intrigues me a
lot, may be I will try that one day.

## Design Principles

1. Do not overwrite existing configuration. This is a common scenario in
   Linux/MacOS environments:

   1. Various configurations are already there when personal configuration
      begins. Some systems would create .bashrc in your home directory
      automatically.

   2. Programs love to spew lines to .bashrc or .profile, so they cannot be
      assumed to be static.

2. Leave shell config for programs to abuse. These are copied to home
   directory rather than linked.

3. Use links for customizations that are not related to application abuse.

4. Make sure it (this config) is easy to delete. After deleting this config,
   you should have a default or non-existent config.

   Keep in mind that removing this config won't help you uninstall packages
   such as vim, emacs, etc. This is the job of your package manager.

5. Make it modular. Scripts/configs for each program should be separated by
   folder to make maintenance easy.

6. Make it so that using setup script(s) repeatedly will skip the parts that's
   already been set up.

7. Make it as simple and cross-platform as possible. What does cross-platform
   even mean? Hard to tell these days. But I chose POSIX shell for now.

8. Use POSIX shell purely to ensure portability on systems when launched.

## Assumptions

There're very few assumptions here, not in any particular order:

1. You are running a UNIX-ish system. MacOS is fine, although they have very
   old Bash version that is GPL2.

2. You would prefer to have more than 1 ssh setup if needed. Separation of work
   and life account is typically needed, amongst other reasons.

3. At least you have Busybox or similar minimal environment. This means some
   minimal shell (ash or dash).

## Non-assumptions

1. You are running GNU/Linux. Tested on Busybox ash.

2. You have bash as your interactive shell. If you don't have bash in your
   system, then .profile is loaded only. If you do use bash, then:

   1. .bash_profile is loaded, and it will load .profile.
   2. .profile does what it's supposed to do, and load in .bashrc.

   This is to ensure that .profile will be loaded no matter what.

## Goals/Programs configuring in this setup?

Bash, Vim, Neovim, tmux, SSH, git. A "complete" CLI working environment.

This script also helps you set up your user name and password where applicable.
Good for initializing things on WSL or other root systems.

Bash for interactive shell, Vim/Neovim for text editor, tmux for screen
multiplexer, ssh and git could work together or separately.

SSH setup script here is a wrapper to allow users to set up git and SSH so we
can SSH into git repos easier, and nothing else.

## Non-goals/Programs Not Configuring in this setup?

1. dircolors. I realize they exist, I just don't care about them enough to
   write one.

2. Zsh or fish. Working within shell CLI is minimal because nowadays I live in
   Vim/Neovim/Emacs whenever possible. So I don't even heavily rely on Bash at
   all.

3. Emacs. It deserves its own config repo. I find that I'm fascinated by it,
   but its inability to do certain things (web related, threading related,
   etc.) greatly diminish its full potential. If I were to use Emacs, I would use
   it with [EAF](https://github.com/emacs-eaf/emacs-application-framework) because
   it is more realistic to have web functionalities using ManateeLazyCat's ideas
   rather than GNU's. Let's be realistic, the Web is here to stay. So is Javascript.

4. IDEs/Full programming environment setup?

   Try IntelliJ suite if that tickles your fancy. Or even Visual Studio.

   My opinion:

   1. IDEs are better at being IDEs than editors. Don't try to use
      editor(s) to work with Java, for example.

   2. Manage your expectation of what your tool can do, what tool works best
      for your programming language and what tool your team expects you to use.

5. File lock checking, aka a form of race condition. Realistically this
   shouldn't happen.

6. Being able to curl/wget/download a setup file and go about installing
   config. If being up to date is required, then git is still needed. So such a
   setup is redundant.

## How to Set up and Use

There's 2 ways to set up this config.

1. Using this dotfile on an existing install. In other words, not a container
   setup.

   To pull this repo to your OS:

   ```bash
   cd $HOME git clone https://github.com/samyilin/dotfiles.git
   ```

   To set up everything:

   ```bash
   cd $HOME/dotfiles ./setup && . "$HOME"/.profile
   ```

   To setup additional programs after initial setup, i.e. your initial setup
   did not install vim but now it does, do

   ```bash
   cd $HOME/dotfiles ./setup YOUR_PROGRAM
   ```

   Design principles above will make sure no repeated install would happen.

   To get the latest from this setup, do

   ```bash
   cd $HOME/dotfiles git pull
   ```

   If you want to remove this config:

   ```bash
   cd $HOME/dotfiles ./remove && . "$HOME"/.bash_profile
   ```

   If you want to remove config for a certain program, i.e. vim, then

   ```bash
   cd $HOME/dotfiles ./remove YOUR_PROGRAM
   ```

   To remove this repo from your setup altogether, do

   ```bash
   rm -rf $HOME/dotfiles
   ```

   Additional mode:
   Docker/default mode. Skips over interactive mode that the user need to
   intervene, i.e. setting up username/password, git and ssh. This is the
   default on Docker setup. More about this below.

   To install using non-interactive mode:

   ```bash
   cd $HOME/dotfiles ./setup -d
   ```

2. Using this dotfile to setup a docker/podman image. This is good for
   developing in a container and avoid "dependency hell."

   To use this method, you would need to install docker or podman on your
   setup. I would suggest podman.

   I have 3 Dockerfile here, one Ubuntu based (more stable-ish, although I use
   the latest Ubuntu release), one Fedora rawhide based (cutting-edge, good for
   testing latest software) and one Archlinux based (bleeding-edge, good for
   testing development software)

   Using the appropriate Dockerfile name, the below code would generate a
   docker image:

   ```bash
   cd $HOME git clone https://github.com/samyilin/dotfiles cd dotfiles
   docker build -f Dockerfile.DISTRO -t IMAGE_NAME
   ```

   Podman requires using buildah to build image, so:

   ```bash
   cd $HOME git clone https://github.com/samyilin/dotfiles cd dotfiles
   buildah build -f Dockerfile.DISTRO -t IMAGE_NAME
   ```

   To enter this image, use

   ```bash
   docker run -it --rm localhost/IMAGE_NAME
   ```

   On podman, use

   ```bash
   podman run -it --rm localhost/IMAGE_NAME
   ```

   Default container/docker install would not help you set up ssh and git.
   These belong in your host system so you don't have to reset your ssh every
   time you spin up a container. To mount host's ssh and git configurations,
   use something like

   ```bash
   docker run -it --rm -v $HOME/.ssh:$HOME/.ssh \ -v $HOME/.gitconfig
   $HOME/.gitconfig \ localhost/IMAGE_NAME

   ```

   You can use a similar process to mount your git repo to the container so you
   don't have to keep copying your repo over. Writing a basic Bash script for
   this is trivial and won't be covered here.

## Systems Tested

I've tested this setup in Alpine, Arch, Ubuntu and Fedora Linux containers.
Also MacOS. I would try this in VMs one day.

Will try to test this on BSD VMs one day.

## Misc

I don't heavily rely on Bash these days. What can be done in interactive
shells, similar things can be done in Vim/Neovim/Emacs or any other editor that
is extensible enough. It is still good to learn though. Reasoning below:

Unix philosophy is important to consider but may not be the holy grail that
every greybeard claims. Example rebuttal: [The Nature of the Unix
Philosophy](http://xahlee.info/UnixResource_dir/writ/unix_phil.html). But the
true nature is this: [The Rise of Worse is
Better](https://www.jwz.org/doc/worse-is-better.html). In case neither of these
wasn't stating the obvious, let me be very clear here what they really mean in
modern language.

Computer science started in academia but found its home in corporate
settings. As such, the MIT style of design was considered the right thing to
do. The holy grail. But as every modern program manager, software engineer,
etc. knows, business requirements change all the time. Before carefully
constructing the golden solution, you need to realize that:

1. Solving the problem can be profitable or at least practically useful.
2. The problem can be solved. As Turing machines, software have limitation
   in what they can do. GPTs are a different story, but they also have their
   limitations. We haven't constructed a God, yet.
3. You are sure of what the problem is. The thing is, do you really know
   what problem you're trying to solve? Very often problem solving involves
   setting out to solve A, but found out that the real problem is B, but you
   have to solve C and D in order to get close to understanding B.

Therefore the New Jersey way is the only way to get things done, at the street,
outside of the walled garden of academia. It's just real life verses academia,
and real life always wins because money talks and bullshit walks, amongst other
reasons. Here are 2 contrary extremities that are talked about in the Rise of
Worse is Better.

Everybody who used Lisp claimed it to be a superior language with a better
design, yet it faced the 1000 Implementation problem. Why? Academia
triumphed because people wanted to have the golden solution to their domain
problem (oversimplification of course, but a majority of it is this). But as
the AI frenzy of the last century came to a halt, all their beautiful DSL
lost their Domain: AI. So eventually real life won and Lisp and Lisp Machine
(hardware catered to a single programming language, yes they desperately
wanted this to work) fell into 1000 pieces, whereas C really spread like
wild fire, coupled with the fact that UNIX was built using C.

On the contrary, UNIX philosophy was a practical way to solve problems, by
implementing useful program to address a problem at hand first, then another
problem at hand, etc. The Unix idea of "everything is a file" is to simplify
the problem of designing a system where we don't know pre-emptively all the
intricacies of what abstraction is the best solution to what problem. It's
very hard to argue that the right way to talk to USB is via a file, a better
interface should be an API, in hind sight. However, OS design got stuck at
UNIX plus Windows as the only 2 widely used operating systems, so the legacy
of UNIX got worshipped for eternity. It is a historic coincidence and local
optimal solution at best, which is typically where all software got stuck at.

So... What is the golden solution for everyday devs who are trying to get
their work done? Practically none, other than try to not get stuck by the
'standard' tools invented in the past that are local optima. For example,
unless you're a sysadmin who constantly need to write portable scripts that
run on sh + Grep + awk + sed, there's no practical reason to stick to
POSIX-compatible versions of any of those tools. Use ripgrep for grep, fd
for find, neovim for vi/vim, etc. Don't make your life harder than needed.

If you really want the greybeards' power tools, look at [The
Grymoire](https://www.grymoire.com/index.html). This is a series of
practical guide for Unix/Linux tools that is actually pleasant to read,
unlike the [POSIX standard
specification](https://pubs.opengroup.org/onlinepubs/9699919799/) (which you
have to read if you found Grymoire not clear enough).
