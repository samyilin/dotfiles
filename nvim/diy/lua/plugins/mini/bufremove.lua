require("mini.bufremove").setup()
vim.keymap.set("n", "<leader>bd", function()
  MiniBufremove.delete(0)
end, { desc = "delete buffer" })
