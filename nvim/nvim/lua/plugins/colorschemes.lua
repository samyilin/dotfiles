return {
  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox" } },
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
      { "folke/tokyonight.nvim" },
      { "loctvl842/monokai-pro.nvim" },
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
