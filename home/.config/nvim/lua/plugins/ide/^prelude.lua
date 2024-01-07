local MODULE_PATH = (...):match("(.-)[^%.]+$")

return {
  { import = MODULE_PATH .. "cmp-plugins.^prelude" },
  { import = MODULE_PATH .. "treesitter-extensions.^prelude" },
  { import = MODULE_PATH .. "cmp" },
  { import = MODULE_PATH .. "lspkind" },
  { import = MODULE_PATH .. "mason-lspconfig" },
  { import = MODULE_PATH .. "mason" },
  { import = MODULE_PATH .. "nvim-dap" },
  { import = MODULE_PATH .. "nvim-lspconfig" },
  { import = MODULE_PATH .. "treesitter" },
}
