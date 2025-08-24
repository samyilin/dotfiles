return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    keys = {
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
    config = function()
      require("bufferline").setup({
        options = {
          close_command = function(n)
            Snacks.bufdelete(n)
          end,
          always_show_bufferline = true,
        },
      })
    end,
  },
}
