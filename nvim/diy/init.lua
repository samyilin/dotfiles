_G.Config = {}
-- list out languages + DAPs + LSPs + linters + Treesitter parsers needed for each language. For language specific plugins, they'll reside in specific plugin configs.
-- lspconfig only manages lsp servers, DAP/linters/formatters only require Mason

-- If no git is found, this won't be executed
if vim.fn.executable("git") ~= 1 then
  require("options")
  require("keymaps")
  require("autocmds")
  vim.notify("This config minimally requires git to function.", vim.log.levels.INFO)
  return
end
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps'
require("mini.deps").setup({ path = { package = path_package } })

-- Define helpers
-- now blocks will be available in the first buffer (starter or folder buffer,
-- i.e. oil), but later block won't be available in the first buffer, it
-- seems.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local cmd = function(cmd)
  return function()
    vim.cmd(cmd)
  end
end
local load = function(spec, opts)
  return function()
    opts = opts or {}
    local slash = string.find(spec, "/[^/]*$") or 0
    local name = opts.init or string.sub(spec, slash + 1)
    if slash ~= 0 then
      add(vim.tbl_deep_extend("force", { source = spec }, opts.add or {}))
    end
    require(name)
    if opts.setup then
      require(name).setup(opts.setup)
    end
  end
end

-- Settings and mappings ====================================================
now(load("options"))
now(load("keymaps"))
now(load("autocmds"))

-- Mini.nvim ================================================================
add({ name = "mini.nvim" })
-- first load in must-have things for startup
now(load("plugins.mini.basics"))
now(load("plugins.mini.icons"))
now(load("plugins.mini.notify"))
-- now(load("plugins.mini.files"))
-- if rg or fd is not available, pick and starter won't work.
if vim.fn.executable("rg") and vim.fn.executable("fd") then
  now(load("plugins.mini.pick"))
  now(load("plugins.mini.starter"))
else
  vim.notify("rg or fd are not available, skipping mini.pick and mini.starter")
end
now(load("plugins.mini.statusline"))
now(load("plugins.mini.clue"))
now(load("plugins.mini.tabline"))
now(cmd("colorscheme minischeme"))
-- Then load things used for text editing, etc.
later(load("plugins.mini.indentscope"))
later(load("plugins.mini.bracketed"))
later(load("plugins.mini.cursorword"))
later(load("plugins.mini.pairs"))
later(load("plugins.mini.bufremove"))
later(load("plugins.mini.trailspace"))
later(load("plugins.mini.ai", { add = { depends = "mini.extra" } }))
-- Trying out Neogit for git UI inside Neovim.
later(
  load(
    "NeogitOrg/Neogit",
    { init = "plugins.neogit", add = { depends = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" } } }
  )
)
-- My go to file explorer under Neovim.
now(load("stevearc/oil.nvim", { init = "plugins.oil" }))
-- Trying out Harpoon. Nice thing is that it can mark Oil buffers, may just use that, because mini.pick can mark
-- regular text buffers but doesn't seem to mark Oil buffers.
later(load("ThePrimeagen/harpoon", {
  init = "plugins.harpoon",
  add = { depends = { "nvim-lua/plenary.nvim" }, checkout = "harpoon2", monitor = "harpoon2" },
}))
-- Treesitter.
later(load("nvim-treesitter/nvim-treesitter", {
  init = "plugins.treesitter",
  add = { hooks = { post_checkout = cmd("TSUpdate") } },
}))
later(load("nvim-treesitter/nvim-treesitter-textobjects"))

later(load("nvim-treesitter/nvim-treesitter-context", {
  init = "treesitter-context",
  setup = {},
}))
-- Blink for autocompletion
local function build_blink(params)
  vim.notify("Building blink.cmp", vim.log.levels.INFO)
  local obj = vim.system({ "cargo", "build", "--release" }, { cwd = params.path }):wait()
  if obj.code == 0 then
    vim.notify("Building blink.cmp done", vim.log.levels.INFO)
  else
    vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
  end
end
later(load("saghen/blink.cmp", {
  init = "plugins.blink",
  add = {
    depends = {
      "rafamadriz/friendly-snippets",
      "saghen/blink.compat",
    },
    hooks = {
      post_install = build_blink,
      post_checkout = build_blink,
    },
  },
}))
-- Core LSP config
later(load("williamboman/mason-lspconfig.nvim", {
  init = "plugins.lspconfig",
  add = { depends = { "neovim/nvim-lspconfig", "williamboman/mason.nvim", "folke/lazydev.nvim" } },
}))
-- So lua language server can recognize vim.uv functions.
later(load("folke/lazydev.nvim", { init = "plugins.lazydev" }))
-- Autoformatting using LSP
later(load("stevearc/conform.nvim", { init = "plugins.conform", depends = { "williamboman/mason.nvim" } }))

later(load("mfussenegger/nvim-lint", { init = "plugins.lint" }))
-- So lua language server can recognize vim.uv functions.
later(load("folke/lazydev.nvim", { init = "plugins.lazydev" }))
later(load("folke/ts-comments.nvim", { init = "plugins.ts-comments" }))
-- Rust LSP/related
later(load("plugins.extra.rust", { depends = { "Saecki/crates.nvim", "mrcjkb/rustaceanvim" } }))
