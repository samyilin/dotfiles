-- ---------------------------------------------------------------------------
-- Initialization
-- ---------------------------------------------------------------------------

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

-- Helper for creating a new autocommand
local custom_group = vim.api.nvim_create_augroup('custom-config', {})
Config.new_autocmd = function(event, opts)
  opts.group = opts.group or custom_group
  vim.api.nvim_create_autocmd(event, opts)
end
-- Hook for vim.pack.update
Config.on_packchanged = function(plugin_name, kinds, callback, desc)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
    if not ev.data.active then vim.cmd.packadd(plugin_name) end
    callback()
  end
  Config.new_autocmd('PackChanged', { pattern = '*', callback = f, desc = desc })
end
vim.cmd.colorscheme('minicyan')
