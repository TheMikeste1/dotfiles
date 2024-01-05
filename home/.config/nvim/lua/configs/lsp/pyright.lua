local mod = {}

function mod.setup()
  local lspconfig = require("lspconfig")
  local coq = require("coq")

  lspconfig.pyright.setup(
    coq.lsp_ensure_capabilities{}
  )
end

return mod
