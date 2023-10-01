local function init()
  local hop = require('hop')
  vim.keymap.set('', '<Leader>f', function() hop.hint_words() end, { remap = true })
  vim.keymap.set('', '<Leader>t', function() hop.hint_words({ hint_offset = -1 }) end, { remap = true })
end

return {
  "smoka7/hop.nvim",
  config = true,
  init = init,
}
