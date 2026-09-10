Config.now_if_args(function()
  vim.pack.add({
    {
      src = 'https://github.com/samyilin/dbtpal.nvim',
    },
  }, { load = true })

  require('dbtpal').setup({
    path_to_dbt = vim.env.DBT_EXECUTABLE or 'dbt',
    path_to_dbt_project = '',
    path_to_dbt_profiles_dir = vim.env.DBT_PROFILES_DIR
      or vim.fn.expand('~/.dbt'),
    include_project_dir = true,
    include_profiles_dir = true,
    include_log_level = true,
    extended_path_search = true,
    protect_compiled_files = true,
    picker_backend = 'mini.pick',
    output_mode = 'float',
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'sql', 'dbt' },
    group = Config.custom_group,
    callback = function()
      vim.keymap.set('n', 'gd', '<cmd>DbtGotoModel<cr>', { buffer = true })
    end,
  })
end)
