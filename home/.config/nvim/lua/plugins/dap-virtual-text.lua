return {
	"theHamsta/nvim-dap-virtual-text",
	cond = not VSCODE,
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-treesitter/nvim-treesitter",
	},
	event = "VeryLazy",
}
