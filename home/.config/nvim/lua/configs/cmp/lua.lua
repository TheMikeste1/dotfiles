local mod = {}

function mod.sources()
  local cmp = require("cmp")
  cmp.setup.filetype("lua", {
    sources = cmp.config.sources(
      {
        { name = "lua_ls" },
        { name = "nvim_lua" }
      },
      {
        { name = "buffer" }
      }
    )
  })
  require("cmp_git").setup()
end

return mod
