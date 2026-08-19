# Introduction

## Custom pagers?

2 example pager configs are provided: `difft_config.yml`
(difftastic) and `delta_config.yml` (delta). `setup.sh` symlinks the
chosen one to `config.yml` (gitignored), so only one pager is active
at a time. For SQL files, neither do a very good job, so commented
both for now because DBT work is the main git work for me at the
moment.

## Git pull origin master?

Steps needed:

- Checkout the local branch
- Get cursor on main(master) branch
- Hit f to fast-forward, then hit M to merge
