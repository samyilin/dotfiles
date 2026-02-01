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
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
  })
end)
