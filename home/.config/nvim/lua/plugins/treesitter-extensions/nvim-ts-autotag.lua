return {
  'windwp/nvim-ts-autotag',
  cond = not VSCODE,
  config = function()
    require('nvim-ts-autotag').setup()
  end,
}
