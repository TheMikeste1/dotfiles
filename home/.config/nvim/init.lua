vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.loader.enable()

VSCODE = vim.g.vscode == 1

require("config.lazy")

-- Use system clipboard
if (vim.fn.has("unamedplus")) then
  vim.opt.clipboard = "unnamedplus"
else
  vim.opt.clipboard = "unnamed"
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Use relative numbers in the gutter
vim.opt.number = not VSCODE
vim.opt.relativenumber = not VSCODE

-- Make Y act like D, C, etc.
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Prevent paste from overwriting the current yank buffer
vim.api.nvim_set_keymap('x', 'p', 'P', { noremap = true })
