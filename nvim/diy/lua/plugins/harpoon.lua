require("harpoon").setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  },
  settings = {
    save_on_toggle = true,
  },
})
vim.keymap.set("n", "<Leader>ha", function()
  require("harpoon"):list():add()
end, { desc = "Harpoon: harpoon File" })
vim.keymap.set("n", "<Leader>hl", function()
  local harpoon = require("harpoon")
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: select file" })
for i = 1, 9 do
  vim.keymap.set("n", "<Leader>h" .. i, function()
    require("harpoon"):list():select(i)
  end, { desc = "Harpoon to File " .. i })
end
