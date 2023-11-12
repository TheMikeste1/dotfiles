local function config()
  require("toggleterm").setup {
    open_mapping = [[<C-\>]]
  }
end

return {
  "akinsho/toggleterm.nvim",
  cond = not VSCODE,
  config = config,
}
