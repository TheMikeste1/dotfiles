return {
	"doums/darcula",
	cond = not VSCODE and true,
	priority = 1000,
	lazy = false,
	init = function()
		vim.cmd([[
      colorscheme darcula
    ]])
	end,
}
