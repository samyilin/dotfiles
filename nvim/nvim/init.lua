--Loads vimrc for compatibility and comfort. Learned from rwxrob
if vim.uv.os_uname().sysname == "Windows_NT" and vim.fn.filereadable("~\\_vimrc") then
  vim.cmd.source("~\\_vimrc")
elseif vim.fn.filereadable("~/.vimrc") then
  vim.cmd.source("~/.vimrc")
end
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
