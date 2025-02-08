require("mini.pick").setup()
vim.ui.select = MiniPick.ui_select
-- These are identical to LazyVim mappings.
vim.keymap.set("n", "<leader>sg", function()
  MiniPick.builtin.grep_live({ tool = "rg" }, { source = { cwd = vim.uv.cwd() } })
end, { desc = "rg in cwd" })
vim.keymap.set("n", "<leader>ff", function()
  MiniPick.builtin.files({ tool = "fd" }, { source = { cwd = vim.uv.cwd() } })
end, { desc = "find file in cwd" })
vim.keymap.set("n", "<leader>bl", function()
  MiniPick.builtin.buffers({ tool = "rg" }, { source = { cwd = vim.uv.cwd() } })
end, { desc = "list buffers" })
vim.keymap.set("n", "<leader>fc", function()
  MiniPick.builtin.files({ tool = "fd" }, { source = { cwd = vim.fn.stdpath("config") } })
end, { desc = "find files in Neovim config" })
vim.keymap.set("n", "<leader>sc", function()
  MiniPick.builtin.grep_live({ tool = "rg" }, { source = { cwd = vim.fn.stdpath("config") } })
end, { desc = "rg file in Neovim config" })

-- Picker pre- and post-hooks ===============================================
-- Keys should be a picker source.name. Value is a callback function that
-- accepts same arguments as User autocommand callback.
local pre_hooks = {}
local post_hooks = {}
local group = vim.api.nvim_create_augroup("minipick-hooks", { clear = true })
local create_minipick_auto_command = function(pattern, desc, hooks)
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = pattern,
    group = group,
    desc = desc,
    callback = function(...)
      local opts = MiniPick.get_picker_opts()
      if opts and opts.source then
        local hook = hooks[opts.source.name] or function(...) end
        hook(...)
      end
    end,
  })
end
create_minipick_auto_command("MiniPickStart", "pre-hook for source.name", pre_hooks)
create_minipick_auto_command("MiniPickStop", "post-hook for source.name", post_hooks)
local selected_colorscheme = vim.g.colors_name -- Currently selected or original colorscheme
local previous_colorscheme = vim.g.colors_name
local previous_bg = vim.o.bg
local colors_table = function()
  local all_colorschemes = vim.fn.getcompletion("", "color")
  local current_colorscheme = vim.g.colors_name
  -- Construct a dict for tracking all colorschemes' 2 properties:
  -- 1. If they're builtin themes. If builtin, they'd be in "$VIMRUNTIME"/colors folder
  -- 2. If they have 2 variants (dark/light), their background color will differ
  local color_table = {}
  for _, color in pairs(all_colorschemes) do
    color_table[color] = { ["built_in"] = false, ["background"] = "" }
  end
  for _, file in
    pairs(
      vim.fn.glob(
        vim.uv.os_uname().sysname == "Windows_NT" and os.getenv("VIMRUNTIME") .. "\\colors\\"
          or os.getenv("VIMRUNTIME") .. "/colors/" .. "*",
        false,
        true
      )
    )
  do
    if string.sub(vim.fs.basename(file), 1, -5) ~= "README" and string.sub(vim.fs.basename(file), 1, -5) ~= "" then
      color_table[string.sub(vim.fs.basename(file), 1, -5)]["built_in"] = true
    end
  end
  for _, color in pairs(all_colorschemes) do
    vim.cmd("colorscheme " .. color)
    color_table[color]["background"] = vim.o.bg
    local bg_color = vim.api.nvim_get_hl(0, { name = "Normal" })["bg"]
    if vim.o.bg == "dark" then
      vim.o.background = "light"
      if bg_color ~= vim.api.nvim_get_hl(0, { name = "Normal" })["bg"] then
        vim.o.bg = "dark"
      end
    else
      vim.o.background = "dark"
      if bg_color ~= vim.api.nvim_get_hl(0, { name = "Normal" })["bg"] then
        color_table[color]["background"] = "both"
        vim.o.bg = "light"
      end
    end
  end
  -- Unpack this table into returned strings. Don't really like how I handelled the table here, but it works.
  -- This string is space separated. This has the nice property of being easily parsed by string.match below.
  local color_returned = {}
  for k, v in pairs(color_table) do
    if k ~= "README" then
      if v["background"] == "both" and v["built_in"] then
        table.insert(color_returned, "Builtin " .. k .. " dark")
        table.insert(color_returned, "Builtin " .. k .. " light")
      elseif v["background"] ~= "both" and v["built_in"] then
        table.insert(color_returned, "Builtin " .. k .. " " .. v["background"])
      elseif v["background"] == "both" and v["built_in"] == false then
        table.insert(color_returned, "        " .. k .. " dark")
        table.insert(color_returned, "        " .. k .. " light")
      else
        table.insert(color_returned, "        " .. k .. " " .. v["background"])
      end
    end
  end
  vim.cmd("colorscheme " .. current_colorscheme)
  -- Sort this so it won't change from session to session
  table.sort(color_returned)
  return color_returned
end
pre_hooks.Colorschemes = function()
  selected_colorscheme = vim.g.colors_name
  previous_colorscheme = vim.g.colors_name
end
-- Hook to change back colorscheme if user didn't chooss any but only previewed.
post_hooks.Colorschemes = function()
  vim.schedule(function()
    if
      string.match(selected_colorscheme, "%s+(%S+)") ~= previous_colorscheme
      and string.match(selected_colorscheme, "%s") ~= nil
    then
      vim.cmd("colorscheme " .. string.match(selected_colorscheme, "%s+(%S+)"))
    else
      vim.cmd("colorscheme " .. previous_colorscheme)
    end
    if
      string.match(selected_colorscheme, "(%S+)$") ~= previous_bg and string.match(selected_colorscheme, "%s") ~= nil
    then
      vim.o.bg = string.match(selected_colorscheme, "(%S+)$")
    else
      vim.o.bg = previous_bg
    end
  end)
end
MiniPick.registry.Colorschemes = function()
  local colorschemes = colors_table()
  return MiniPick.start({
    source = {
      name = "Colorschemes",
      items = colorschemes,
      choose = function(item)
        selected_colorscheme = item
      end,
      preview = function(buf_id, item)
        vim.cmd("colorscheme " .. string.match(item, "%s+(%S+)"))
        vim.o.bg = string.match(item, "(%S+)$")
        vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { item })
      end,
    },
  })
end
