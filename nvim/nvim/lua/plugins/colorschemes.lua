return {
  -- { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox" } },
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
    priority = 900,
    config = function()
      local available_colorschemes = vim.fn.getcompletion("", "color")
      local runtime_colors = vim.uv.os_uname().sysname == "Windows_NT" and os.getenv("VIMRUNTIME") .. "\\colors\\"
        or os.getenv("VIMRUNTIME") .. "/colors/"
      local color_files = vim.fn.glob(runtime_colors .. "*", false, true)
      local colorschemes = {}
      for _, colorscheme in ipairs(available_colorschemes) do
        colorschemes[colorscheme] = true
      end
      for _, file in ipairs(color_files) do
        colorschemes[string.sub(vim.fs.basename(file), 1, -5)] = nil
      end
      local package_colorschemes = {}
      for color, _ in pairs(colorschemes) do
        table.insert(package_colorschemes, color)
      end
      if table.maxn(package_colorschemes) > 0 then
        table.sort(package_colorschemes)
      else
        package_colorschemes = available_colorschemes
      end

      require("themery").setup({
        themes = package_colorschemes,
      })
    end,
  },
  { "marko-cerovac/material.nvim", lazy = false, priority = 1000 },
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
  { "Mofiqul/dracula.nvim", lazy = false, priority = 1000 },
  { "olimorris/onedarkpro.nvim", lazy = false, priority = 1000 },
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
  { "rose-pine/neovim", lazy = false, priority = 1000 },
  { "catppuccin/nvim", lazy = false, priority = 1000 },
  { "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
}
