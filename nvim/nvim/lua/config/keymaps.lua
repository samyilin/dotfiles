-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>C", "<cmd>cd %:h <CR>", { desc = "Switch Working Directory", silent = false })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Parent Directory" })
