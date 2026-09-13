Config.later(function()
  require('mini.bufremove').setup()
  vim.keymap.set(
    'n',
    '<Leader>bd',
    function() MiniBufremove.delete() end,
    { desc = 'Buffer Delete' }
  )
  vim.keymap.set('n', '<Leader>bo', function()
    local cur = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= cur and vim.fn.buflisted(buf) == 1 then
        MiniBufremove.delete(buf)
      end
    end
  end, { desc = 'Buffer Delete Others' })
end)
