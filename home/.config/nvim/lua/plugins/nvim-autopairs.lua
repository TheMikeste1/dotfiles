require("utilities.file_utilities")

return {
  'windwp/nvim-autopairs',
  cond = not VSCODE,
  event = "InsertEnter",
  opts = {},
  config = function()
    require('nvim-autopairs').setup()
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
  dependencies = {
    "hrsh7th/nvim-cmp"
  }
}
