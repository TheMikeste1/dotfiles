return {
	"numToStr/Comment.nvim",
	cond = not VSCODE,
	opts = {},
	keys = {
		{ "gc", mode = { "v", "n" }, desc = "Comment lines" },
		{ "gb", mode = { "v", "n" }, desc = "Comment block" },
	},
}
