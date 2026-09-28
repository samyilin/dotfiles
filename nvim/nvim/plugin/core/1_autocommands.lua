-- resize splits if window got resized
vim.api.nvim_create_autocmd('VimResized', {
  group = Config.custom_group,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})
-- Hide mini.statusline on the initial empty buffer (welcome screen).
-- Empty content alone still leaves a StatusLine-colored strip, so the
-- window highlight is remapped to Normal as well. Managed per window and
-- only touched when this sync set it, so plugin floats keep their own
-- winhl. Re-evaluated when buffers are entered or edited.
vim.api.nvim_create_autocmd(
  { 'VimEnter', 'BufEnter', 'TextChanged', 'TextChangedI' },
  {
    group = Config.custom_group,
    callback = function()
      local pristine = vim.api.nvim_buf_get_name(0) == ''
        and vim.bo.buftype == ''
        and vim.bo.filetype == ''
        and not vim.bo.modified
      if pristine == vim.w._welcome_pristine then return end
      vim.w._welcome_pristine = pristine
      if pristine then
        vim.b.ministatusline_disable = true
        vim.w._welcome_stripped = true
        vim.wo.winhl = 'StatusLine:Normal,StatusLineNC:Normal'
      else
        vim.b.ministatusline_disable = false
        if vim.w._welcome_stripped then
          vim.w._welcome_stripped = false
          vim.wo.winhl = ''
        end
      end
    end,
  }
)
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
