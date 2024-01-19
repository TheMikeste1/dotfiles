return {
	"zbirenbaum/copilot-cmp",
	cond = not VSCODE,
	config = function()
		require("copilot_cmp").setup()
	end,
  name = "cmp-copilot",
}
