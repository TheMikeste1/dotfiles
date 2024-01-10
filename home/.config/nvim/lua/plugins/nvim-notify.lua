return {
	"rcarriga/nvim-notify",
	cond = not VSCODE,
	opts = {
    max_width = 36,
    minimum_width = 8,
		render = "wrapped-compact",
    timeout = 1000,
    top_down = false
	},
}
