Config.later(function()
  -- Pinning V1.X until blink 2.0 is stable
  vim.pack.add({
    {
      src = 'https://github.com/saghen/blink.cmp',
      version = vim.version.range('1.X'),
    },
  })
  require('blink.cmp').setup({
    fuzzy = { implementation = 'prefer_rust' },
    appearance = {
      use_nvim_cmp_as_default = true,
    },
    completion = {
      documentation = {
        auto_show = true,
      },
    },
    sources = {
      -- Static list of providers to enable, or a function to dynamically enable/disable providers based on the context
      default = { 'lazydev', 'lsp', 'path', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
  })
end)
