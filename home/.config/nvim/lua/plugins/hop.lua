return {
	"smoka7/hop.nvim",
	config = true,
	keys = {
		{
			"<leader>f",
			function()
				local hop = require("hop")
				hop.hint_char2()
			end,
			mode = {
				"v",
				"n",
			},
			desc = "Hop 2 characters",
		},
	},
}
