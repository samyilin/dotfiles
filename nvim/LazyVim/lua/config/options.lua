-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.spelllang = vim.opt.spelllang + "cjk"
vim.g.dbs = {
  { name = "bigquery", url = "bigquery:ld-pcx-bia" },
}
vim.g.db_adapter_bigquery_region = "region-northamerica-northeast1"
