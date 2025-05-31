return {
  { 'echasnovski/mini.nvim', 
  version = false,
  config = function()
  require("mini.icons").setup({
    file = {
      [".keep"] = { glyph = "󰊢", hl = "miniiconsgrey" },
      ["devcontainer.json"] = { glyph = "", hl = "miniiconsazure" },
      [".go-version"] = { glyph = "", hl = "miniiconsblue" },
      [".eslintrc.js"] = { glyph = "󰱺", hl = "miniiconsyellow" },
      [".node-version"] = { glyph = "", hl = "miniiconsgreen" },
      [".prettierrc"] = { glyph = "", hl = "miniiconspurple" },
      [".yarnrc.yml"] = { glyph = "", hl = "miniiconsblue" },
      ["eslint.config.js"] = { glyph = "󰱺", hl = "miniiconsyellow" },
      ["package.json"] = { glyph = "", hl = "miniiconsgreen" },
      ["tsconfig.json"] = { glyph = "", hl = "miniiconsazure" },
      ["tsconfig.build.json"] = { glyph = "", hl = "miniiconsazure" },
      ["yarn.lock"] = { glyph = "", hl = "miniiconsblue" },
      [".chezmoiignore"] = { glyph = "", hl = "miniiconsgrey" },
      [".chezmoiremove"] = { glyph = "", hl = "miniiconsgrey" },
      [".chezmoiroot"] = { glyph = "", hl = "miniiconsgrey" },
      [".chezmoiversion"] = { glyph = "", hl = "miniiconsgrey" },
      ["bash.tmpl"] = { glyph = "", hl = "miniiconsgrey" },
      ["json.tmpl"] = { glyph = "", hl = "miniiconsgrey" },
      ["ps1.tmpl"] = { glyph = "󰨊", hl = "miniiconsgrey" },
      ["sh.tmpl"] = { glyph = "", hl = "miniiconsgrey" },
      ["toml.tmpl"] = { glyph = "", hl = "miniiconsgrey" },
      ["yaml.tmpl"] = { glyph = "", hl = "miniiconsgrey" },
      ["zsh.tmpl"] = { glyph = "", hl = "miniiconsgrey" },
    },
    filetype = {
      dotenv = { glyph = "", hl = "miniiconsyellow" },
      gotmpl = { glyph = "󰟓", hl = "miniiconsgrey" },
    },
  })
  MiniIcons.mock_nvim_web_devicons()
  end,
  },
}
