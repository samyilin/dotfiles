return {
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
  {
    "tetzng/random-colorscheme.nvim",
    lazy = true,
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
        "<leader>rc",
        function()
          require("random-colorscheme").set()
        end,
        desc = "Set Random Colorscheme",
      },
    },
  },
}
