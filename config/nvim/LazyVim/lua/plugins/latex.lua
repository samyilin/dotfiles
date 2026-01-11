return {
  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "latex" } } },
  {
    "render-markdown.nvim",
    config = function()
      require("render-markdown").setup({
        latex = { enabled = false },
        win_options = {
          conceallevel = {
            rendered = 2,
          },
        },
      })
    end,
  },
}
