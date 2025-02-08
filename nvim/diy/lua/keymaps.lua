-- For some reason, maybe implicit load order, keymaps placed here won't be
-- recognized by mini.clue.

vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

vim.keymap.set({ "n" }, "<leader>cb", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { expr = true, desc = "toggle background" })
vim.api.nvim_create_user_command("RandomColor", function()
  local colorschemes = vim.fn.getcompletion("", "color")
  local selected_colorscheme = colorschemes[math.random(#colorschemes)]
  vim.cmd("colorscheme " .. selected_colorscheme)
  vim.notify(selected_colorscheme, vim.log.levels.INFO)
end, {})
vim.api.nvim_create_user_command("BgSwitch", function()
  local original_bg = vim.api.nvim_get_hl(0, { name = "Normal" })["bg"]
  if vim.o.background == "dark" then
    vim.o.background = "light"
    if original_bg == vim.api.nvim_get_hl(0, { name = "Normal" })["bg"] then
      vim.o.background = "dark"
    end
  else
    vim.o.background = "dark"
    if original_bg == vim.api.nvim_get_hl(0, { name = "Normal" })["bg"] then
      vim.o.background = "light"
    end
  end
  vim.notify(vim.o.background, vim.log.levels.INFO)
end, {})
