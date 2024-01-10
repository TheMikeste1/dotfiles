require("utilities.file_utilities")
require("utilities.state")

-- Vim setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.loader.enable()

vim.wo.wrap = false

if vim.fn.argc() == 1 then
	-- If the argument is a non-existing directory, create it and open it in the current window
	if vim.fn.argv()[1]:sub(-1) == "/" and not IsDirectory(vim.fn.argv()[1]) then
		-- Remove the slash
		local path = vim.fn.argv()[1]:sub(1, -2)
		-- Create the directory
		vim.fn.mkdir(path, "p")
	end

	-- If a directory is provided as the argument, open it in the current window
	if IsDirectory(vim.fn.argv()[1]) then
		-- enew opens a new buffer in the current window so file explorer's don't need to open the directory twice
		vim.cmd("cd " .. vim.fn.argv()[1] .. " | enew")
	end
end

-- Use system clipboard
if vim.fn.has("unamedplus") then
	vim.opt.clipboard = "unnamedplus"
else
	vim.opt.clipboard = "unnamed"
end

-- Set GUI colors if in the terminal
if vim.fn.has("termguicolors") and not VSCODE then
	vim.opt.termguicolors = true
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
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

-- Spelling
vim.opt.spell = not VSCODE
vim.opt.spelllang = { "en_us" }

-- Make Y act like D, C, etc.
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- Prevent paste from overwriting the current yank buffer
vim.api.nvim_set_keymap("x", "p", "P", { noremap = true })

require("setup")
