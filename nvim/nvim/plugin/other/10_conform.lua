Config.later(function()
  vim.pack.add({ 'https://github.com/stevearc/conform.nvim' }, { load = true })
  require('conform').setup({
    notify_on_error = true,
    -- Map of filetype to formatters
    formatters_by_ft = {
      lua = { 'stylua' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      ['markdown'] = { 'markdownlint-cli2' },
      ['markdown.mdx'] = { 'markdownlint-cli2' },
    },
    -- Automatically turns on format on save via this setting.
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 50000,
      lsp_format = 'fallback',
    },
    formatters = {
      -- ['markdown-toc'] = {
      --   condition = function(_, ctx)
      --     for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
      --       if line:find('<!%-%- toc %-%->') then return true end
      --     end
      --     return false
      --   end,
      -- },
      ['markdownlint-cli2'] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d) return d.source == 'markdownlint' end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
      ['shfmt'] = {
        append_args = { '-i', '2' },
        -- The base args are { "-filename", "$FILENAME" } so the final args will be
        -- { "-filename", "$FILENAME", "-i", "2" }
      },
    },
  })
end)
