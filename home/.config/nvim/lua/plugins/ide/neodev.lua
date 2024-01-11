return { 
  "folke/neodev.nvim",
  cond = not VSCODE,
  opts = {},
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp"
  }
}
