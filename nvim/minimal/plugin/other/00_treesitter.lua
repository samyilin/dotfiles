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

Config.on_packchanged('tree-sitter', { 'update' }, function() vim.cmd('TSUpdate') end, 'Update tree-sitter parsers')
-- add this line just in case I decided to add some languages ad-hoc.
require('nvim-treesitter').install(ensure_languages)
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
