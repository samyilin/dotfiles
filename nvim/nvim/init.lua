-- ---------------------------------------------------------------------------
-- Initialization
-- ---------------------------------------------------------------------------

-- Bootstrap with mini
vim.pack.add(
  { { src = 'https://github.com/nvim-mini/mini.nvim', version = 'main' } },
  { load = true }
)
-- Setup 'mini.deps' for access to `now` and `later` helpers
require('mini.deps').setup()

-- Define global config table for sharing between modules
_G.Config = {}

-- Define lazy helpers
Config.now = MiniDeps.now
Config.later = MiniDeps.later
Config.now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

vim.cmd.colorscheme('minicyan')
-- Helper for creating a new autocommand
Config.custom_group = vim.api.nvim_create_augroup('custom-config', {})
Config.new_autocmd = function(event, opts)
  opts.group = opts.group or Config.custom_group
  vim.api.nvim_create_autocmd(event, opts)
end
-- load mini.basics and mini.misc immediately
require('mini.basics').setup({
  options = {
    extra_ui = true,
  },
})
require('mini.misc').setup()
-- Gets rid of the 'border' around Neovim using OSC111
MiniMisc.setup_termbg_sync()
-- Restore cursor position
MiniMisc.setup_restore_cursor()
