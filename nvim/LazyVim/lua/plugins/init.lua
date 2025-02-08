-- Check if pyenv/uv and the neovim venv exists before doing anything else
vim.g.python_host_installed = false
local venv_path = "~/.pyenv/versions/neovim/bin/python"
local venv_path_uv = "~/dotfiles/nvim/neovim/bin/python"
if vim.fn.executable("pyenv") == 1 and vim.fn.filereadable(venv_path) then
  vim.g.python3_host_prog = vim.fn.expand(venv_path)
  vim.g.python_host_prog = vim.fn.expand(venv_path)
  vim.g.python_host_installed = true
elseif vim.fn.executable("uv") == 1 and vim.fn.filereadable(venv_path_uv) then
  vim.g.python3_host_prog = vim.fn.expand(venv_path_uv)
  vim.g.python_host_prog = vim.fn.expand(venv_path_uv)
  vim.g.python_host_installed = true
else
  vim.print("Neither pyenv nor uv is available.")
end
-- Tweaks LazyVim plugin behaviour here.
return {
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
