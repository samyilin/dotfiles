vim.pack.add({ { src = 'https://github.com/folke/snacks.nvim.git' } })
require('snacks').setup({
  opts = { lazygit = { enabled = true }, image = { enabled = true }, bufdelete = { enabled = true } },
})
vim.keymap.set('n', '<Leader>gg', function() Snacks.lazygit() end)
vim.keymap.set('n', '<Leader>bd', function() Snacks.bufdelete() end)
