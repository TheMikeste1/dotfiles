return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  enabled = not VSCODE,
  keys = {
    {
      "<C-E>",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          position = "left",
        })
      end,
      desc = "Explorer (root dir)",
    },
  },
}