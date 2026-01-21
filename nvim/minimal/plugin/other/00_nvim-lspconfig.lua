vim.pack.add({ { src = 'https://github.com/neovim/nvim-lspconfig' } })
vim.lsp.enable({ 'lua_ls' })
-- quick auto-triggering completion. Beta.
local f = function(args)
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
  if client:supports_method('textDocument/completion') then
    -- Enable auto-completion
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  end
end
Config.new_autocmd('LspAttach', { pattern = '*', callback = f, desc = 'Automatic Autocompletion' })
