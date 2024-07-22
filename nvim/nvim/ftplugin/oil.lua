vim.keymap.set(
  "n",
  "<leader>C",
  "<CMD>exec printf('cd %s',expand('%')[6:])<CR>",
  { desc = "Set Oil dir as cwd", buffer = 0 }
)
