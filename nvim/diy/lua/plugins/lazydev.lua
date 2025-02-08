require("lazydev").setup({
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
  runtime = vim.env.VIMRUNTIME,
  enabled = true,
  debug = false,
  integrations = {
    cmp = true,
    coq = false,
  },
})
