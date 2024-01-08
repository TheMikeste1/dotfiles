return {
  "lukas-reineke/indent-blankline.nvim",
  cond = not VSCODE,
  config = function ()
    require("ibl").setup()
  end,
}
