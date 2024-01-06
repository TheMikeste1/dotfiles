return {
  "petertriho/cmp-git",
  cond = not VSCODE,
  ft = {
    "git"
  },
  dependencies = {
    "nvim-lua/plenary.nvim"
  }
}
