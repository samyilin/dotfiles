Config.later(function()
  require('mini.diff').setup()
  vim.keymap.set(
    'n',
    '<Leader>gh',
    function() MiniDiff.toggle_overlay(0) end,
    { desc = 'git hunks' }
  )
end)
