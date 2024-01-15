-- https://github.com/nvim-neotest/neotest
-- TODO: Add runners
return {
	"nvim-neotest/neotest",
  cond = not VSCODE,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
}
