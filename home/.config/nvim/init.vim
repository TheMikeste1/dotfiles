" Load Vim settings
source ~/.vimrc

" Highlight on yank
au TextYankPost * silent! lua vim.highlight.on_yank()
