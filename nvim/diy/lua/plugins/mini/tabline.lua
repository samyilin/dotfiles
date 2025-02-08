require("mini.tabline").setup({

  show_icons = true,

  -- Function which formats the tab label
  -- By default surrounds with space and possibly prepends with icon
  format = function(buf_id, label)
    local suffix = vim.bo[buf_id].modified and "" or ""
    return MiniTabline.default_format(buf_id, label) .. suffix
  end,
  -- Whether to set Vim's settings for tabline (make it always shown and
  -- allow hidden buffers)
  set_vim_settings = true,

  -- Where to show tabpage section in case of multiple vim tabpages.
  -- One of 'left', 'right', 'none'.
  tabpage_section = "left",
})
