-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.fn.filereadable("~/.vimrc") then
  vim.cmd("source ~/.vimrc")
end
require("config.lazy")
