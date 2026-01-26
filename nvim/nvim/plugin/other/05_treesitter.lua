Config.now_if_args(function()
  local ensure_languages = {
    'bash',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'rust',
    'sql',
    'toml',
    'yaml',
    'gitignore',
    'gitattributes',
    'gitcommit',
    'git_config',
    'git_rebase',
    'jinja_inline',
    'jinja',
    -- snacks.nvim requirements
    'css',
    'html',
    'javascript',
    'latex',
    -- 'norg',
    'scss',
    'svelte',
    'tsx',
    'typst',
    'vue',
  }
  vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
  }, { load = true })

  -- Not sure how much of this crap is needed, will update once I know.
  -- This will mature as vim.pack improves.
  Config.on_packchanged('tree-sitter', { 'update' }, function()
    vim.cmd('TSUpdate')
    require('nvim-treesitter.parsers').jsonc = {
      install_info = {
        url = 'https://gitlab.com/WhyNotHugo/tree-sitter-jsonc',
        revision = 'HEAD', -- commit hash for revision to check out; HEAD if missing
        -- optional entries:
        branch = 'main', -- only needed if different from default branch
        -- location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
        generate = false, -- only needed if repo does not contain pre-generated `src/parser.c`
        generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
        -- queries = 'queries/neovim', -- also install queries from given directory
      },
      tier = 1,
    }
  end, 'Update tree-sitter parsers')
  -- add this line just in case I decided to add some languages ad-hoc.
  require('nvim-treesitter').install(ensure_languages)
  Config.new_autocmd('User', {
    pattern = 'TSUpdate',
    callback = function()
      require('nvim-treesitter.parsers').jsonc = {
        install_info = {
          url = 'https://gitlab.com/WhyNotHugo/tree-sitter-jsonc',
          revision = 'HEAD', -- commit hash for revision to check out; HEAD if missing
          -- optional entries:
          branch = 'main', -- only needed if different from default branch
          -- location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
          generate = false, -- only needed if repo does not contain pre-generated `src/parser.c`
          generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
          -- queries = 'queries/neovim', -- also install queries from given directory
        },
        tier = 1,
      }
    end,
    desc = '',
  })
  require('nvim-treesitter').setup({
    incremental_selection = {
      enable = true,
    },
  })

  local filetypes = vim.iter(ensure_languages):map(vim.treesitter.language.get_filetypes):flatten():totable()
  Config.new_autocmd('FileType', {
    pattern = filetypes,
    callback = function() vim.treesitter.start() end,
  })

  -- Display context when current block is off-screen
  require('treesitter-context').setup()
end)
