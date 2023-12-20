return {
  "nvim-lualine/lualine.nvim",
  cond = not VSCODE,
  dependencies = {
        {"nvim-tree/nvim-web-devicons", lazy = true}
  },
  config = true
}
