-- TODO
return {
	"mfussenegger/nvim-dap",
	cond = not VSCODE,
	config = function() end,
	event = "VeryLazy",
}
