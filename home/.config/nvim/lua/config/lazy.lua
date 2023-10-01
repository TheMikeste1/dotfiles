local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  require('config.CamelCameMotion'),
  require('config/hop'),
  require('config/neo-tree'),
  require('config/quick-scope'),
  require('config/treesitter'),
  require('config/vim-repeat'),
  require('config/vim-surround'),

  -- Themes
  require('themes/darcula-solid'),
}

local options = {}

require("lazy").setup(plugins, options)
