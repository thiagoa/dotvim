" Restore cursor position in all files
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" Do not remember position of git commit buffer
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Disable auto commenting on all file types
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Balance windows automatically during resize event
autocmd VimResized * :wincmd =

" Protect large files (> 10 MB) from slowness by disabling filetype plugin.
if !exists("large_file_autocmd_is_loaded")
  let large_file_autocmd_is_loaded = 1

  let g:LargeFile = 1024 * 1024 * 10

  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile | else | set eventignore-=FileType | endif
  augroup END
endif
