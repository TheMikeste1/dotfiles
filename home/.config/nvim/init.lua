vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.loader.enable()

VSCODE = vim.g.vscode == 1

-- If a directory is provided as the argument, open it in the current window
if (vim.fn.argc() > 0 and vim.fn.isdirectory(vim.fn.argv()[1])) then
  -- enew opens a new buffer in the current window so file explorer's don't need to open the directory twice
  vim.cmd("cd " .. vim.fn.argv()[1] .. " | enew")
end

-- Use system clipboard
if (vim.fn.has("unamedplus")) then
  vim.opt.clipboard = "unnamedplus"
else
  vim.opt.clipboard = "unnamed"
end

-- Set GUI colors if in the terminal
if (vim.fn.has("termguicolors") and not VSCODE) then
  vim.opt.termguicolors = true
end

require("setup")

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

-- Setup indenting
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Make Y act like D, C, etc.
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Prevent paste from overwriting the current yank buffer
vim.api.nvim_set_keymap('x', 'p', 'P', { noremap = true })
