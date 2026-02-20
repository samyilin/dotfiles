Config.later(function()
  vim.pack.add({ { src = 'https://github.com/saghen/blink.cmp' } })
  require('blink.cmp').setup({
    fuzzy = {
      implementation = 'lua',
    },
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
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
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
