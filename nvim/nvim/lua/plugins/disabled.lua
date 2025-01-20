return {
  { "windwp/nvim-ts-autotag", enabled = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "echasnovski/mini.files",
    enabled = false,
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
}
