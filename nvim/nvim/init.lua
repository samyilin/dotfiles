-- ---------------------------------------------------------------------------
-- Initialization
-- ---------------------------------------------------------------------------

-- OSC11 fix to remove padding.
-- Link:https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
-- Solved in Ghostty via Ghostty settings.
-- local kitty_recognization = function()
--   local kitty_terminals =
--     { ['xterm-kitty'] = true, ['xterm-ghostty'] = true, ['wezterm'] = true }
--   return kitty_terminals[os.getenv('TERM')]
-- end
-- if kitty_recognization() then
--   vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
--     callback = function()
--       local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
--       if not normal.bg then return end
--       io.write(string.format('\027]11;#%06x\027\\', normal.bg))
--     end,
--   })
--
--   vim.api.nvim_create_autocmd('UILeave', {
--     callback = function() io.write('\027]111\027\\') end,
--   })
-- end

-- Bootstrap with mini
vim.pack.add(
  { { src = 'https://github.com/nvim-mini/mini.nvim', version = 'main' } },
  { load = true }
)
-- Set colorscheme
vim.cmd.colorscheme('minicyan')

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
