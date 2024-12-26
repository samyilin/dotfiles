return {
  {
    "jbyuki/nabla.nvim",
    event = "VeryLazy",
    ft = { "markdown" },
  },
  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "latex" } } },
  {
    "render-markdown.nvim",
    config = function()
      require("render-markdown").setup({
        latex = { enabled = false },
        win_options = {
          conceallevel = {
            rendered = 2, -- <- especially this, so that both plugins play nice
          },
        },
        on = {
          attach = function()
            require("nabla").enable_virt({ autogen = true })
          end,
        },
      })
    end,
  },
}
