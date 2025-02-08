require("nvim-treesitter.configs").setup({
  modules = {},
  sync_install = false,
  ignore_install = {},
  ensure_installed = {
    "rust",
    "zig",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "bash",
    "json",
    "toml",
    "yaml",
    "vim",
    "vimdoc",
    "rust",
    "ron",
  },
  auto_install = true,
  highlight = {
    enable = true,
    -- Some languages depend on vim's regex highlighting system (such as
    -- Ruby) for indent rules. If you are experiencing weird indenting
    -- issues, add the language to the list of additional vim regex
    -- highlighting and disabled languages for indent.
    -- additional_vim_regex_highlighting = { "ruby" },
  },
  textobjects = { enable = true },
  indent = {
    enable = true,
    disable = { "ruby", "markdown" },
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "<C-space>",
  --     node_incremental = "<C-space>",
  --     scope_incremental = false,
  --     node_decremental = "<bs>",
  --   },
  -- },
})
