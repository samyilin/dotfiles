-- ---------------------------------------------------------------------------
-- Initialization
-- ---------------------------------------------------------------------------
-- https://github.com/neovim/neovim/pull/22668
vim.loader.enable()
-- vim.pack autocmd
if vim.fn.executable('rustup') then
  -- so it runs automatically after the plugin is installed.
  vim.api.nvim_create_autocmd('PackChanged', {
    pattern = 'blink.cmp',
    group = vim.api.nvim_create_augroup('blink_update', { clear = true }),
    callback = function(e)
      if e.data.kind == 'update' or e.data.kind == 'install' then
        -- Recommended way to access plugin files inside `PackChanged` event
        -- vim.cmd [[packadd blink.cmp]]
        if not e.data.active then
          vim.cmd.packadd({ args = { e.data.spec.name }, bang = false })
        end
        -- Build the plugin from source
        -- vim.cmd [[BlinkCmp build]]
        require('blink.cmp.fuzzy.build').build()
      end
    end,
  })
end
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})
-- JSONC parser
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').jsonc = {
      install_info = {
        url = 'https://gitlab.com/WhyNotHugo/tree-sitter-jsonc',
        revision = 'HEAD', -- commit hash for revision to check out; HEAD if missing
        -- optional entries:
        branch = 'main', -- only needed if different from default branch
        -- location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
        generate = false, -- only needed if repo does not contain pre-generated `src/parser.c`
        generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
        -- queries = 'queries/neovim', -- also install queries from given directory
      },
      tier = 1,
    }
  end,
  desc = '',
})
-- load vimrc
vim.cmd(
  'source'
    .. vim.fs.joinpath(
      os.getenv('HOME'),
      vim.uv.os_uname().sysname == 'Windows' and '_vimrc' or '.vimrc'
    )
)

-- Add this to your init.lua
vim.filetype.add({
  extension = {
    mdc = 'markdown', -- Treat .mdc files as markdown
  },
})

-- Bootstrap with mini
vim.pack.add(
  { { src = 'https://github.com/nvim-mini/mini.nvim' } },
  { load = true }
)
-- Set colorscheme

-- Add undotree
vim.cmd('packadd nvim.undotree')

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
vim.cmd.colorscheme('miniautumn')
