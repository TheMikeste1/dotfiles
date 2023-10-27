" Move down a line when commenting
function! s:codeCommentary(...) abort
  if !a:0
      let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
      return 'g@'
  elseif a:0 > 1
      let [line1, line2] = [a:1, a:2]
  else
      let [line1, line2] = [line("'["), line("']")]
  endif

  execute line1 . ',' . line2 . 'Commentary'
  " Go to the following line
  let gotoLine = line2 + 1
  execute gotoLine  
endfunction

" Bind C-/ to commentary to add dot-repeat and auto-deselection
xnoremap <expr> <C-_> <SID>codeCommentary()
nnoremap <expr> <C-_> <SID>codeCommentary() . '_'
