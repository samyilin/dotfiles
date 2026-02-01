vim.keymap.set(
  'n',
  '<leader>pu',
  function() vim.pack.update() end,
  { desc = 'Plugin Update' }
)
vim.keymap.set(
  'n',
  '<leader>ps',
  function() vim.pack.update({}, { target = 'lockfile' }) end,
  { desc = 'Plugin update against lockfile' }
)
local function close_floats()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= '' then
      vim.api.nvim_win_close(win, false)
    end
  end
end

vim.keymap.set(
  'n',
  '<Esc>',
  function() close_floats() end,
  { desc = 'Close floats' }
)
