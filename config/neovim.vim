" ------------------
" | General config |
" ------------------

set inccommand=split

" Enable OS cute-n-paste
set clipboard=unnamed

" ---------------------
" | General functions |
" ---------------------

fun! s:nearestGitDir(buffer_dir)
  let current_dir = a:buffer_dir

  while current_dir != '/'
    if isdirectory(current_dir . '/.git')
      return current_dir
    endif

    let current_dir = fnamemodify(current_dir, ':h')
  endwhile

  return a:buffer_dir
endfun

" ---------------------
" | vim-test strategy |
" ---------------------

function! s:testFailedExamples()
  call neovim#default_test_strategy('bundle exec rspec --only-failures')
endfunction

command! -nargs=0 TestFailedExamples call s:testFailedExamples()

function! s:onTestFinish(job_id, data, event) dict
  if a:data == 0
    call jobstart('bash -c -l "echo Tests 👍 | terminal-notifier -sound Hero"')
  else
    call jobstart('bash -c -l "echo Tests 👎 | terminal-notifier -sound Basso"')
  endif
endfunction

let s:current_test_buffer = 0

function! neovim#default_test_strategy(test_cmd)
  if s:current_test_buffer > 0
    execute 'silent! bw! ' . s:current_test_buffer
  endif
  botright new
  call termopen(a:test_cmd, {'on_exit': function('s:onTestFinish')})
  set bufhidden=wipe
  let s:current_test_buffer = bufnr('%')
  wincmd p
  stopinsert
endfunction

let s:custom_test_strategies = []

function! neovim#register_test_strategy(name, condition, function)
  let strategy = { 'condition': a:condition, 'function': function(a:function) }
  call add(s:custom_test_strategies, strategy)
endfunction

function! s:pickTestStrategy(test_cmd)
  for strategy in s:custom_test_strategies
    if strategy['condition']()
      call strategy['function'](a:test_cmd)
      return
    end
  endfor

  call neovim#default_test_strategy(a:test_cmd)
endfunction

let g:test#custom_strategies = {'custom_test_strategy': function('s:pickTestStrategy')}
let g:test#strategy = 'custom_test_strategy'

" ---------------------
" | Terminal settings |
" ---------------------

tnoremap <Esc> <C-\><C-n>

highlight TermCursor ctermfg=red guifg=red
au TermOpen * setlocal nonumber norelativenumber
let g:terminal_scrollback_buffer_size = 100000

" -------------------------------
" | Easily open terminal splits |
" -------------------------------

fun! s:openBuffer(count, cmd)
  let cmd = a:count ? a:count . a:cmd : a:cmd
  exe cmd
endf

fun! s:openTerm(args, count, type)
  let params = split(a:args)
  let buffer_dir = expand('%:p:h')

  if !isdirectory(buffer_dir)
    let buffer_dir = getcwd()
  endif

  call s:openBuffer(a:count, a:type)

  if a:args == '.'
    call termopen(&shell, {'cwd': buffer_dir})
  elseif a:args == '*'
    call termopen(&shell, {'cwd': s:nearestGitDir(buffer_dir)})
  else
    exe 'terminal' a:args
  endif

  exe 'startinsert'
endf

command! -count -nargs=* Term call s:openTerm(<q-args>, <count>, 'new')
command! -count -nargs=* T call s:openTerm(<q-args>, <count>, 'new')
command! -count -nargs=* TTerm call s:openTerm(<q-args>, <count>, 'tabnew')
command! -count -nargs=* VTerm call s:openTerm(<q-args>, <count>, 'vnew')

" ------------------------------------
" | Window navigation with C-h,j,k,l |
" ------------------------------------

let s:buffer_modes = {}

function! s:register(mode)
  let s:buffer_modes[bufname('%')] = a:mode
endfunction

function! s:recoverMode()
  if get(s:buffer_modes, bufname('%'), "") == "t"
    normal 0
    startinsert
  endif
endfunction

function! s:exec(cmd, mode)
  call s:register(a:mode)
  execute a:cmd
  call s:recoverMode()
endfunction

function! s:execNormal(cmd, mode)
  call s:exec("normal! ". a:cmd, a:mode)
endfunction

function! s:moveToWindow(direction, mode)
  let a:source_buffer = bufname('%')
  call s:register(a:mode)
  stopinsert
  execute "wincmd" a:direction

  call s:recoverMode()
endfunc

function! s:mapMoveToWindow(direction)
  execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
        \ "<C-\\><C-n>:call <SID>moveToWindow(\"" . a:direction . "\", \"t\")<CR>"
  execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
        \ ":call <SID>moveToWindow(\"" . a:direction . "\", \"n\")<CR>"
endfunc

for dir in ["h", "j", "l", "k"]
  call s:mapMoveToWindow(dir)
endfor

" ----------------------------------
" | Tab navigation with opt-1 to 9 |
" ----------------------------------

nnoremap <M-+> :tabnew<CR>

nnoremap <silent> <M-l> :call <SID>exec("tabnext", "n")<CR>
nnoremap <silent> <M-h> :call <SID>exec("tabprevious", "n")<CR>
tnoremap <silent> <M-l> <C-\><C-n>:call <SID>exec("tabnext", "t")<CR>
tnoremap <silent> <M-h> <C-\><C-n>:call <SID>exec("tabprevious", "t")<CR>
tnoremap <silent> <M-c> a<BS> <C-\><C-n>:call <SID>exec("tabprevious", "t")<CR>

nnoremap <silent> <M-1> :call <SID>execNormal("1gt", "n")<CR>
nnoremap <silent> <M-2> :call <SID>execNormal("2gt", "n")<CR>
nnoremap <silent> <M-3> :call <SID>execNormal("3gt", "n")<CR>
nnoremap <silent> <M-4> :call <SID>execNormal("4gt", "n")<CR>
nnoremap <silent> <M-5> :call <SID>execNormal("5gt", "n")<CR>
nnoremap <silent> <M-6> :call <SID>execNormal("6gt", "n")<CR>
nnoremap <silent> <M-7> :call <SID>execNormal("7gt", "n")<CR>
nnoremap <silent> <M-8> :call <SID>execNormal("8gt", "n")<CR>
nnoremap <silent> <C-9> :call <SID>execNormal("9gt", "n")<CR>

tnoremap <silent> <M-1> <C-\><C-n>:call <SID>execNormal("1gt", "t")<CR>
tnoremap <silent> <M-2> <C-\><C-n>:call <SID>execNormal("2gt", "t")<CR>
tnoremap <silent> <M-3> <C-\><C-n>:call <SID>execNormal("3gt", "t")<CR>
tnoremap <silent> <M-4> <C-\><C-n>:call <SID>execNormal("4gt", "t")<CR>
tnoremap <silent> <M-5> <C-\><C-n>:call <SID>execNormal("5gt", "t")<CR>
tnoremap <silent> <M-6> <C-\><C-n>:call <SID>execNormal("6gt", "t")<CR>
tnoremap <silent> <M-7> <C-\><C-n>:call <SID>execNormal("7gt", "t")<CR>
tnoremap <silent> <M-8> <C-\><C-n>:call <SID>execNormal("8gt", "t")<CR>
tnoremap <silent> <M-9> <C-\><C-n>:call <SID>execNormal("9gt", "t")<CR>

source ~/.vim/config/stack.vim
