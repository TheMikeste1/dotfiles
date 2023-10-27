call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'https://github.com/bkad/CamelCaseMotion.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'Konfekt/vim-CtrlXA'
Plug 'tpope/vim-commentary'

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
" Keymaps
" Make Y act like D, C, etc.
nmap Y y$
" Prevent paste from overwriting the yank buffer
xnoremap p P

let g:camelcasemotion_key = '<leader>'

nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)

if exists('g:vscode')
  """ VSCode
  let s:vimSource = s:path . "../vscode.vimrc"
else
  """ Vim
  let s:vimSource = s:path . "../normal.vimrc"  
endif 

execute "source " . s:vimSource
command! -range -bar CodeCommentary call s:codeCommentary(<line1>, <line2>)

