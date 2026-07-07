-- Putting configs that need multiple plugins here for final touch.
-- Colorscheme is determined latest, so as to ensure it's able to detect
-- all installed colorschemes.
vim.cmd.colorscheme('miniautumn')

-- autocmd for toggling conform and mini.trailspace autoformatting.
-- These don't touch conform or mini directly, but loading this after
-- all plugins just in case.
vim.api.nvim_create_user_command('FormatToggle', function()
  vim.g.trailspace_on_save = not vim.g.trailspace_on_save
  vim.b.disable_autoformat = not vim.b.disable_autoformat
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  if vim.b.disable_autoformat then
    vim.notify('Autoformat is disabled')
  else
    vim.notify('Autoformat is enabled')
  end
end, {
  desc = 'Toggle autoformat on save',
})
