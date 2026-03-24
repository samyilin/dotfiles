-- ---------------------------------------------------------------------------
-- Initialization
-- ---------------------------------------------------------------------------
-- Define global config table for sharing between modules
_G.Config = {}
-- Helper for custom group
Config.custom_group = vim.api.nvim_create_augroup('custom-config', {})

-- add homebrew bin and sbin so git, etc. latest version from brew can
-- be used.
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

-- load vimrc
local vimrc_path = vim.fs.joinpath(
  os.getenv('HOME'),
  vim.uv.os_uname().sysname == 'Windows' and '_vimrc' or '.vimrc'
)
if vim.fn.filereadable(vimrc_path) then vim.cmd('source' .. vimrc_path) end

-- Treat .mdc files as markdown
vim.filetype.add({
  extension = {
    mdc = 'markdown', -- Treat .mdc files as markdown
  },
})
