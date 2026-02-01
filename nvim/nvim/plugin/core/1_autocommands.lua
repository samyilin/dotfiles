-- Helper for creating a new autocommand
Config.custom_group = vim.api.nvim_create_augroup('custom-config', {})
Config.new_autocmd = function(event, opts)
  opts.group = opts.group or Config.custom_group
  vim.api.nvim_create_autocmd(event, opts)
end
