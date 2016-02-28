set tabstop=2
set softtabstop=2
set shiftwidth=2
set colorcolumn=80

" Find Ruby files with gf command
augroup rubypath
autocmd!
autocmd FileType ruby setlocal suffixesadd+=.rb
augroup END
