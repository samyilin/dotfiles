require("mini.indentscope").setup()
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "oil",
    "ministarter",
    -- "Trouble",
    -- "alpha",
    -- "dashboard",
    -- "fzf",
    -- "help",
    -- "lazy",
    -- "mason",
    -- "neo-tree",
    -- "notify",
    -- "snacks_dashboard",
    -- "snacks_notif",
    -- "snacks_terminal",
    -- "snacks_win",
    -- "toggleterm",
    -- "trouble",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
