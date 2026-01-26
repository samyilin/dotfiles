-- local function build_blink(params)
--   vim.notify('Building blink.cmp', vim.log.levels.INFO)
--   local obj = vim.system({ 'cargo', 'build', '--release' }, { cwd = params.path }):wait()
--   if obj.code == 0 then
--     vim.notify('Building blink.cmp done', vim.log.levels.INFO)
--   else
--     vim.notify('Building blink.cmp failed', vim.log.levels.ERROR)
--   end
-- end
-- -- Config.on_packchangedpre('blink.cmp', { 'update', 'install' }, build_blink, 'blink.cmp')
-- vim.api.nvim_create_autocmd('PackChangedPre', { pattern = 'blink.cmp', callback = build_blink })
--
-- Create an event to build `blink.cmp` with `cargo build --release`.
-- This event should be defined *before* the `vim.pack.add` call
-- so it runs automatically after the plugin is installed.
-- vim.api.nvim_create_autocmd('PackChanged', {
--   pattern = 'blink.cmp',
--   group = vim.api.nvim_create_augroup('blink_update', { clear = true }),
--   callback = function(e)
--     if e.data.kind == 'update' then
--       -- Recommended way to access plugin files inside `PackChanged` event
--       -- vim.cmd [[packadd blink.cmp]]
--       vim.cmd.packadd({ args = { e.data.spec.name }, bang = false })
--       -- Build the plugin from source
--       -- vim.cmd [[BlinkCmp build]]
--       require('blink.cmp.fuzzy.build').build()
--     end
--   end,
-- })

Config.later(function()
  vim.pack.add({ { src = 'https://github.com/saghen/blink.cmp' } })
  require('blink.cmp').setup({
    fuzzy = {
      -- implementation = 'lua',
    },
    appearance = {
      use_nvim_cmp_as_default = true,
    },
    completion = {
      documentation = {
        auto_show = true,
      },
    },
  })
end)
