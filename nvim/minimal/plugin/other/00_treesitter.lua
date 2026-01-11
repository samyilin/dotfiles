Config.on_packchanged('tree-sitter', { 'update' }, function() vim.cmd('TSUpdate') end, 'Update tree-sitter parsers')
vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
}, { load = true })

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
}

require('nvim-treesitter').install(ensure_languages)
local filetypes = vim.iter(ensure_languages):map(vim.treesitter.language.get_filetypes):flatten():totable()
Config.new_autocmd('FileType', {
  pattern = filetypes,
  callback = function(ev) vim.treesitter.start(ev.buf) end,
})

-- Display context when current block is off-screen
require('treesitter-context').setup()
