-- Check if pyenv and the neovim venv exists before doing anything else
local venv_path = "~/.pyenv/versions/neovim/bin/python"
if vim.fn.executable("pyenv") == 1 and vim.fn.filereadable(venv_path) then
  vim.g.python3_host_prog = vim.fn.expand(venv_path)
  vim.g.python_host_prog = vim.fn.expand(venv_path)
else
  vim.print("Pyenv is unavailable.")
end
return {
  {
    "linux-cultist/venv-selector.nvim",
    ft = { "python", "quarto" },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = { "python", "quarto" } } },
  },
  { "tpope/vim-sensible" },
  { "dstein64/nvim-scrollview" },
  { "lualine.nvim", extensions = { "oil" } },
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
      table.insert(opts.dashboard.preset.keys, 4, {
        action = "<leader>gg",
        desc = "Lazygit",
        icon = " ",
        key = "G",
      })
      table.insert(opts.dashboard.preset.keys, 4, {
        action = ":Themery",
        desc = "Themery",
        icon = "󰋴 ",
        key = "t",
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignores = true,
          },
        },
        window = {
          mappings = {
            ["-"] = "navigate_up",
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.files",
    config = function(_, opts)
      require("mini.files").setup(opts)
      local files_set_cwd = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        if cur_entry_path ~= nil then
          vim.fn.chdir(cur_entry_path)
        end
      end
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set(
            "n",
            opts.mappings and opts.mappings.change_cwd or "~",
            files_set_cwd,
            { buffer = args.data.buf_id, desc = "Set cwd" }
          )
        end,
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
    lazy = false,
  },
}
