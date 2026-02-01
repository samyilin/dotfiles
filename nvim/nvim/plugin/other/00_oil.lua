Config.now(function()
  vim.pack.add(
    { { src = 'https://github.com/stevearc/oil.nvim.git' } },
    { load = true }
  )
  require('oil').setup({
    default_file_explorer = true,
    delete_to_traash = true,
    view_options = {
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name, _) return vim.startswith(name, '.') end,
      -- This function defines what will never be shown, even when `show_hidden` is set
      is_always_hidden = function(name, _) return vim.startswith(name, '..') end,
    },
    float = {
      -- Padding around the floating window
      padding = 2,
      -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_width = 0,
      max_height = 0,
      border = 'rounded',
      win_options = {
        winblend = 0,
      },
      -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
      get_win_title = nil,
      -- preview_split: Split direction: "auto", "left", "right", "above", "below".
      preview_split = 'auto',
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      override = function(conf) return conf end,
    },
  })
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  vim.keymap.set(
    'n',
    '`',
    '<CMD>Oil --float<CR>',
    { desc = 'Open parent directory' }
  )
  vim.keymap.set(
    'n',
    '<leader>g1',
    function() vim.cmd(':e ' .. vim.fn.stdpath('config')) end,
    { desc = 'Open Neovim config directory' }
  )
  vim.keymap.set(
    'n',
    '<leader>g2',
    function() vim.cmd(':e ' .. os.getenv('HOME')) end,
    { desc = 'Open Home directory' }
  )
  vim.keymap.set(
    'n',
    '<leader>g3',
    function() vim.cmd(':e ' .. vim.uv.cwd()) end,
    { desc = 'Open CWD' }
  )
end)
