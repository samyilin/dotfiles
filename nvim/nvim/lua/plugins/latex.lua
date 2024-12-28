return {
  {
    "jbyuki/nabla.nvim",
    lazy = true,
    init = function()
      vim.api.nvim_create_user_command("Nabla", 'lua require("nabla").enable_virt({autogen = true})', {})
      vim.api.nvim_create_user_command("NablaPopup", 'lua require("nabla").popup()', {})
    end,
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
            vim.api.nvim_create_user_command("Nabla", 'lua require("nabla").enable_virt({autogen = true})', {})
            vim.api.nvim_create_user_command("NablaPopup", 'lua require("nabla").popup()', {})
          end,
        },
      })
    end,
  },
}
