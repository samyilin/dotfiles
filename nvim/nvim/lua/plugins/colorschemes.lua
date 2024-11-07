local colors = vim.fn.getcompletion("", "color")
local i = math.random(os.time()) % #colors
i = i == 0 and #colors or i
return {
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
  {
    "tetzng/random-colorscheme.nvim",
    lazy = false,
    dependencies = {
      { "marko-cerovac/material.nvim" },
      { "rebelot/kanagawa.nvim" },
      { "Mofiqul/dracula.nvim" },
      { "olimorris/onedarkpro.nvim" },
      { "ellisonleao/gruvbox.nvim" },
      { "rose-pine/neovim" },
      { "catppuccin/nvim" },
      { "EdenEast/nightfox.nvim" },
      { "luisiacc/gruvbox-baby" },
      { "folke/tokyonight.nvim" },
    },
    ---@class RandomColorscheme.UserConfig
    opts = {
      set_on_load = false,
    },
    keys = {
      {
        "<leader>cc",
        function()
          require("random-colorscheme").set()
        end,
        desc = "Set Random Colorscheme",
      },
    },
  },
}
