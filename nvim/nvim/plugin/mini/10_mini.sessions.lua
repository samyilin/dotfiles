Config.later(function()
  require('mini.sessions').setup()
  vim.api.nvim_create_user_command(
    'Restart',
    function() MiniSessions.restart() end,
    { desc = 'Restart preserving session, using mini.sessions' }
  )
end)
