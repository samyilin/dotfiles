Config.later(function()
  require('mini.pick').setup()
  vim.keymap.set(
    'n',
    '<Leader>pf',
    function() MiniPick.builtin.files() end,
    { desc = 'Pick Files' }
  )
  vim.keymap.set(
    'n',
    '<Leader>pb',
    function() MiniPick.builtin.buffers() end,
    { desc = 'Pick buffers' }
  )
  vim.keymap.set(
    'n',
    '<Leader>ph',
    function() MiniPick.builtin.help() end,
    { desc = 'Pick help' }
  )
  vim.keymap.set(
    'n',
    '<Leader>pg',
    function() MiniPick.builtin.grep_live() end,
    { desc = 'Pick grep' }
  )
  -- vim.keymap.set('n', '<Leader>pc', function() MiniPick.builtin.cli() end)
  vim.keymap.set(
    'n',
    '<Leader>pr',
    function() MiniPick.builtin.resume() end,
    { desc = 'Pick resume' }
  )
end)
