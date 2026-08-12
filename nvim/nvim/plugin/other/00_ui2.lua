Config.now(function()
  -- TODO: Check _ui2 behavior after Neovim release (experimental API).
  -- Verify all 4 notification classes (A: vim.notify, B: opts, C: plugins, D: native)
  -- still work correctly. Mark this TODO complete when _ui2 is stable/no longer experimental.
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

-- Native floating notifications as a minimal mini.notify replacement.
-- Overrides only vim.notify, so UI2 message routing (typed_cmd, error kinds)
-- is left untouched. Latest notification replaces the previous one.
Config.now(function()
  local ns = vim.api.nvim_create_namespace('nvim.ownnotify')
  local buf, win, timer = -1, -1, nil
  local keep_active = false
  local esc_ns = vim.api.nvim_create_namespace('nvim.ownnotify.esc')

  local function get_buf()
    if not vim.api.nvim_buf_is_valid(buf) then
      buf = vim.api.nvim_create_buf(false, true)
      vim.bo[buf].bufhidden = 'hide'
      vim.bo[buf].filetype = 'ownnotify'
    end
    return buf
  end

  local function hide()
    if timer then timer:stop() end
    if keep_active then
      keep_active = false
      pcall(vim.on_key, nil, esc_ns)
    end
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_set_config(win, { hide = true })
    end
  end

  local function settle()
    local b = get_buf()
    local lines = vim.api.nvim_buf_get_lines(b, 0, -1, false)
    while #lines > 0 and lines[#lines] == '' do
      vim.api.nvim_buf_set_lines(b, #lines - 1, #lines, false, {})
      lines = vim.api.nvim_buf_get_lines(b, 0, -1, false)
    end
    if #lines == 0 then
      hide()
      return
    end
    if not vim.api.nvim_win_is_valid(win) then
      win = vim.api.nvim_open_win(b, false, {
        relative = 'editor', anchor = 'NE', row = 1,
        col = vim.o.columns - 1, width = 40, height = 1,
        style = 'minimal', border = 'rounded', zindex = 50,
      })
      vim.api.nvim_set_option_value('wrap', true, { scope = 'local', win = win })
      vim.api.nvim_set_option_value(
        'winhighlight', 'Normal:NormalFloat,FloatBorder:FloatBorder',
        { scope = 'local', win = win }
      )
      vim.keymap.set('n', 'q', hide, { buffer = b })
      vim.keymap.set('n', '<Esc>', hide, { buffer = b })
      -- Click-to-close
      vim.keymap.set('n', '<LeftRelease>', hide, { buffer = b })
    end
    local w, h = 40, #lines
    for _, l in ipairs(lines) do w = math.max(w, vim.api.nvim_strwidth(l) + 2) end
    h = math.min(h, math.max(1, math.floor(vim.o.lines * 0.3)))
    w = math.min(w, math.max(20, vim.o.columns - 2))
    vim.api.nvim_win_set_config(win, {
      hide = false, relative = 'editor', anchor = 'NE', row = 1,
      col = vim.o.columns - 1, width = w, height = h,
      style = 'minimal', border = 'rounded', zindex = 50,
    })
    if #lines > h then vim.api.nvim_win_set_cursor(win, { #lines, 0 }) end
  end

  local function schedule_hide(ms)
    if timer then timer:stop() end
    timer = vim.uv.new_timer()
    timer:start(ms, 0, vim.schedule_wrap(function()
      timer:close()
      timer = nil
      hide()
    end))
  end

  vim.notify = function(msg, level, opts)
    opts = opts or {}
    level = level or vim.log.levels.INFO
    if vim.in_fast_event() then
      vim.schedule(function() vim.notify(msg, level, opts) end)
      return
    end
    local ok, err = pcall(function()
      local text = type(msg) == 'string' and msg or vim.inspect(msg)
      local hl = level >= vim.log.levels.ERROR and 'ErrorMsg'
        or level >= vim.log.levels.WARN and 'WarningMsg'
        or nil
      local b = get_buf()
      vim.api.nvim_buf_set_lines(b, 0, -1, false, {})
      vim.api.nvim_buf_clear_namespace(b, ns, 0, -1)
      local entry = {}
      if opts.title and opts.title ~= '' then
        entry[#entry + 1] = { opts.title, 'Title' }
      end
      for _, l in ipairs(vim.split(text, '\n')) do
        entry[#entry + 1] = { l, hl }
      end
      for i, chunk in ipairs(entry) do
        vim.api.nvim_buf_set_lines(b, i - 1, i - 1, false, { chunk[1] })
        if chunk[2] then
          vim.api.nvim_buf_set_extmark(b, ns, i - 1, 0, { hl_group = chunk[2] })
        end
      end
      settle()
      if opts.keep then
        if timer then timer:stop() end
        keep_active = true
        -- Global Esc to dismiss keep window
        vim.on_key(function(key)
          if keep_active and key == vim.keycode('<Esc>') and vim.api.nvim_get_mode().mode == 'n' then
            hide()
          end
        end, esc_ns)
      else
        schedule_hide(opts.timeout or 4000)
      end
    end)
    if not ok then
      vim.api.nvim_echo({ { 'notify error: ' .. tostring(err) } }, true, {})
    end
  end
end)
