# Docker image verification notes

How to build and verify the four Dockerfiles (`Dockerfile.ubuntu`,
`Dockerfile.fedora`, `Dockerfile.archlinux`, `Dockerfile.alpine`) on an
Apple Silicon Mac (Apple M5, arm64, macOS 26.5) via Colima + Docker
CLI, plus the per-distro gotchas and their fixes.

## How to build & verify

### Environment

- Host: Apple M5, arm64, 16 GB RAM, macOS 26.5
- Homebrew: `brew install colima docker`
- VM: `colima start --vm-type vz --cpu 4 --memory 6`
  (vz = Apple Virtualization.framework; the `docker` context switches
  automatically to `colima`)
- Teardown: `colima stop` (keeps the VM), `colima delete` (removes it)

### Rebuild

```sh
docker build -f Dockerfile.ubuntu -t dotfiles:ubuntu .
docker build -f Dockerfile.fedora -t dotfiles:fedora .
docker build --platform linux/amd64 -f Dockerfile.archlinux -t dotfiles:archlinux .
docker build -f Dockerfile.alpine -t dotfiles:alpine .
```

Build roughly 5–15 min each; Arch under QEMU emulation is the slowest.
Run them sequentially to avoid CPU contention in the VM.

### Verify

```sh
# idempotency check (setup must skip everything already configured)
docker run --rm dotfiles:ubuntu ./setup.sh -d
docker run --rm dotfiles:fedora ./setup.sh -d
docker run --rm --platform linux/amd64 dotfiles:archlinux ./setup.sh -d
docker run --rm dotfiles:alpine ./setup.sh -d

# manual-page sanity check inside an image
docker run --rm dotfiles:ubuntu sh -c 'man -w ls && man ls | head'
```

## Gotchas

### Ubuntu: `unminimize` removed in 26.04

- Symptom: `unminimize: not found` during build; the base image has no
  man pages and `/usr/bin/man` is a stub
- Cause: `ubuntu:latest` is Ubuntu 26.04 "resolute", which dropped
  `unminimize` (not even in `ubuntu-minimal`). The image is still
  minimized: dpkg `path-exclude`s in `/etc/dpkg/dpkg.cfg.d/excludes`
  strip man/docs, and the real man binary is diverted to `man.REAL`
- Fix: `Dockerfile.ubuntu` replicates unminimize inline:
  1. `rm -f /etc/dpkg/dpkg.cfg.d/excludes` — stop excluding docs/man
  2. reinstall all installed packages — restore files excluded at
     image build time
  3. `rm -f /usr/bin/man && dpkg-divert --quiet --remove --rename
     /usr/bin/man` — drop the stub, restore the real binary
  - the reinstall list must be an *unquoted* command substitution
    (`$(dpkg --get-selections | awk '{print $1}')`)
  - `setcap: not found` noise from `iputils-ping.postinst` is harmless
- Re-check when: `ubuntu:latest` bumps to the next LTS (the
  minimization layout may change again)

### Arch: amd64-only image

- Symptom: cannot pull or build the image on arm64 hosts
- Cause: `archlinux:latest` has no arm64 manifest
- Fix: build and run with `--platform linux/amd64` (QEMU emulation):

  ```sh
  docker build --platform linux/amd64 -f Dockerfile.archlinux -t dotfiles:archlinux .
  docker run --rm --platform linux/amd64 dotfiles:archlinux ./setup.sh -d
  ```
- Re-check when: archlinux publishes an arm64 image

### Arch: pacman seccomp sandbox fails under emulation

- Symptom: `error restricting syscalls via seccomp: 22!` (EINVAL) and
  `switching to sandbox user 'alpm' failed!`
- Cause: pacman's seccomp sandbox under QEMU x86_64 emulation; the
  archlinux image already sets `DisableSandboxFilesystem` (landlock is
  unavailable in containerd)
- Fix: uncomment `DisableSandboxSyscalls` in `/etc/pacman.conf`:

  ```sh
  sed -i 's/^#DisableSandboxSyscalls/DisableSandboxSyscalls/' /etc/pacman.conf
  ```
- Cosmetic build noise (does not fail the build):
  - `==> ERROR: There is no secret key available to sign with.` during
    the `archlinux-keyring` reinstall (pacman-key is never initialized
    in a container — harmless)
  - `error: command failed to execute correctly` from the Haskell
    module registration post-transaction hook
- Re-check when: pacman's sandbox behavior or the archlinux image
  changes

### Alpine: package names and man pages differ

- Symptom: `apk add git-delta` fails; the vim setup is silently
  skipped; `man ls` reports "No manual entry"
- Cause: Alpine splits packages and documentation differently from
  deb/rpm/pacman, and vimtutor ships in its own package
- Fix / package-name map:
  - `vimtutor` is a separate package (`vim-tutor`); without it,
    `vim/requires` blocks the vim setup. (This is how the `setup.sh`
    `has()`/`cmd` clobbering bug surfaced — it made the "requires X"
    message print a blank; fixed by renaming `has()`'s internal
    variable to `has_cmd`.)
  - man pages live in per-package `-doc` subpackages (`coreutils-doc`,
    `vim-doc`, `git-doc`, `busybox-doc`, ...); `man-db` + `man-pages`
    alone cover only libc/syscall docs
  - `delta` is the package name (not `git-delta`); difftastic is not
    packaged, so the lazygit setup falls back to delta
- musl check (passed): the nvim Python venv (`nvim/requirement.txt`,
  incl. kaleido/cairosvg/pillow) installs cleanly via uv on musl
- Extended tooling is all packaged: tree-sitter-cli, rustup,
  lua-language-server, stylua, shfmt, uv, nodejs, npm, py3-pip, gcc,
  make. mmdc/mermaid-cli is npm-based (node/npm available); only its
  bundled-chromium path is a classic Alpine pain, and it is optional.
- Re-check when: packages are renamed or re-added upstream

### RPM family: only Fedora restores man/docs

- Why: all RPM-family bases (Fedora, CentOS Stream, Rocky, Alma, UBI)
  strip docs via `tsflags=nodocs` in `/etc/dnf/dnf.conf`, so the
  restore mechanism is uniform (`dnf -y reinstall "*"`, which
  `Dockerfile.fedora` already does). What differs is whether the docs
  exist in the RPMs at all:
  - **Fedora** — packages ship full `%doc`/man/info content; docs are
    genuinely restorable
  - **RHEL / UBI / Rocky / Alma** — docs are deliberately left out of
    the packages (RHEL ships docs on access.redhat.com instead), so
    reinstalling recovers little; UBI-minimal is `microdnf`-only,
    making the reinstall-all trick awkward
- Decision: for an RPM-family dev image with working `man`, Fedora is
  the only realistic pick. Ecosystem note: third-party artifacts skew
  toward `.deb`/apt, which is why Ubuntu is the common container
  default; within the RPM family, Fedora + EPEL covers most of the long
  tail.

## Last verified

2026-08-17: Ubuntu 26.04 LTS, Fedora 44, Arch Linux latest, Alpine
latest — all four images build and `./setup.sh -d` passes (idempotent
on re-run; `man` works inside each image).
