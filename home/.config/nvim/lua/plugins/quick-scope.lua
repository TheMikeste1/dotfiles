return {
  'unblevable/quick-scope',
  init = function()
    vim.cmd [[
        highlight QuickScopePrimary   guifg='#a6f25a' gui=underline ctermfg=155 cterm=underline
        highlight QuickScopeSecondary guifg='#5af2f2' gui=underline ctermfg=81  cterm=underline
      ]]
  end
}
