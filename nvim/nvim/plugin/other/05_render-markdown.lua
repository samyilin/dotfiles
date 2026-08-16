Config.now_if_args(function()
  vim.pack.add({
    {
      src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    },
  })
  require('render-markdown').setup({
    enabled = true,
    preset = 'obsidian',
    -- Let snacks.image own mermaid; render-markdown conceal breaks
    -- snacks' inline placeholders for those fences.
    code = { disable = { 'mermaid' } },
  }) -- only mandatory if you want to set custom options
end)
