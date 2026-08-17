# Docker image verification notes

Notes from building and verifying the three Dockerfiles
(`Dockerfile.ubuntu`, `Dockerfile.fedora`, `Dockerfile.archlinux`) on an
Apple Silicon Mac (MacBook Air, M5, arm64, macOS 26.5) via Colima +
Docker CLI. Verified 2026-08-17: all three images build and
`./setup.sh -d` completes (also passes the idempotency re-run and `man`
works inside each image).

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

## Rebuild / verify commands

```sh
docker build -f Dockerfile.ubuntu -t dotfiles:ubuntu .
docker build -f Dockerfile.fedora -t dotfiles:fedora .
docker build --platform linux/amd64 -f Dockerfile.archlinux -t dotfiles:archlinux .

# idempotency check (setup must skip everything already configured)
docker run --rm dotfiles:ubuntu ./setup.sh -d
docker run --rm dotfiles:fedora ./setup.sh -d
docker run --rm --platform linux/amd64 dotfiles:archlinux ./setup.sh -d
```

Manual-page sanity check inside an image:

```sh
docker run --rm dotfiles:ubuntu sh -c 'man -w ls && man ls | head'
```
