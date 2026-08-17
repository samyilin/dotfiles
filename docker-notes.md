# Docker image verification notes

Notes from building and verifying the four Dockerfiles
(`Dockerfile.ubuntu`, `Dockerfile.fedora`, `Dockerfile.archlinux`,
`Dockerfile.alpine`) on an Apple Silicon Mac (MacBook Air, M5, arm64,
macOS 26.5) via Colima + Docker CLI. Verified 2026-08-17: all four
images build and `./setup.sh -d` completes (also passes the idempotency
re-run and `man` works inside each image).

## Environment

- Host: Apple M5, arm64, 16 GB RAM, macOS 26.5
- Homebrew: `brew install colima docker`
- VM: `colima start --vm-type vz --cpu 4 --memory 6`
  (vz = Apple Virtualization.framework; `docker` context switches
  automatically to `colima`)
- Teardown: `colima stop` (keeps the VM), `colima delete` (removes it)

## Results

| Image | Platform | Build | `./setup.sh -d` |
|---|---|---|---|
| Ubuntu 26.04 LTS | arm64 | OK | OK |
| Fedora 44 | arm64 | OK | OK |
| Arch Linux latest | amd64 (emulated) | OK | OK |
| Alpine latest | arm64 | OK | OK (~458 MB, smallest) |

Build roughly 5–15 min each; Arch under QEMU emulation is the slowest.
Run them sequentially to avoid CPU contention in the VM.

## Gotchas

### Ubuntu: `unminimize` was removed in 26.04

`ubuntu:latest` is Ubuntu 26.04 LTS "resolute", which no longer ships
`unminimize` (not even via the `ubuntu-minimal` package). The base image
is still minimized though: dpkg `path-exclude`s in
`/etc/dpkg/dpkg.cfg.d/excludes` strip man pages/docs, and `/usr/bin/man`
is a stub with the real binary diverted to `/usr/bin/man.REAL`.

`Dockerfile.ubuntu` replicates the old `unminimize` effect inline:
1. `rm -f /etc/dpkg/dpkg.cfg.d/excludes` — stop excluding docs/man pages
2. `apt-get install -y --reinstall ...` all installed packages — restore
   man pages/docs that were excluded at image build time
3. `rm -f /usr/bin/man && dpkg-divert --quiet --remove --rename
   /usr/bin/man` — drop the stub and put the real `man` back

Gotchas hit while writing the fix:
- The reinstall package list must be an *unquoted* command substitution
  (`$(dpkg --get-selections | awk '{print $1}')`); quoting it makes
  `/bin/sh` pass the whole newline-separated list as a single argument.
- A `setcap: not found` noise line from `iputils-ping.postinst` is
  harmless (no libcap in the base image).
- Re-check this when `ubuntu:latest` next bumps LTS; the minimization
  layout may change again.

### Arch: amd64-only image

`archlinux:latest` has no arm64 manifest. On Apple Silicon you must
build and run with `--platform linux/amd64`:

```sh
docker build --platform linux/amd64 -f Dockerfile.archlinux -t dotfiles:archlinux .
docker run --rm --platform linux/amd64 dotfiles:archlinux ./setup.sh -d
```

### Arch: pacman seccomp sandbox fails under emulation

Under QEMU x86_64 emulation pacman 7.1 fails with
`error restricting syscalls via seccomp: 22!` (EINVAL) and
`switching to sandbox user 'alpm' failed!`. The archlinux image already
sets `DisableSandboxFilesystem` in `/etc/pacman.conf` (landlock not
available in containerd); `Dockerfile.archlinux` additionally uncomments
`DisableSandboxSyscalls`:

```sh
sed -i 's/^#DisableSandboxSyscalls/DisableSandboxSyscalls/' /etc/pacman.conf
```

Cosmetic build noise that does not fail the build:
- `==> ERROR: There is no secret key available to sign with.` during the
  `archlinux-keyring` reinstall (pacman-key never initialized in a
  container — harmless).
