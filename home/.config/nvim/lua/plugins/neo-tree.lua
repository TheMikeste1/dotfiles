local function open_on_empty()
  require("neo-tree.command").execute({
    action = "focus",
    position = "float",
    reveal = true,
  })
end

local function init()
  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    -- Open NeoTree automatically when vim starts if no files were specified or if a directory was specified
    callback = function()
      if vim.fn.argc() == 0 or vim.fn.isdirectory(vim.fn.argv()[1]) then
        open_on_empty()
        return
      end

      -- Filter out arguments, leaving only files and directories
      local args = vim.tbl_filter(function(arg)
        return not vim.fn.isdirectory(arg)
      end, vim.fn.argv())

      -- Open NeoTree if no files were specified
      if vim.tbl_isempty(args) then
        open_on_empty()
      end
    end
  })
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  cond = not VSCODE,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<C-E>",
      function()
        require("neo-tree.command").execute({
          action = "focus",
          position = "left",
          reveal = true,
        })
      end,
      desc = "Explorer",
    },
    {
      "<C-b>",
      function()
        require("neo-tree.command").execute({
          action = "show",
          position = "left",
          reveal = true,
          toggle = true,
        })
      end,
      desc = "Toggle sideview",
    },
  },
  init = init
}
