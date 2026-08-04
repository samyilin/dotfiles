Config.now_if_args(function()
  local ensure_languages = {
    'bash',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'rust',
    'sql',
    'toml',
    'yaml',
    'gitignore',
    'gitattributes',
    'gitcommit',
    'git_config',
    'git_rebase',
    'jinja_inline',
    'jinja',
    -- snacks.nvim requirements
    'css',
    'html',
    'javascript',
    'latex',
    -- 'norg',
    'scss',
    'svelte',
    'tsx',
    'typst',
    'vue',
    'ron',
  }
  vim.pack.add({
    {
      src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    },
    {
      src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
      version = 'main',
    },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
  }, { load = true })

  -- Install parsers for the languages above
  require('nvim-treesitter').install(ensure_languages)

  -- Incremental selection is no longer part of nvim-treesitter or
  -- nvim-treesitter-textobjects. If wanted, get it from a plugin instead,
  -- e.g. treesitter-modules.nvim (by the render-markdown.nvim author):
  --   https://github.com/MeanderingProgrammer/treesitter-modules.nvim
  --   require('treesitter-modules').setup({
  --     incremental_selection = {
  --       enable = true,
  --       keymaps = {
  --         init_selection = '<A-o>',
  --         node_incremental = '<A-o>',
  --         scope_incremental = '<A-O>',
  --         node_decremental = '<A-i>',
  --       },
  --     },
  --   })
  -- Or use 0.12+'s builtin LSP-driven an/in (vim.lsp.buf.selection_range),
  -- which needs a server implementing textDocument/selectionRange.
  --
  -- TODO: revisit nvim-treesitter-locals once upstream is ready. The old
  -- locals/definitions module was removed along with the rest of
  -- nvim-treesitter's module framework in the 1.0 rewrite; the standalone
  -- nvim-treesitter-locals repo is archived ("beyond saving"), and its
  -- remaining features (e.g. locals highlighting) are blocked on the
  -- upstream `vim.pos` core API, not on a plugin.
  local filetypes = vim
    .iter(ensure_languages)
    :map(vim.treesitter.language.get_filetypes)
    :flatten()
    :totable()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    group = Config.custom_group,
    callback = function() vim.treesitter.start() end,
  })

  -- TODO: revisit treesitter-based indentation once it is good enough.
  -- nvim-treesitter.indentexpr() can't chain to the builtin per-filetype
  -- indent scripts (indentexpr is a single buffer-local option), so it must
  -- be gated to languages that actually ship an `indents` query. Without a
  -- parser it returns -1 (autoindent fallback), but with a parser lacking an
  -- `indents` query it returns 0 (column 0), worse than the builtin indent.
  -- The maintainers still describe treesitter indents as "not quite ready
  -- for primetime" (see nvim-treesitter 1.0 roadmap, issue #4767).
  -- vim.api.nvim_create_autocmd('FileType', {
  --   group = Config.custom_group,
  --   callback = function()
  --     local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
  --     if lang and vim.treesitter.query.get(lang, 'indents') then
  --       vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  --     end
  --   end,
  -- })

  -- Display context when current block is off-screen
  require('treesitter-context').setup()
end)
