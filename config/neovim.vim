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

function! s:TestJobCallback(job_id, data, event) dict
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
    let bnr = bufwinnr('tests')

    if bnr > 0
      silent bw! tests
    endif

    botright new
    call termopen(a:cmd, {'on_exit': function('s:TestJobCallback')})

    file tests
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

au BufEnter * if &buftype == 'terminal' | :startinsert | endif

function! s:moveToWindow(direction, current_mode)
  let a:current_buffer = bufname('%')

  stopinsert
  execute "wincmd" a:direction

  let a:wincmd_failed = (bufname('%') == a:current_buffer)

  if a:wincmd_failed && a:current_mode == 't'
    echo "Out of bounds..."
    normal 0
    startinsert
  endif
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

tmap <C-TAB> <C-\><C-n> :tabnext<CR>
tmap <C-S-TAB> <C-\><C-n> :tabprevious<CR>

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
