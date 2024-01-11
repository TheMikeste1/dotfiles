vim.wo.wrap = false -- No word wrap
vim.opt.fillchars = { eob = " " } -- Don't show ~ on none-lines

-- Use system clipboard
if vim.fn.has("unamedplus") == 1 then
	vim.opt.clipboard = "unnamedplus"
else
	vim.opt.clipboard = "unnamed"
end

-- Set GUI colors if in the terminal
if vim.fn.has("termguicolors") and not VSCODE then
	vim.opt.termguicolors = true
end

-- Use relative numbers in the gutter
vim.opt.number = not VSCODE
vim.opt.relativenumber = not VSCODE

-- Setup indenting
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Spelling
vim.opt.spell = not VSCODE
vim.opt.spelllang = { "en_us" }

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

