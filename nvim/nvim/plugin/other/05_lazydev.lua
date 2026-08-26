Config.on_filetype('lua', function()
  vim.pack.add({ { src = 'https://github.com/folke/lazydev.nvim' } })
  require('lazydev').setup({})
end)
