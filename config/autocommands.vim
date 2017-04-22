" Restore cursor position
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" Do not remember position of git commit buffer
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Disable auto commenting on all file types
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Balance windows automatically in resize event
autocmd VimResized * :wincmd =
