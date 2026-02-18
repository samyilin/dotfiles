Config.later(function() require('mini.trailspace').setup() end)
Config.new_autocmd(
  'BufWritePre', -- Use a pattern to specify which files this applies to
  -- "*" applies to all files. You can also use {"*.py", "*.js"} etc.
  {
    pattern = { '*' },
    callback = function()
      MiniTrailspace.trim()
      MiniTrailspace.trim_last_lines()
    end,
    desc = 'Trim whitespace before save',
  }
)
