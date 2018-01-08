" ------------------------------------
" | Window navigation with M-h,j,k,l |
" ------------------------------------

let s:buffer_modes = {}

function! s:register_mode(mode)
  let s:buffer_modes[bufname('%')] = a:mode
endfunction

function! s:recover_mode()
  let mode = get(s:buffer_modes, bufname('%'), "")

  if mode == "t"
    normal 0
    startinsert
  elseif mode == 'i'
    startinsert
  endif
endfunction

function! s:exec(cmd, mode)
  call s:register_mode(a:mode)
  execute a:cmd
  call s:recover_mode()
endfunction

function! s:exec_normal(cmd, mode)
  call s:exec("normal! ". a:cmd, a:mode)
endfunction

function! s:move_to_window(direction, mode)
  let a:source_buffer = bufname('%')
  call s:register_mode(a:mode)
  stopinsert
  execute "wincmd" a:direction

  call s:recover_mode()
endfunc

function! s:map_move_to_window(direction)
  execute "tnoremap" "<silent>" "<M-" . a:direction . ">"
        \ "<C-\\><C-n>:call <SID>move_to_window(\"" . a:direction . "\", \"t\")<CR>"
  execute "nnoremap" "<silent>" "<M-" . a:direction . ">"
        \ ":call <SID>move_to_window(\"" . a:direction . "\", \"n\")<CR>"
endfunc

for dir in ["h", "j", "l", "k"]
  call s:map_move_to_window(dir)
endfor

" -------------------------------------------------
" | Tab navigation with M-1 to 9 & other commands |
" -------------------------------------------------

nnoremap <silent> <M-+> :tabnew<CR>
nnoremap <silent> <M-=> :call <SID>exec("tabnext", "n")<CR>
nnoremap <silent> <M--> :call <SID>exec("tabprevious", "n")<CR>
tnoremap <silent> <M-=> <C-\><C-n>:call <SID>exec("tabnext", "t")<CR>
tnoremap <silent> <M--> <C-\><C-n>:call <SID>exec("tabprevious", "t")<CR>

for n in range(1, 9)
  execute 'nnoremap <silent> <M-' . n . '> :call <SID>exec_normal("' . n . 'gt", "n")<CR>'
  execute 'tnoremap <silent> <M-' . n . '> <C-\><C-n>:call <SID>exec_normal("' . n . 'gt", "t")<CR>'
  execute 'inoremap <silent> <M-' . n . '> <C-\><C-n>:call <SID>exec_normal("' . n . 'gt", "i")<CR>'
endfor
