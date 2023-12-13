return {
  'unblevable/quick-scope',
  config = function()
    vim.cmd [[
        highlight QuickScopePrimary   guifg='#a6f25a' gui=underline ctermfg=155 cterm=underline
        highlight QuickScopeSecondary guifg='#5af2f2' gui=underline ctermfg=81  cterm=underline
      ]]
  end,
  priority=1001, -- Needs to be loaded after themes so the highlight is correct
}
