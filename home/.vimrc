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

"" Use relative numbers in the gutter
set relativenumber number
"" Make Y act like D, C, etc.
nmap Y y$
"" Prevent paste from overwriting the yank buffer
xnoremap p pgvy

" CamelCaseMotion
let g:camelcasemotion_key = '<leader>'
