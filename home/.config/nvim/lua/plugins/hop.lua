local function init()
  local hop = require('hop')
  vim.keymap.set('', '<Leader>f', function() hop.hint_char1() end, { remap = true })
  vim.keymap.set('', '<Leader>t', function() hop.hint_char1({ hint_offset = -1 }) end, { remap = true })
end

return {
  "smoka7/hop.nvim",
  config = true,
  init = init,
}