- `error: command failed to execute correctly` from the Haskell module
  registration post-transaction hook (cosmetic; overall exit is 0).

### Alpine: fourth image, no platform flag needed

`Dockerfile.alpine` builds on `alpine:latest` (arm64 native; Alpine has
no amd64-only issue) and `./setup.sh -d` completes, is idempotent on
re-run, and man pages render (`man ls` formats fine without extra
groff). Image ~458 MB — the smallest of the four.

Alpine-specific packaging gotchas (package names differ from the
deb/rpm/pacman equivalents):

- `vimtutor` is a separate package (`vim-tutor`). Without it,
  `vim/requires` blocks the vim setup. Installing it makes vim setup run
  normally. This exposed a `setup.sh` bug: `has()` clobbered the caller's
  loop variable `cmd` (POSIX sh has no local scope), so the "requires X
  but it is not installed" message always printed a blank. Fixed by
  renaming `has()`'s internal variable to `has_cmd`.
- Man pages are split into per-package `-doc` subpackages:
  `coreutils-doc`, `vim-doc`, `git-doc`, `busybox-doc`, etc.
  `man-db` + `man-pages` alone cover only libc/syscall docs; `man ls`
  needs `coreutils-doc`.
- `delta` is the package name (not `git-delta`), and difft/difftastic is
  not packaged on Alpine — the lazygit setup falls back to delta, which
  it configures as git's pager.
- musl wheel check: the nvim Python venv (`nvim/requirement.txt`, incl.
  kaleido/cairosvg/pillow) installs cleanly via uv on musl (exit 0).
- Extended tooling is all packaged: tree-sitter-cli, rustup,
  lua-language-server, stylua, shfmt, uv, nodejs, npm, py3-pip, gcc,
  make. mmdc/mermaid-cli is npm-based (node/npm available); only its
  bundled-chromium path is a classic Alpine pain, and it is optional.

## Rebuild / verify commands

```sh
docker build -f Dockerfile.ubuntu -t dotfiles:ubuntu .
docker build -f Dockerfile.fedora -t dotfiles:fedora .
docker build --platform linux/amd64 -f Dockerfile.archlinux -t dotfiles:archlinux .
docker build -f Dockerfile.alpine -t dotfiles:alpine .

# idempotency check (setup must skip everything already configured)
docker run --rm dotfiles:ubuntu ./setup.sh -d
docker run --rm dotfiles:fedora ./setup.sh -d
docker run --rm --platform linux/amd64 dotfiles:archlinux ./setup.sh -d
docker run --rm dotfiles:alpine ./setup.sh -d
```

Manual-page sanity check inside an image:

```sh
docker run --rm dotfiles:ubuntu sh -c 'man -w ls && man ls | head'
```

## RPM-family base image choice for documentation

All RPM-family container bases (Fedora, CentOS Stream, Rocky, Alma, UBI)
strip docs the same way: `tsflags=nodocs` in `/etc/dnf/dnf.conf`. The
restore mechanism is therefore uniform (`dnf -y reinstall "*"`, which
`Dockerfile.fedora` already does). What actually differs is whether the
docs exist in the RPMs at all:

- **Fedora** — packages ship full `%doc`/man/info content; docs are
  genuinely restorable by removing the flag and reinstalling.
- **RHEL / UBI / Rocky / Alma** — documentation is deliberately left out
  of the packages (RHEL ships docs on access.redhat.com instead), so
  reinstalling recovers little. UBI-minimal is additionally
  `microdnf`-only, which makes the reinstall-all trick awkward.

So for an RPM-family dev image with working `man`, Fedora is the only
realistic pick. Ecosystem note: third-party artifacts skew toward
`.deb`/apt, which is why Ubuntu is the common container default; within
the RPM family, Fedora + EPEL covers most of the long tail.
