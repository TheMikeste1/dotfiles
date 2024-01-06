local mod = {}

function mod.sources()
  local cmp = require("cmp")
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources(
      {
        {name = "git"}
      },
      {
        {name = "buffer"}
      }
    )
  })
  require("cmp_git").setup()
end

return mod
