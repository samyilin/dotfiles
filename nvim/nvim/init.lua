-- ---------------------------------------------------------------------------
-- Initialization
-- ---------------------------------------------------------------------------
-- Define global config table for sharing between modules
_G.Config = {}
-- Helper for custom group
Config.custom_group = vim.api.nvim_create_augroup('custom-config', {})
-- https://github.com/neovim/neovim/pull/22668
vim.loader.enable()

-- set leader and localleader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- add homebrew bin and sbin
if vim.fn.executable('brew') then
  -- Get the current PATH value
  local current_path = vim.env.PATH

  -- Define the directory you want to prepend
  local homebrew_bin = '/opt/homebrew/bin'
  local homebrew_sbin = '/opt/homebrew/sbin'

  -- Define the path separator based on the operating system
  local separator = ':'

  -- Prepend the new directory to the PATH environment variable
  vim.env.PATH = homebrew_bin
    .. separator
    .. homebrew_sbin
    .. separator
    .. current_path
end

-- vim.pack autocmd
vim.api.nvim_create_autocmd('PackChanged', {
  group = Config.custom_group,
  callback = function(ev)
    local name, kind, active = ev.data.spec.name, ev.data.kind, ev.data.active
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
    if vim.fn.executable('rustup') then
      if name == 'blink.cmp' and kind == 'update' or kind == 'install' then
        -- Recommended way to access plugin files inside `PackChanged` event
        -- vim.cmd [[packadd blink.cmp]]
        if not active then
          vim.cmd.packadd({ args = { name }, bang = false })
        end
        -- Build the plugin from source
        -- vim.cmd [[BlinkCmp build]]
        require('blink.cmp.fuzzy.build').build()
      end
    end
  end,
})
-- load vimrc
vim.cmd(
  'source'
    .. vim.fs.joinpath(
      os.getenv('HOME'),
      vim.uv.os_uname().sysname == 'Windows' and '_vimrc' or '.vimrc'
    )
)

-- Treat .mdc files as markdown
vim.filetype.add({
  extension = {
    mdc = 'markdown', -- Treat .mdc files as markdown
  },
})
