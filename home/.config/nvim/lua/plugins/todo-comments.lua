return {
  "folke/todo-comments.nvim",
  cond = not VSCODE,
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim"
  }
}
