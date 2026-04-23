Config.later(function()
  vim.pack.add(
    { { src = 'https://github.com/stevearc/conform.nvim' } },
    { load = true }
  )
  require('conform').setup({
    notify_on_error = true,
    -- Map of filetype to formatters
    formatters_by_ft = {
      lua = { 'stylua' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      sql = { 'sqlfluff' },
      json = { 'jq' },
      ['markdown'] = { 'markdownlint-cli2' },
      ['markdown.mdx'] = { 'markdownlint-cli2' },
    },
    -- Automatically turns on format on save via this setting.
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 50000, lsp_format = 'fallback' }
    end,
    formatters = {
      -- ['markdown-toc'] = {
      --   condition = function(_, ctx)
      --     for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
      --       if line:find('<!%-%- toc %-%->') then return true end
      --     end
      --     return false
      --   end,
      -- },
      -- ['markdownlint-cli2'] = {
      --   condition = function(_, ctx)
      --     local diag = vim.tbl_filter(
      --       function(d) return d.source == 'markdownlint' end,
      --       vim.diagnostic.get(ctx.buf)
      --     )
      --     return #diag > 0
      --   end,
      -- },
      ['shfmt'] = {
        append_args = { '-i', '2' },
        -- The base args are { "-filename", "$FILENAME" } so the final args will be
        -- { "-filename", "$FILENAME", "-i", "2" }
      },
    },
  })
  vim.api.nvim_create_user_command('FormatToggle', function()
    vim.b.disable_autoformat = not vim.b.disable_autoformat
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    if vim.b.disable_autoformat then
      vim.notify('Autoformat disabled')
    else
      vim.notify('Autoformat enabled')
    end
  end, {
    desc = 'Toggle autoformat on save',
  })
end)
