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

  -- Incremental selection: 0.12+'s builtin an/in covers it, no plugin.
  -- Treesitter-first (vim.treesitter.select()); the LSP selectionRange
  -- path is only a fallback when no parser exists. an/in select parent/
  -- child, ]n/[n move, ]N/[N grow. treesitter-modules.nvim would only add
  -- scope selection (jump to the enclosing @local.scope), which the
  -- nvim-treesitter-textobjects text objects below already cover.
  --
  -- nvim-treesitter-textobjects is loaded but has no setup()/keymaps, so
  -- none of it is currently leveraged. Features, see plugin README and the
  -- BUILTIN_TEXTOBJECTS.md list of built-in captures:
  --
  --   select: syntax-aware text objects from textobjects.scm, a<K> outer /
  --     i<K> inner. E.g. af/if function, ac/ic class, ab/ib block, al/il
  --     loop, ad/id conditional, aC/iC call, ap/ip parameter, a#/i#
  --     comment, a=/i= assignment (daa deletes an assignment, yaC yanks a
  --     call). setup() opts: lookahead, selection_modes (@function.outer
  --     -> 'V' linewise), include_surrounding_whitespace.
  --   move: syntax-aware ]-style jumps. ]m/[m function start, ]M/[M end,
  --     ]]/[[ class, ]d/[d nearest conditional end/start. 'set_jumps'
  --     adds jumplist entries. repeatable_move repeats with ;/,, but ';'
  --     is taken by 3_keymaps.lua (':lua '), and ]m/[m may clash with
  --     builtin ftplugin maps (e.g. python methods) if maps are enabled.
  --   swap: swap node under cursor (e.g. a function argument) with next/
  --     prev via swap_next/swap_previous (e.g. @parameter.inner).
  --   locals.scm: @local.scope and @local.definition.* captures back both
  --     select_textobject("@local.scope", "locals") and the move module,
  --     giving scope text objects that core's an/in still lack.
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
