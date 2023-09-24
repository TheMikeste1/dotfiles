call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'https://github.com/bkad/CamelCaseMotion.git'
Plug 'https://github.com/tpope/vim-surround.git'

call plug#end()

" Get this script's directory
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . "/"

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
xnoremap p P

" CamelCaseMotion
let g:camelcasemotion_key = '<leader>'

if exists('g:vscode')
  """ VSCode
  let s:vimSource = s:path . "../vscode.vimrc"
else
  """ Vim
  let s:vimSource = s:path . "../normal.vimrc"  
endif 

execute "source " . s:vimSource
command! -range -bar CodeCommentary call s:codeCommentary(<line1>, <line2>)

