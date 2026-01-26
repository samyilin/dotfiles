-- ---------------------------------------------------------------------------
-- Initialization
-- ---------------------------------------------------------------------------

-- Set leader keys before any keymaps are defined
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Bootstrap with mini
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })
-- Setup 'mini.deps' for access to `now` and `later` helpers
require('mini.deps').setup()

-- Define global config table for sharing between modules
_G.Config = {}

-- Define lazy helpers
Config.now = MiniDeps.now
Config.later = MiniDeps.later
Config.now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

vim.cmd.colorscheme('minicyan')
