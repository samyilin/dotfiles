-- set leader and localleader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- vim.pack update
vim.keymap.set(
  'n',
  '<leader>pu',
  function() vim.pack.update() end,
  { desc = 'Plugin Update' }
)
-- vim.pack sync
vim.keymap.set(
  'n',
  '<leader>ps',
  function() vim.pack.update({}, { target = 'lockfile' }) end,
  { desc = 'Plugin update against lockfile' }
)
-- Quick :lua
vim.keymap.set('n', ';', ':lua ', { desc = 'lua command line' })
