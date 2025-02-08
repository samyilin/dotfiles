-- Seems like these (minipick and mason) can be called here without require
-- for now, but if they don't later on, will have to do require call

local starter = require("mini.starter")
require("mini.starter").setup({
  autoopen = true,
  content_hooks = {
    starter.gen_hook.adding_bullet(""),
    starter.gen_hook.aligning("center", "center"),
  },
  evaluate_single = true,
  footer = os.date(),
  header = table.concat({
    "███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗",
    "████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║",
    "██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║",
    "██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║",
    "██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║",
    "╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝",
  }, "\n"),
  query_updaters = [[abcdefghilmoqrstuvwxyz0123456789_,.ABCDEFGHIJKLMOQRSTUVWXYZ]],
  items = {
    { action = "Neogit", name = "g: Neogit", section = "Git" },
    { action = "enew", name = "e: New Buffer", section = "Builtin actions" },
    {
      action = function()
        MiniPick.builtin.files({ tool = "fd" }, { source = { cwd = vim.uv.cwd() } })
      end,
      name = "f: Find File (cwd)",
      section = "Builtin actions",
    },
    {
      action = function()
        MiniPick.builtin.files({ tool = "fd" }, { source = { cwd = vim.fn.stdpath("config") } })
      end,
      name = "c: Config",
      section = "Builtin actions",
    },
    {
      action = function()
        MiniPick.builtin.grep_live({ tool = "rg" }, { source = { cwd = vim.uv.cwd() } })
      end,
      name = "s: Grep Search",
      section = "Builtin actions",
    },
    {
      action = "Pick Colorschemes",
      name = "cs: colorscheme picker",
      section = "Builtin actions",
    },
    { action = "Mason", name = "m: Mason", section = "Builtin actions" },
    { action = "qall!", name = "q: Quit Neovim", section = "Builtin actions" },
  },
})
