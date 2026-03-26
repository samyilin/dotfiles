Config.later(function()
  vim.pack.add(
    {
      { src = 'https://github.com/zenbones-theme/zenbones.nvim' },
      { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
    },
    { load = true }
  )
  vim.g.zenbones_compat = 1
end)
