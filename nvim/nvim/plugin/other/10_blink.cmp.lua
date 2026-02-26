Config.later(function()
  if vim.fn.executable('rustup') then
    -- so it runs automatically after the plugin is installed.
    vim.api.nvim_create_autocmd('PackChanged', {
      pattern = 'blink.cmp',
      group = vim.api.nvim_create_augroup('blink_update', { clear = true }),
      callback = function(e)
        if e.data.kind == 'update' or e.data.kind == 'install' then
          -- Recommended way to access plugin files inside `PackChanged` event
          -- vim.cmd [[packadd blink.cmp]]
          if not e.data.active then
            vim.cmd.packadd({ args = { e.data.spec.name }, bang = false })
          end
          -- Build the plugin from source
          -- vim.cmd [[BlinkCmp build]]
          require('blink.cmp.fuzzy.build').build()
        end
      end,
    })
  end
  vim.pack.add({ { src = 'https://github.com/saghen/blink.cmp' } })
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
