return {
  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox" } },
  {
    -- "tetzng/random-colorscheme.nvim",
    -- lazy = true,
    -- keys = {
    --   {
    --     "<leader>rc",
    --     function()
    --       require("random-colorscheme").set()
    --     end,
    --     desc = "Set Random Colorscheme",
    --   },
    -- },
    ------@class RandomColorscheme.UserConfig
    ---opts = {
    ---  set_on_load = false,
    ---},
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      local available_colorschemes = vim.fn.getcompletion("", "color")
      local colorschemes = {}
      for _, colorscheme in ipairs(available_colorschemes) do
        table.insert(colorschemes, colorscheme)
      end

      require("themery").setup({
        themes = colorschemes,
      })
    end,
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
  },
}
