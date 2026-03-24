-- Add autocommand to trim whitespace before save. This doesn't conflict formatters, it seems.
Config.later(function()
  require('mini.trailspace').setup()
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = Config.custom_group,
    pattern = { '*' },
    callback = function()
      MiniTrailspace.trim()
      MiniTrailspace.trim_last_lines()
    end,
    desc = 'Trim whitespace before save',
  })
end)
