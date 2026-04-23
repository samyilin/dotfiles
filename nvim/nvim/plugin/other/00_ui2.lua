Config.now(function()
  -- Experimental UI2: floating cmdline and messages
  -- Works with ui2. Hides cmd.
  vim.o.cmdheight = 0
  -- Enables different targets
  -- see :h api-ui-events
  require('vim._core.ui2').enable({
    enable = true,
    msg = {
      targets = {
        [''] = 'msg',
        empty = 'cmd',
        bufwrite = 'msg',
        confirm = 'cmd',
        emsg = 'pager',
        echo = 'msg',
        echomsg = 'msg',
        echoerr = 'pager',
        completion = 'cmd',
        list_cmd = 'pager',
        lua_error = 'pager',
        lua_print = 'msg',
        progress = 'msg',
        rpc_error = 'pager',
        quickfix = 'msg',
        search_cmd = 'cmd',
        search_count = 'cmd',
        shell_cmd = 'pager',
        shell_err = 'pager',
        shell_out = 'pager',
        shell_ret = 'msg',
        undo = 'msg',
        verbose = 'pager',
        wildlist = 'cmd',
        wmsg = 'msg',
        typed_cmd = 'cmd',
      },
      cmd = {
        height = 0.5,
      },
      dialog = {
        height = 0.5,
      },
      msg = {
        height = 0.3,
        timeout = 5000,
      },
      pager = {
        height = 0.5,
      },
    },
  })
  -- styling to window
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'msg',
    callback = function()
      local ui2 = require('vim._core.ui2')
      local win = ui2.wins and ui2.wins.msg
      if win and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_set_option_value(
          'winhighlight',
          'Normal:NormalFloat,FloatBorder:FloatBorder',
          { scope = 'local', win = win }
        )
      end
    end,
  })
  -- position UI to topright corner
  local ui2 = require('vim._core.ui2')
  local msgs = require('vim._core.ui2.messages')
  local orig_set_pos = msgs.set_pos
  msgs.set_pos = function(tgt)
    orig_set_pos(tgt)
    if
      (tgt == 'msg' or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg)
    then
      pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
        relative = 'editor',
        anchor = 'NE',
        row = 1,
        col = vim.o.columns - 1,
        border = 'rounded',
      })
    end
  end
  -- vim.api.nvim_create_autocmd('LspProgress', {
  --   callback = function(ev)
  --     local client = vim.lsp.get_client_by_id(ev.data.client_id)
  --     local value = ev.data.params.value
  --     local msg = ('[%s] %s %s'):format(
  --       client.name,
  --       value.kind == 'end' and '✓' or '',
  --       value.title or ''
  --     )
  --     vim.notify(msg)
  --   end,
  -- })
  -- LSP Progress integration
  -- vim.ai.nvim_echo is associated with the progress kind.
  vim.api.nvim_create_autocmd('LspProgress', {
    callback = function(ev)
      local value = ev.data.params.value
      vim.api.nvim_echo({ { value.message or 'done' } }, false, {
        id = 'lsp.' .. ev.data.client_id,
        kind = 'progress',
        source = 'vim.lsp',
        title = value.title,
        status = value.kind ~= 'end' and 'running' or 'success',
        percent = value.percentage,
      })
    end,
  })
end)
