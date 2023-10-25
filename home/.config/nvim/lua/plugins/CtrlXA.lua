return {
  'Konfekt/vim-CtrlXA',
  init = function()
    vim.cmd [[
      nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
      nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)
    ]]
  end
}
