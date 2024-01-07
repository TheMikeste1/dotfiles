return {
  "nvim-lualine/lualine.nvim",
  cond = not VSCODE,
  dependencies = {
        {"nvim-tree/nvim-web-devicons", lazy = true}
  },
  config = function ()
    require("lualine").setup({
      sections = {
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          }
        },
      },
    })
  end
}
