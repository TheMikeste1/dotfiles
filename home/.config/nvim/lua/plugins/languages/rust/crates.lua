return {
	"saecki/crates.nvim",
  cond = not VSCODE,
	event = { "BufRead Cargo.toml" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("crates").setup()
	end,
}
