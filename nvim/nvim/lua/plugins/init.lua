-- Check if pyenv and the neovim venv exists before doing anything else
local venv_path = "~/.pyenv/versions/neovim/bin/python"
if vim.fn.executable("pyenv") == 1 and vim.fn.filereadable(venv_path) then
  vim.g.python3_host_prog = vim.fn.expand(venv_path)
  vim.g.python_host_prog = vim.fn.expand(venv_path)
else
  vim.print("Pyenv is unavailable.")
end
return {
  -- disable neotree
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        event = "VeryLazy",
        config = function(_, _)
          require("lazyvim.util").on_load("telescope.nvim", function()
            require("telescope").load_extension("live_grep_args")
          end)
        end,
        keys = {
          { "<leader>sL", ":Telescope live_grep_args<CR>", desc = "Live Grep" },
        },
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")
      telescope.setup({
        defaults = {
          path_display = {
            "filename_first",
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,
            },
          },
        },
      })
      telescope.load_extension("live_grep_args")
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    ft = { "python", "quarto" },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = { "python", "quarto" } } },
  },
  { "tpope/vim-sensible" },
  { "dstein64/nvim-scrollview" },
  { "tpope/vim-fugitive" },
}
