Config.now_if_args(function()
  vim.pack.add({ { src = 'https://github.com/folke/lazydev.nvim' } })
  require('lazydev').setup({})
end)
