Config.now_if_args(function()
  vim.pack.add({ { src = 'https://github.com/folke/snacks.nvim.git' } })
  require('snacks').setup({
    -- Technically only image needs to be enabed, enable here for sanity check
    lazygit = { enabled = true },
    image = { enabled = true },
  })
  vim.keymap.set(
    'n',
    '<Leader>gg',
    function() Snacks.lazygit() end,
    { desc = 'Lazygit' }
  )
end)
