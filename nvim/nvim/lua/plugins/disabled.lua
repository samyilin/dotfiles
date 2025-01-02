return {
  { "windwp/nvim-ts-autotag", enabled = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignores = true,
          },
        },
        window = {
          mappings = {
            ["-"] = "navigate_up",
          },
        },
      })
    end,
  },
}
