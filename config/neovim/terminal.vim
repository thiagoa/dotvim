command! -count -nargs=* Term call s:open_term(<q-args>, <count>, 'new')
command! -count -nargs=* TTerm call s:open_term(<q-args>, <count>, 'tabnew')
command! -count -nargs=* VTerm call s:open_term(<q-args>, <count>, 'vnew')

" ---------------------
" | Terminal settings |
" ---------------------

tnoremap <Esc> <C-\><C-n>

highlight TermCursor ctermfg=red guifg=red
au TermOpen * setlocal nonumber norelativenumber
let g:terminal_scrollback_buffer_size = 100000

" --------------------------------------
" | Functions for easy Terminal splits |
" --------------------------------------

function! s:open_buffer(count, cmd)
  let cmd = a:count ? a:count . a:cmd : a:cmd
  execute cmd
endf

function! s:parse(args)
  let cmd = strpart(a:args, 1)
  if cmd == ''
    let cmd = &shell
  endif

  return cmd
endfunction

function! s:open_term(cmd, count, type)
  let dir = functions#buffer_dir()

  call s:open_buffer(a:count, a:type)

  if a:cmd =~ '\.' || a:cmd =~ '\*'
    let dir = (a:cmd =~ '\.') ? dir : functions#git_dir(dir)
    let args = [s:parse(a:cmd), {'cwd': dir}]
  elseif a:cmd != ''
    let args = [a:cmd]
  else
    let args = [&shell]
  endif

  call call('termopen', args)
  execute 'startinsert'
endf

call functions#cabbrev('tt', 'TTerm')
call functions#cabbrev('ht', 'Term')
call functions#cabbrev('vt', 'VTerm')
