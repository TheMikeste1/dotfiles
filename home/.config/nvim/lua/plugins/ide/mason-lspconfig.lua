return {
	"williamboman/mason-lspconfig.nvim",
  cond = not VSCODE,
	config = function()
		require("mason-lspconfig").setup({
			automatic_installation = true,
		})
	end,
	dependencies = {
		"williamboman/mason.nvim",
    "neovim/nvim-lspconfig"
	},
}
