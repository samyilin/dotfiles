-- In case you don't want to use `:LazyExtras`,
-- then you need to set the option below.
vim.g.lazyvim_picker = "snacks"
-- Check if pyenv/uv and the neovim venv exists before doing anything else
vim.g.python_host_installed = false
local venv_path = "~/.pyenv/versions/neovim/bin/python"
local venv_path_uv = "~/dotfiles/nvim/neovim/bin/python"
if vim.fn.executable("pyenv") == 1 and vim.fn.filereadable(venv_path) then
  vim.g.python3_host_prog = vim.fn.expand(venv_path)
  vim.g.python_host_prog = vim.fn.expand(venv_path)
  vim.g.python_host_installed = true
elseif vim.fn.executable("uv") == 1 and vim.fn.filereadable(venv_path_uv) then
  vim.g.python3_host_prog = vim.fn.expand(venv_path_uv)
  vim.g.python_host_prog = vim.fn.expand(venv_path_uv)
  vim.g.python_host_installed = true
else
  vim.print("Neither pyenv nor uv is available.")
end
-- Tweaks LazyVim plugin behaviour here.
return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
        doc = {
          inline = true,
          float = true,
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.dashboard.preset.keys, 3, {
        action = ":Mason",
        desc = "Mason",
        icon = "󰣪 ",
        key = "m",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      log_level = vim.log.levels.DEBUG,
      config = function()
        local opts = {
          formatters = {
            sqlfluff = {
              stdin = false,
              args = { "fix", "$FILENAME" },
            },
          },
          format_on_save = {
            timeout_ms = 10000,
          },
          formatters_by_ft = {
            sql = { "sqlfluff" },
          },
        }
        require("conform").setup(opts)
        require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 10000 })
      end,
    },
  },
}
