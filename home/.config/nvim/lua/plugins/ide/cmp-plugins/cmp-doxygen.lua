return {
  "paopaol/cmp-doxygen",
  cond = not VSCODE,
  dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects"
    }
}
