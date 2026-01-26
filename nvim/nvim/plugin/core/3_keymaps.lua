vim.keymap.set('n', '<leader>pu', function() vim.pack.update() end)
vim.keymap.set('n', '<leader>ps', function() vim.pack.update({}, { target = 'lockfile' }) end)
