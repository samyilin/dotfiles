if vim.uv.os_uname().sysname ~= "Windows_NT" then
  vim.keymap.set(
    "n",
    "<leader>C",
    "<CMD>exec printf('cd %s',expand('%')[6:])<CR>",
    { desc = "Set Oil dir as cwd", buffer = 0 }
  )
else
  vim.keymap.set(
    "n",
    "<leader>C",
    "<CMD>exec printf('cd %s',expand('%')[7:].gsub('/','\\')<CR>",
    { desc = "Set Oil dir as cwd", buffer = 0 }
  )
end
