vim.keymap.set('n', '<leader>l', function() vim.pack.update() end)
-- keymap to jump to neovim config, home dir and cwd.
vim.keymap.set('n', '<leader>g1', function() vim.cmd(':e ' .. vim.fn.stdpath('config')) end)
vim.keymap.set('n', '<leader>g2', function() vim.cmd(':e ' .. os.getenv('HOME')) end)
vim.keymap.set('n', '<leader>g3', function() vim.cmd(':e ' .. vim.uv.cwd()) end)
