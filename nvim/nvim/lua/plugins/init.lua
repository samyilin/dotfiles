-- Check if pyenv and the neovim venv exists before doing anything else
local venv_path = "~/.pyenv/versions/neovim/bin/python"
if vim.fn.executable("pyenv") == 1 and vim.fn.filereadable(venv_path) then
  os.execute('export PYENV_ROOT="$(pyenv root -)"')
  vim.g.python3_host_prog = vim.fn.expand(venv_path)
  vim.g.python_host_prog = vim.fn.expand(venv_path)
else
  vim.print("Pyenv is unavailable or neovim venv isn't available")
end
return {
  -- disable trouble
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "marko-cerovac/material.nvim", enabled = true },
  { "rebelot/kanagawa.nvim", enabled = true },
  { "Mofiqul/dracula.nvim", enabled = true },
  { "olimorris/onedarkpro.nvim", enabled = true },
  { "ellisonleao/gruvbox.nvim", enabled = true },
  { "rose-pine/neovim", enabled = true },
  { "catppuccin/nvim", enabled = true },
  { "EdenEast/nightfox.nvim", enabled = true },
  { "luisiacc/gruvbox-baby", enabled = true },
  {
    "linux-cultist/venv-selector.nvim",
  },
}
