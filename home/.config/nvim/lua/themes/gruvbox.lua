return {
  "morhetz/gruvbox",
  cond = not VSCODE and false,
  dependencies = "rktjmp/lush.nvim",
  priority=1000,
  lazy = false,
  init = function()
    vim.cmd [[
      colorscheme gruvbox
    ]]
  end,
}