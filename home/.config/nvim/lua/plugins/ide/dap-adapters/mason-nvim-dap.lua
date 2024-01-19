return {
  "jay-babu/mason-nvim-dap.nvim",
  cond = not VSCODE,
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap"
  },
  opts = {
    handlers = {}
  }
}
