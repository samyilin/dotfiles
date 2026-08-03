# AGENTS.md

Personal dotfiles, usable standalone or as a Docker dev container. Pure POSIX `#!/bin/sh` — no bashisms, no external dependencies. Every setup is idempotent: re-running must skip what's already configured.

## Setup architecture

- Entrypoint is `./setup.sh [-h|-d] [program...]` (`-d` = non-interactive/docker mode). No args → runs every top-level folder's setup except `misc*`, `install*`, `config`. README's `./setup`/`./remove` examples are stale; the real files are `setup.sh`/`remove.sh`.
- Each program folder owns a `setup.sh` (and optional `remove.sh`). Metadata files the top-level driver honors:
  - `requires` — every listed command must exist, else abort
  - `requires_any` — at least one listed command must exist
  - `depends` — other setup folders to run first (e.g. `nvim/depends` = `vim`)
- The driver passes the default-mode flag as `$1` to each folder's `setup.sh`: `0` = interactive, `1` = non-interactive. Prompting scripts (`git/`, `ssh/`) gate on `[ "$1" -eq 0 ]` and skip entirely in `-d` mode.
- `common.sh` has the shared helpers. Use `link_config <src> <dest>` (symlink; backs up an existing file to `.bak`; skips if dest is already a symlink), `unlink_config`, and `has <cmd>` for command checks — never `which`/`type`.

## Conventions

- Never overwrite existing user config — move it to `.bak` instead.
- Shell config is *sourced, not linked*: `bash/` and `profile/` append a `. <abs-path>` line to the user's existing `~/.bashrc` / `~/.bash_profile` / `~/.profile`; the stub files are copied only when none exists. Their `remove.sh` strips those lines back out.
- Symlink via `link_config` only for programs with no default user config.
- `config/` = deprecated/legacy configs (untouched by setup). `install/` and `misc/` = optional install scripts, also excluded from setup/remove loops.
- Style: POSIX sh, 2-space indentation (see `.editorconfig` `[*.sh]`; keep shfmt defaults — the files are `shfmt -d`-clean as-is). Keep lines within 72 columns (`vim/.vimrc` sets `textwidth=72`; nvim config has no override). `.shellcheckrc` enables `external-sources=true`, disables SC1091/2328/2327.
- No tests, no CI, no lint script — `shellcheck` + `shfmt -d` are the only verification.
- `git/remove.sh` deliberately does NOT touch `~/.gitconfig`.

## Non-obvious gotchas

- `nvim/setup.sh` creates a venv inside the repo: `uv venv neovim` at `nvim/neovim/` (gitignored — do not commit it; `nvim/remove.sh` deletes it). Paths use the script dir, so the repo need not live at `~/dotfiles`.
- `nvim/` is a DIY config being rewritten off LazyVim (builtin `vim.pack`, lockfile `nvim/nvim-pack-lock.json`). Recent commits are all nvim/formatting work.
- `lazygit/setup.sh` picks the config dir per-OS (`~/Library/Application Support` on Darwin, `~/.config` elsewhere) and symlinks `difft_config.yml` or `delta_config.yml` to `lazygit/config.yml` (gitignored). `requires_any` = difft or delta.
- Docker images (per-distro `Dockerfile.*`) run `./setup.sh -d`; they're how `-d` mode is exercised.
