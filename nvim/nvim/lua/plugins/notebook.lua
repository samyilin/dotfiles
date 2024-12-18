if
  (vim.uv.os_uname().sysname ~= "Windows_NT" and vim.fn.stridx(vim.uv.os_uname().release, "microsoft") < 0)
  or os.getenv("TERM") == "xterm-kitty"
then
  return {
    {
      "benlubas/molten-nvim",
      lazy = true,
      build = ":UpdateRemotePlugins",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        -- "willothy/wezterm.nvim",
      },
      config = function()
        require("lspconfig")["pyright"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportUnusedExpression = "none",
                },
              },
            },
          },
        })
        vim.g.molten_auto_open_output = false
        vim.g.molten_output_show_more = true
        vim.g.molten_image_provider = "kitty"
        vim.g.molten_split_direction = "right"
        vim.g.molten_output_virt_lines = true
        -- vim.g.molten_split_direction = "right" --direction of the output window, options are "right", "left", "top", "bottom"
        vim.g.molten_wrap_output = true
        -- vim.g.molten_split_size = 40 --(0-100) % size of the screen dedicated to the output window
        vim.g.molten_virt_text_output = true
        vim.g.molten_use_border_highlights = true
        vim.g.molten_virt_lines_off_by_1 = true
        vim.g.molten_auto_image_popup = false
        vim.keymap.set("n", "<leader>io", ":MoltenImportOutput<CR>", { desc = "Import output", silent = false })
        -- automatically export output chunks to a jupyter notebook on write
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.ipynb" },
          callback = function()
            if require("molten.status").initialized() == "Molten" then
              vim.cmd("MoltenExportOutput!")
            end
          end,
        })

        -- change the configuration when editing a python file
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = "*.py",
          callback = function(e)
            if string.match(e.file, ".otter.") then
              return
            end
            if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
              vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
              vim.fn.MoltenUpdateOption("virt_text_output", false)
            else
              vim.g.molten_virt_lines_off_by_1 = false
              vim.g.molten_virt_text_output = false
            end
          end,
        })

        -- Undo those config changes when we go back to a markdown or quarto file
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = { "*.qmd", "*.md", "*.ipynb" },
          callback = function(e)
            if string.match(e.file, ".otter.") then
              return
            end
            if require("molten.status").initialized() == "Molten" then
              vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
              vim.fn.MoltenUpdateOption("virt_text_output", true)
            else
              vim.g.molten_virt_lines_off_by_1 = true
              vim.g.molten_virt_text_output = true
            end
          end,
        })
      end,
    },
    { -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
      -- for complete functionality (language features)
      "quarto-dev/quarto-nvim",
      lazy = true,
      dev = false,
      dependencies = {
        -- for language features in code cells
        -- configured in lua/plugins/lsp.lua and
        -- added as a nvim-cmp source in lua/plugins/completion.lua
        "jmbuhr/otter.nvim",
      },
      config = function()
        require("quarto").setup({
          debug = false,
          closePreviewOnExit = true,
          lspFeatures = {
            enabled = true,
            chunks = "all",
            languages = { "r", "python", "julia", "bash", "html" },
            diagnostics = {
              enabled = true,
              triggers = { "BufWritePost" },
            },
            completion = {
              enabled = true,
            },
          },
          codeRunner = {
            enabled = true,
            default_method = "molten", -- 'molten' or 'slime'
            -- ft_runners = { python = "molten" }, -- filetype to runner, ie. `{ python = "molten" }`.
            -- Takes precedence over `default_method`
            never_run = { "yaml" }, -- filetypes which are never sent to a code runner
          },
          keymap = {
            -- set whole section or individual keys to `false` to disable
            hover = "K",
            definition = "gd",
            type_definition = "gD",
            rename = "<leader>lR",
            format = "<leader>lf",
            references = "gr",
            document_symbols = "gS",
          },
        })
        local quarto = require("quarto")
        vim.keymap.set("n", "<leader>qp", quarto.quartoPreview, { silent = true, noremap = true })
        local runner = require("quarto.runner")
        vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
        vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
        vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
        vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
        vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
        vim.keymap.set("n", "<localleader>RA", function()
          runner.run_all(true)
        end, { desc = "run all cells of all languages", silent = true })
      end,
    },
    {
      "GCBallesteros/jupytext.nvim",
      lazy = true,
      config = function()
        require("jupytext").setup({
          style = "markdown",
          output_extension = "md", -- Default extension. Don't change unless you know what you are doing
          force_ft = "markdown", -- Default filetype. Don't change unless you know what you are doing
          custom_language_formatting = {
            python = {
              extension = "qmd",
              style = "quarto",
              force_ft = "quarto",
            },
            r = {
              extension = "qmd",
              style = "quarto",
              force_ft = "quarto",
            },
          },
        })
      end,
    },
    {
      "jbyuki/nabla.nvim",
      lazy = true,
      event = "VeryLazy",
      config = function()
        require("nabla").enable_virt({ autogen = true })
      end,
    },
    {
      "render-markdown.nvim",
      lazy = true,
      config = function()
        require("render-markdown").setup({
          file_types = { "markdown" },
          latex = { enabled = false },
          win_options = {
            conceallevel = {
              default = vim.api.nvim_get_option_value("conceallevel", {}),
              rendered = 2, -- <- especially this, so that both plugins play nice
            },
          },
        })
      end,
    },
  }
else
  return {}
end
