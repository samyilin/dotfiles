Config.later(function() require('mini.trailspace').setup() end)
vim.api.nvim_create_autocmd('BufWritePre', {
  group = Config.custom_group,
  pattern = { '*' },
  callback = function()
    MiniTrailspace.trim()
    MiniTrailspace.trim_last_lines()
  end,
  desc = 'Trim whitespace before save',
})
