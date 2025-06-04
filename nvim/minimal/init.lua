_G.Config = {}

require("options")
require("keymaps")
require("autocmds")
-- If no git is found, this won't be executed
if vim.fn.executable("git") ~= 1 then
  vim.notify("This config minimally requires git to function.", vim.log.levels.INFO)
  return
end
require("config.lazy")
vim.cmd("colorscheme tokyonight")
