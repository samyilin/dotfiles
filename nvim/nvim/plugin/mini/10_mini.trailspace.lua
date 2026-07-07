-- Add autocommand to trail-on-save. This doesn't conflict formatters, it seems.
Config.later(function()
  require('mini.trailspace').setup()
  -- Initialize the tracking variable for trail-on-save
  vim.g.trailspace_on_save = true
  -- Create the trim-on-save autocommand
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = Config.custom_group,
    pattern = { '*' },
    callback = function()
      if vim.g.trailspace_on_save then
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
      end
    end,
    desc = 'Trim whitespace before save',
  })
end)
