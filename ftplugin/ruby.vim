set tabstop=2
set softtabstop=2
set shiftwidth=2

let b:ale_fixers = ['standardrb']

" Find Ruby files with gf command
augroup rubypath
autocmd!
autocmd FileType ruby setlocal suffixesadd+=.rb
augroup END
