return {
	"zbirenbaum/copilot.lua",
	cond = not VSCODE,
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
		})
	end,
}

-- Print hello world




