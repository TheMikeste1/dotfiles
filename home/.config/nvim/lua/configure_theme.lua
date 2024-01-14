if VSCODE then
	return
end

vim.opt.termguicolors = true

vim.cmd("colorscheme alchemist")

-- DAP
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#993939" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })

-- Neotree Icons
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

-- QuickScope
vim.cmd([[
    highlight QuickScopePrimary   guifg='#a6f25a' gui=underline ctermfg=155 cterm=underline
    highlight QuickScopeSecondary guifg='#5af2f2' gui=underline ctermfg=81  cterm=underline
  ]])

-- Sign column
-- We'll steal the background from the number line and use it as our background color
-- There might be a better way to do this, but I don't know what that would be.
local number_backgroud = vim.api.nvim_get_hl_by_name("LineNr", true).background
local number_background_string = string.format("#%06x", number_backgroud)
vim.api.nvim_set_hl(0, "MarkSignHL", { fg="red", bg=number_background_string })

