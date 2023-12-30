require("utilities.file_utilities")

return {
  'windwp/nvim-autopairs',
  cond = not VSCODE,
  event = "InsertEnter",
  opts = {} -- this is equalent to setup({}) function
}
