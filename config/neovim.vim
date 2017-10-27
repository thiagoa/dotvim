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
    let a:cmd = "../bin/background-shell-run " . s:currentProject() . " " . a:test_cmd

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

" ------------------
" | Terminal color |
" ------------------

highlight TermCursor ctermfg=red guifg=red

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

function! s:registeringMode(cmd, mode)
  call s:registerBufferMode(a:mode)

  execute a:cmd

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

nnoremap <C-TAB> :call <SID>registeringMode("tabnext", "n")<CR>
nnoremap <C-S-TAB> :call <SID>registeringMode("tabprevious", "n")<CR>
tnoremap <C-TAB> <C-\><C-n> :call <SID>registeringMode("tabnext", "t")<CR>
tnoremap <C-S-TAB> <C-\><C-n> :call <SID>registeringMode("tabprevious", "t")<CR>

" --------------
" | Workspaces |
" --------------

function! s:defaultWorkspace()
  tabnew term://zsh
  silent file 1-devterm

  if s:isStackProject()
    vnew
    call termopen("../bin/shell " . s:currentProject())
  else
    vsplit term://zsh
  endif

  silent file 2-devterm

  wincmd h
  tabprevious
  stopinsert
endfunction

command! -nargs=0 DefaultWorkspace call s:defaultWorkspace()
