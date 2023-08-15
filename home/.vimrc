call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'https://github.com/bkad/CamelCaseMotion.git'
Plug 'https://github.com/tpope/vim-surround.git'

call plug#end()

" Use system clipboard
if has("unnamedplus")
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Use relative numbers in the gutter
set relativenumber number
" Make Y act like D, C, etc.
nmap Y y$
" Prevent paste from overwriting the yank buffer
xnoremap p pgvy

" CamelCaseMotion
let g:camelcasemotion_key = '<leader>'

if exists('g:vscode')
  """ VSCode
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
else
  """ Vim
  call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

  Plug 'tpope/vim-commentary'

  call plug#end()

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
endif 

command! -range -bar CodeCommentary call s:codeCommentary(<line1>, <line2>)
