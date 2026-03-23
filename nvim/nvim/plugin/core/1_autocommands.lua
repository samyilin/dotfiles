-- resize splits if window got resized
vim.api.nvim_create_autocmd('VimResized', {
  group = Config.custom_group,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})
