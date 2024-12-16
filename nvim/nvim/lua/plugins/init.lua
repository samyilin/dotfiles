-- Check if pyenv and the neovim venv exists before doing anything else
local venv_path = "~/.pyenv/versions/neovim/bin/python"
if vim.fn.executable("pyenv") == 1 and vim.fn.filereadable(venv_path) then
  vim.g.python3_host_prog = vim.fn.expand(venv_path)
  vim.g.python_host_prog = vim.fn.expand(venv_path)
else
  vim.print("Pyenv is unavailable.")
end
return {
  {
    "linux-cultist/venv-selector.nvim",
    ft = { "python", "quarto" },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = { "python", "quarto" } } },
  },
  { "tpope/vim-sensible" },
  { "dstein64/nvim-scrollview" },
}
