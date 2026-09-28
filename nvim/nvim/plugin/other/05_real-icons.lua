Config.now_if_args(function()
  vim.pack.add({
    {
      src = 'https://github.com/samyilin/real-icons.nvim.git',
      version = 'dev',
    },
  }, { load = true })
  require('real-icons').setup({
    integrations = {
      -- mini.statusline fileinfo icon (loads in plugin/mini/00_*).
      mini_statusline = true,
      -- oil icon column renderer (loads in 05_oil.lua, just above).
      oil = true,
    },
    size = { trim = true },
  })
end)
