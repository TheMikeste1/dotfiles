return {
  "briones-gabriel/darcula-solid.nvim",
  cond = not VSCODE and false,
  dependencies = "rktjmp/lush.nvim",
  priority=1000,
  lazy = false,
  init = function()
    vim.cmd [[
      colorscheme darcula-solid
    ]]
  end,
}