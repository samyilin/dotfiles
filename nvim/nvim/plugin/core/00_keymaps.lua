vim.keymap.set('n', '<leader>pu', function() vim.pack.update() end)
vim.keymap.set('n', '<leader>ps', function() vim.pack.update({}, { target = 'lockfile' }) end)
-- keymap to jump to neovim config, home dir and cwd.
vim.keymap.set('n', '<leader>g1', function() vim.cmd(':e ' .. vim.fn.stdpath('config')) end)
vim.keymap.set('n', '<leader>g2', function() vim.cmd(':e ' .. os.getenv('HOME')) end)
vim.keymap.set('n', '<leader>g3', function() vim.cmd(':e ' .. vim.uv.cwd()) end)
vim.keymap.set({ 'i', 'n', 's' }, '<esc>', function()
  vim.cmd('noh')
  return '<esc>'
end, { expr = true })
