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
vim.keymap.set(
  'n',
  '<leader>cp',
  ':let @+ = expand("%:p")<CR>',
  { silent = true, desc = 'Copy absolute path to clipboard' }
)
