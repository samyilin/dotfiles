Config.later(function()
  require('mini.bufremove').setup()
  vim.keymap.set(
    'n',
    '<Leader>bd',
    function() MiniBufremove.delete() end,
    { desc = 'Buffer Delete' }
  )
end)
