-- resize splits if window got resized
vim.api.nvim_create_autocmd('VimResized', {
  group = Config.custom_group,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})
-- vim.pack autocmd for treesitter and blink.cmp
vim.api.nvim_create_autocmd('PackChanged', {
  group = Config.custom_group,
  callback = function(ev)
    local name, kind, active = ev.data.spec.name, ev.data.kind, ev.data.active
    if name == 'nvim-treesitter' and kind == 'update' then
      if not active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
    if vim.fn.executable('rustup') then
      if name == 'blink.cmp' and (kind == 'update' or kind == 'install') then
        -- Recommended way to access plugin files inside `PackChanged` event
        -- vim.cmd [[packadd blink.cmp]]
        if not active then
          vim.cmd.packadd({ args = { name }, bang = false })
        end
        -- Build the plugin from source
        -- vim.cmd [[BlinkCmp build]]
        require('blink.cmp.fuzzy.build').build()
      end
    end
  end,
})
