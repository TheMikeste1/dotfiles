local MODULE_PATH = (...):match("(.-)[^%.]+$")

return {
  { import = MODULE_PATH .. "cmp-buffer" },
  { import = MODULE_PATH .. "cmp-cmdline" },
  { import = MODULE_PATH .. "cmp-ctags" },
  { import = MODULE_PATH .. "cmp-nvim-lsp" },
  { import = MODULE_PATH .. "cmp-path" },
  { import = MODULE_PATH .. "cmp-vsnip" },
  { import = MODULE_PATH .. "vim-vsnip" },
}
