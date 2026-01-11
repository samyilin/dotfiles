vim.pack.add({ 'https://github.com/stevearc/conform.nvim' }, { load = true })
require('conform').setup({
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { 'stylua' },
  },
  -- Automatically turns on format on save via this setting.
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
})
