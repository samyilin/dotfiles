Config.now_if_args(function()
  vim.pack.add({ 'https://github.com/folke/lazydev.nvim' }, { load = true })
  require('lazydev').setup({})
end)
