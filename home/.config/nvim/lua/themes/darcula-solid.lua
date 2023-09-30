return {
  "briones-gabriel/darcula-solid.nvim",
  dependencies = "rktjmp/lush.nvim",
  enabled = not VSCODE,
  priority=1000,
  lazy = false,
  init = function()
    vim.cmd [[
      colorscheme darcula-solid
      set termguicolors
    ]]
  end,
}