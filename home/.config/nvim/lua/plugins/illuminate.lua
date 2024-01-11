return {
	"RRethy/vim-illuminate",
	cond = not VSCODE,
	opts = {},
  config = function ()
    require("illuminate").configure()
  end,
}
