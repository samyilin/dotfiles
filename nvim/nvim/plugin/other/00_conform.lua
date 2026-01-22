vim.pack.add({ 'https://github.com/stevearc/conform.nvim' }, { load = true })
require('conform').setup({
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { 'stylua' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
  },
  -- Automatically turns on format on save via this setting.
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 50000,
    lsp_format = 'fallback',
  },
})
require('conform').formatters.shfmt = {
  append_args = { '-i', '2' },
  -- The base args are { "-filename", "$FILENAME" } so the final args will be
  -- { "-filename", "$FILENAME", "-i", "2" }
}
