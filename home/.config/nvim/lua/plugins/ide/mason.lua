return {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
	end,
	opt = {
		ensure_installed = {
			"clangd",
      "cmakelang",
      "cmakelint",
      "neocmakelsp",
			"lua_ls",
			"pyright",
		},
	},
}
