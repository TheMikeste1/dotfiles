return {
	"mfussenegger/nvim-dap-python",
	cond = not VSCODE,
	config = function()
		require("dap-python").setup("~/.asdf/shims/python")
	end,
	event = "VeryLazy",
}
