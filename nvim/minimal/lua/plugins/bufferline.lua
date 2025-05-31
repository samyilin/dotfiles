return {
  {
    'akinsho/bufferline.nvim', 
    version = "*",
    config = function()
      require("bufferline").setup({
          options = {
            close_command = function(n) Snacks.bufdelete(n) end,
            always_show_bufferline = false,
          },
        })
      end,
    },
  }
