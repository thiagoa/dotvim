" Enable OS cute-n-paste
set clipboard=unnamed

" ---------------------
" | General functions |
" ---------------------

function! s:isStackProject()
  let a:parent_dir = fnamemodify(getcwd(), ":h:t")
  return (a:parent_dir == "stack-development")
endfunction

function! s:currentProject()
  return fnamemodify(getcwd(), ":t")
endfunction

" ---------------------
" | vim-test strategy |
" ---------------------

function! s:testFailedExamples()
  call TestStrategyStackDocker('bundle exec rspec --only-failures')
endfunction

function! s:testJobCallback(job_id, data, event) dict
  if a:data == 0
    call jobstart('bash -c -l "echo Tests 👍 | terminal-notifier -sound Hero"')
  else
    call jobstart('bash -c -l "echo Tests 👎 | terminal-notifier -sound Basso"')
  endif
endfunction

command! -nargs=0 TestFailedExamples call s:testFailedExamples()

function! TestStrategyStackDocker(test_cmd)
  if s:isStackProject()
    let a:cmd = "../bin/bundle " . a:test_cmd
    silent! bd! _test-runner_
    botright new
    call termopen(a:cmd, {'on_exit': function('s:testJobCallback')})
    file _test-runner_
    au BufDelete <buffer> wincmd p
    wincmd p
    stopinsert
  else
    call test#strategy#neovim(a:test_cmd)
  endif
endfunction

let g:test#custom_strategies = {'stack_docker': function('TestStrategyStackDocker')}
let g:test#strategy = 'stack_docker'

" ---------------------
" | Terminal settings |
" ---------------------

highlight TermCursor ctermfg=red guifg=red
au TermOpen * setlocal nonumber norelativenumber
let g:terminal_scrollback_buffer_size = 100000

" -------------------------------
" | Shortcuts to open terminals |
" -------------------------------

fun! s:openBuffer(count, cmd)
  let cmd = a:count ? a:count . a:cmd : a:cmd
  exe cmd
endf

fun! s:gitDirOrCurrent()
  let buffer_dir = expand('%:h')
  let current_dir = buffer_dir

  while current_dir != '/'
    if isdirectory(current_dir . '/.git')
      return current_dir
    endif

    let current_dir = fnamemodify(current_dir, ':h')
  endwhile

  return buffer_dir
endfun

fun! s:openTerm(args, count, type)
  let params = split(a:args)
  let buffer_dir = expand('%:h')
  let git_dir = s:gitDirOrCurrent()

  call s:openBuffer(a:count, a:type)
  if a:args == '.'
    call termopen(&shell, {'cwd': buffer_dir})
  elseif a:args == '*'
    call termopen(&shell, {'cwd': git_dir})
  else
    exe 'terminal' a:args
  endif
  exe 'startinsert'
endf

command! -count -nargs=* Term call s:openTerm(<q-args>, <count>, 'new')
command! -count -nargs=* T call s:openTerm(<q-args>, <count>, 'new')
command! -count -nargs=* TTerm call s:openTerm(<q-args>, <count>, 'tabnew')
command! -count -nargs=* VTerm call s:openTerm(<q-args>, <count>, 'vnew')

" ---------------------------------------
" | Move between windows with C-h,j,k,l |
" ---------------------------------------

let g:_buffer_modes = {}

function! s:registerBufferMode(mode)
  let g:_buffer_modes[bufname('%')] = a:mode
endfunction

function! s:recoverBufferMode()
  if get(g:_buffer_modes, bufname('%'), "") == "t"
    normal 0
    startinsert
  endif
endfunction

function! s:execRegisteringMode(cmd, mode)
  call s:registerBufferMode(a:mode)
  execute a:cmd
  call s:recoverBufferMode()
endfunction

function! s:normalRegisteringMode(cmd, mode)
  call s:registerBufferMode(a:mode)
  execute "normal! ". a:cmd
  call s:recoverBufferMode()
endfunction

function! s:moveToWindow(direction, mode)
  let a:source_buffer = bufname('%')
  call s:registerBufferMode(a:mode)
  stopinsert
  execute "wincmd" a:direction
  if bufname('%') == a:source_buffer
    echo "Out of bounds..."
  endif
  call s:recoverBufferMode()
endfunc

function! s:mapMoveToWindow(direction)
  execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
        \ "<C-\\><C-n>"
        \ ":call <SID>moveToWindow(\"" . a:direction . "\", \"t\")<CR>"
  execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
        \ ":call <SID>moveToWindow(\"" . a:direction . "\", \"n\")<CR>"
endfunc

for dir in ["h", "j", "l", "k"]
  call s:mapMoveToWindow(dir)
endfor

" ------------
" | Mappings |
" ------------

tnoremap <Esc> <C-\><C-n>
nnoremap <M-+> :tabnew<CR>

nnoremap <M-l> :call <SID>execRegisteringMode("tabnext", "n")<CR>
nnoremap <M-h> :call <SID>execRegisteringMode("tabprevious", "n")<CR>
tnoremap <M-l> <C-\><C-n> :call <SID>execRegisteringMode("tabnext", "t")<CR>
tnoremap <M-h> <C-\><C-n> :call <SID>execRegisteringMode("tabprevious", "t")<CR>

nnoremap <M-1> :call <SID>normalRegisteringMode("1gt", "n")<CR>
nnoremap <M-2> :call <SID>normalRegisteringMode("2gt", "n")<CR>
nnoremap <M-3> :call <SID>normalRegisteringMode("3gt", "n")<CR>
nnoremap <M-4> :call <SID>normalRegisteringMode("4gt", "n")<CR>
nnoremap <M-5> :call <SID>normalRegisteringMode("5gt", "n")<CR>
nnoremap <M-6> :call <SID>normalRegisteringMode("6gt", "n")<CR>
nnoremap <M-7> :call <SID>normalRegisteringMode("7gt", "n")<CR>
nnoremap <M-8> :call <SID>normalRegisteringMode("8gt", "n")<CR>
nnoremap <C-9> :call <SID>normalRegisteringMode("9gt", "n")<CR>

tnoremap <M-1> <C-\><C-n> :call <SID>normalRegisteringMode("1gt", "t")<CR>
tnoremap <M-2> <C-\><C-n> :call <SID>normalRegisteringMode("2gt", "t")<CR>
tnoremap <M-3> <C-\><C-n> :call <SID>normalRegisteringMode("3gt", "t")<CR>
tnoremap <M-4> <C-\><C-n> :call <SID>normalRegisteringMode("4gt", "t")<CR>
tnoremap <M-5> <C-\><C-n> :call <SID>normalRegisteringMode("5gt", "t")<CR>
tnoremap <M-6> <C-\><C-n> :call <SID>normalRegisteringMode("6gt", "t")<CR>
tnoremap <M-7> <C-\><C-n> :call <SID>normalRegisteringMode("7gt", "t")<CR>
tnoremap <M-8> <C-\><C-n> :call <SID>normalRegisteringMode("8gt", "t")<CR>
tnoremap <M-9> <C-\><C-n> :call <SID>normalRegisteringMode("9gt", "t")<CR>

" --------------
" | Workspaces |
" --------------

function! s:defaultWorkspace()
  tabnew term://zsh
  silent file 1-devterm
  if s:isStackProject()
    vnew
    call termopen("source ../.envrc && ../bin/shell " . s:currentProject())
  else
    vsplit term://zsh
  endif
  silent file 2-devterm
  wincmd h
  tabprevious
  stopinsert
endfunction

command! -nargs=0 DefaultWorkspace call s:defaultWorkspace()
