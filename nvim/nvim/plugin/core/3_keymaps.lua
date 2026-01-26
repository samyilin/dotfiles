vim.keymap.set('n', '<leader>pu', function() vim.pack.update() end)
vim.keymap.set('n', '<leader>ps', function() vim.pack.update({}, { target = 'lockfile' }) end)
-- keymap to jump to neovim config, home dir and cwd.
vim.keymap.set({ 'i', 'n', 's' }, '<esc>', function()
  vim.cmd('noh')
  return '<esc>'
end, { expr = true })
