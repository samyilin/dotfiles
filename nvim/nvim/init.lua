-- ---------------------------------------------------------------------------
-- Initialization
-- ---------------------------------------------------------------------------

-- Bootstrap with mini
vim.pack.add(
  { { src = 'https://github.com/nvim-mini/mini.nvim', version = 'main' } },
  { load = true }
)
-- Set colorscheme
vim.cmd.colorscheme('miniautumn')

-- Define global config table for sharing between modules
_G.Config = {}

-- Define lazy helpers
local misc = require('mini.misc')
Config.now = function(f) misc.safely('now', f) end
Config.later = function(f) misc.safely('later', f) end
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
Config.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end

-- Helper for creating a new autocommand
Config.custom_group = vim.api.nvim_create_augroup('custom-config', {})
Config.new_autocmd = function(event, opts)
  opts.group = Config.custom_group
  vim.api.nvim_create_autocmd(event, opts)
end
-- load mini.basics and mini.misc immediately
--
Config.now(function()
  require('mini.basics').setup({
    options = {
      extra_ui = true,
    },
  })
  require('mini.misc').setup()
  -- Restore cursor position
  MiniMisc.setup_restore_cursor()
end)
