# TODO

Pending items across the repo, with pointers to where they live in the
code so they can be examined in context.

## nvim

- [ ] Revisit `nvim-treesitter-locals` once upstream is ready. The
      locals/definitions module was removed with nvim-treesitter's module
      framework in the 1.0 rewrite; the standalone repo is archived
      ("beyond saving") and its remaining features are blocked on the
      core `vim.pos` API, not on a plugin.
      Source: `nvim/nvim/plugin/other/05_treesitter.lua`

- [ ] Revisit treesitter-based indentation once it is "good enough"
      (nvim-treesitter 1.0 roadmap, issue #4767). The gated autocmd is
      commented out in the same file; `indentexpr()` can't chain to the
      builtin per-filetype indent scripts.
      Source: `nvim/nvim/plugin/other/05_treesitter.lua`

- [ ] (optional) aerial.nvim statusline breadcrumb. Replaces the removed
      nvim-treesitter statusline module via `require('aerial').get_location()`;
      needs a `plugin/other/` registration plus a pcall-guarded content
      function (mini modules load before `plugin/other/`). Full commented
      script in place.
      Source: `nvim/nvim/plugin/mini/00_mini.statusline.lua`

- [ ] Revisit _ui2 experimental API when it stabilizes. The native
      notification override in `nvim/nvim/plugin/other/00_ui2.lua`
      overrides `vim.notify` and works with UI2's message routing.
      Verify all 4 notification classes still work:
      A. `vim.notify` by level (INFO/WARN/ERROR)
      B. `vim.notify` with `title`/`keep` opts
      C. Plugin sources (`FormatToggle`, conform `notify_on_error`)
      D. Native messages (`:echomsg`→cmdline, `:echoerr`/`lua_error`/E518→pager, `:!`→pager)
      Remove the inline TODO in `00_ui2.lua` when _ui2 is marked stable.
      Source: `nvim/nvim/plugin/other/00_ui2.lua`

## setup

- [ ] Build all three Docker images (Dockerfile.ubuntu/fedora/archlinux)
      and confirm `./setup.sh -d` completes.
      Source: `README.md` (Systems Tested section)
