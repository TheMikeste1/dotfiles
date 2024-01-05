local MODULE_PATH = (...):match("(.-)[^%.]+$")

return {
  { import = MODULE_PATH .. "nvim-ts-autotag" },
  { import = MODULE_PATH .. "treesitter-textobjects" },
  { import = MODULE_PATH .. "treesitter-textsubjects" },
}
