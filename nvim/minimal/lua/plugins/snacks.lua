return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      dashboard = { enabled = true },
      bufdelete = { enabled = true },
      picker = { enabled = true },
      lazyvim = { enabled = true },
    },
    keys = {
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      { "<leader>db", function() Snacks.dashboard() end, desc = "Dashboard" },
      { "<leader>sg", function() Snacks.picker("grep") end, desc = "Grep" }
    }
}

}


