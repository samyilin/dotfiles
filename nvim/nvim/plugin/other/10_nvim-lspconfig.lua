Config.later(function()
  vim.pack.add({ { src = 'https://github.com/neovim/nvim-lspconfig' } })
  vim.lsp.enable({
    vim.fn.executable('lua-language-server') and 'lua_ls' or nil,
  })
end)
