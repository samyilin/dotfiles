-- Check if pyenv and the neovim venv exists before doing anything else
local venv_path = "~/.pyenv/versions/neovim/bin/python"
if vim.fn.executable("pyenv") == 1 and vim.fn.filereadable(venv_path) then
  vim.g.python3_host_prog = vim.fn.expand(venv_path)
  vim.g.python_host_prog = vim.fn.expand(venv_path)
else
  vim.print("Pyenv is unavailable.")
end
-- Tweaks LazyVim plugin behaviour here.
return {
  {
    "linux-cultist/venv-selector.nvim",
    ft = { "python", "quarto" },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = { "python", "quarto" } } },
  },
  {
    "folke/snacks.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.dashboard.preset.keys, 3, {
        action = ":Mason",
        desc = "Mason",
        icon = "󰣪 ",
        key = "m",
      })
      table.insert(opts.dashboard.preset.keys, 4, {
        action = "<leader>gg",
        desc = "Lazygit",
        icon = " ",
        key = "G",
      })
      table.insert(opts.dashboard.preset.keys, 4, {
        action = ":FzfLua colorschemes",
        desc = "colorschemes",
        icon = "󰋴 ",
        key = "t",
      })
    end,
  },
}
