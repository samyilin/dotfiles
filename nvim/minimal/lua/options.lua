-- Show invisible characters
vim.opt.list = true
-- Tabs are automatically expanded to tabs
vim.opt.expandtab = true
-- Setting for which-key to work better.
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300
-- Wrapping disabled by default.
vim.opt.wrap = false
-- Break line by words, separated by valid characters.
vim.opt.linebreak = true
-- Enable mouse
vim.opt.mouse = "a"
vim.opt.laststatus = 3
vim.opt.spelllang = vim.opt.spelllang + "cjk"
vim.opt.columns = 9999
