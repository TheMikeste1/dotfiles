" Move down a line when commenting
" VSCode comments; Source: https://github.com/vscode-neovim/vscode-neovim/blob/master/vim/vscode-code-actions.vim
function! s:codeCommentary(...) abort
  if !a:0
      let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
      return 'g@'
  elseif a:0 > 1
      let [line1, line2] = [a:1, a:2]
  else
      let [line1, line2] = [line("'["), line("']")]
  endif

  call VSCodeCallRange('editor.action.commentLine', line1, line2, 0)
  " Go to the following line
  let gotoLine = line2 + 1
  execute gotoLine  
endfunction

" Bind C-/ to commentary to add dot-repeat and auto-deselection
xnoremap <expr> <C-/> <SID>codeCommentary()
nnoremap <expr> <C-/> <SID>codeCommentary() . '_'
