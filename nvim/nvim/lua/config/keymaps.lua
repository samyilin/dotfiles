-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>cv", ":VenvSelectCached <CR>", { desc = "Select cached Venv for LSP", silent = false })
vim.keymap.set("n", "<leader>vc", ":VenvSelect <CR>", { desc = "Select some Venv for LSP", silent = false })
vim.keymap.set("n", "<leader>C", "<cmd>cd %:h <CR>", { desc = "Switch working directory", silent = false })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
