return {
  "briones-gabriel/darcula-solid.nvim",
  dependencies = "rktjmp/lush.nvim",
  priority=1000,
  lazy = false,
  init = function()
    vim.cmd 'colorscheme darcula-solid'
    vim.cmd 'set termguicolors'
  end,
  enabled = not VSCODE
}