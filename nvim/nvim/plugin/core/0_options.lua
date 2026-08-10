-- Most of the options are set in .vimrc
vim.o.confirm = true
-- clipboard is set in .vimrc (SSH-aware)
-- Diagnostic with virtual text.
vim.diagnostic.config({ virtual_text = true })
-- fold options
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldmethod = 'expr'
vim.o.foldlevel = 99
-- spell
vim.o.spelllang = 'en'
vim.o.spellfile =
  vim.fs.joinpath(vim.fn.stdpath('config'), 'spell', 'en.utf-8.add')
