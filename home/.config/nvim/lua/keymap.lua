-- Make Y act like D, C, etc.
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- Prevent paste from overwriting the current yank buffer
vim.api.nvim_set_keymap("x", "p", "P", { noremap = true })

