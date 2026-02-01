Config.later(function()
  require('mini.extra').setup()
  vim.keymap.set(
    'n',
    '<Leader>pe',
    function() MiniExtra.pickers.explorer() end,
    { desc = 'File Explorer' }
  )
  vim.keymap.set(
    'n',
    '<Leader>pc',
    function() MiniExtra.pickers.colorschemes() end,
    { desc = 'Pick Colorscheme' }
  )
  vim.keymap.set(
    'n',
    '<Leader>pk',
    function() MiniExtra.pickers.keymaps() end,
    { desc = 'Pick keymap' }
  )
end)
