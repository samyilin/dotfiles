require("blink.cmp").setup({
  keymap = {
    preset = "super-tab",
    ["<Tab>"] = {
      require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
      require("util").map({ "snippet_forward", "ai_accept" }),
      "fallback",
    },
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = true,
    },
    menu = {
      draw = {
        treesitter = { "lsp" },
      },
    },
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
  },
  signature = {
    enabled = true,
  },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono",
    kind_icons = require("util").icons.kinds,
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    },
  },
})
