-- ---------------------------------------------------------------------------
-- Initialization
-- ---------------------------------------------------------------------------

-- OSC11 fix to remove padding.
-- Link:https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then return end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})

vim.api.nvim_create_autocmd('UILeave', {
  callback = function() io.write('\027]111\027\\') end,
})
-- Bootstrap with mini
vim.pack.add(
  { { src = 'https://github.com/nvim-mini/mini.nvim', version = 'main' } },
  { load = true }
)
-- Setup 'mini.deps' for access to `now` and `later` helpers
require('mini.deps').setup()

require('mini.misc').setup()
-- Restore cursor position
MiniMisc.setup_restore_cursor()

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
