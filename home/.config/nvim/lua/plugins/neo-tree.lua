return {
  "nvim-neo-tree/neo-tree.nvim",
  cond = not VSCODE,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<C-E>",
      function()
        require("neo-tree.command").execute({
          action = "focus",
          position = "left",
          reveal = true,
        })
      end,
      desc = "Explorer",
    },
    {
      "<C-b>",
      function()
        require("neo-tree.command").execute({
          action = "show",
          position = "left",
          reveal = true,
          toggle = true,
        })
      end,
      desc = "Toggle sideview",
    },
  },
}