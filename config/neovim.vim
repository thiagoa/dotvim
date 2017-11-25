" ------------------
" | General config |
" ------------------

set inccommand=split

" Enable OS cute-n-paste
set clipboard=unnamed

" ---------------------
" | General functions |
" ---------------------

fun! s:gitDir(buffer_dir)
  let current_dir = a:buffer_dir

  while current_dir != '/'
    if isdirectory(current_dir . '/.git')
      return current_dir
    endif

    let current_dir = fnamemodify(current_dir, ':h')
  endwhile

  return a:buffer_dir
endfun

function! s:bufferDir()
  let buffer_dir = expand('%:p:h')
  if !isdirectory(buffer_dir)
    let buffer_dir = getcwd()
  endif

  return buffer_dir
endfunction

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
  normal G
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

function! s:openBuffer(count, cmd)
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

function! s:openTerm(cmd, count, type)
  let buffer_dir = s:bufferDir()

  call s:openBuffer(a:count, a:type)

  if a:cmd =~ '\.' || a:cmd =~ '\*'
    let buffer_dir = (a:cmd =~ '\.') ? buffer_dir : s:gitDir(buffer_dir)
    let args = [s:parse(a:cmd), {'cwd': buffer_dir}]
  elseif a:cmd != ''
    let args = [a:cmd]
  else
    let args = [&shell]
  endif

  call call('termopen', args)
  execute 'startinsert'
endf

command! -count -nargs=* Term call s:openTerm(<q-args>, <count>, 'new')
command! -count -nargs=* TTerm call s:openTerm(<q-args>, <count>, 'tabnew')
command! -count -nargs=* VTerm call s:openTerm(<q-args>, <count>, 'vnew')

call SetupCommandAlias('tt', 'TTerm')
call SetupCommandAlias('ht', 'Term')
call SetupCommandAlias('vt', 'VTerm')

" ------------------------------------
" | Window navigation with M-h,j,k,l |
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
  execute "tnoremap" "<silent>" "<M-" . a:direction . ">"
        \ "<C-\\><C-n>:call <SID>moveToWindow(\"" . a:direction . "\", \"t\")<CR>"
  execute "nnoremap" "<silent>" "<M-" . a:direction . ">"
        \ ":call <SID>moveToWindow(\"" . a:direction . "\", \"n\")<CR>"
endfunc

for dir in ["h", "j", "l", "k"]
  call s:mapMoveToWindow(dir)
endfor

" -----------------------------------------
" | Tab navigation with M-1 to 9 & others |
" -----------------------------------------

nnoremap <silent> <M-+> :tabnew<CR>
nnoremap <silent> <M-=> :call <SID>exec("tabnext", "n")<CR>
nnoremap <silent> <M--> :call <SID>exec("tabprevious", "n")<CR>
tnoremap <silent> <M-=> <C-\><C-n>:call <SID>exec("tabnext", "t")<CR>
tnoremap <silent> <M--> <C-\><C-n>:call <SID>exec("tabprevious", "t")<CR>

for n in range(1, 9)
  execute 'nnoremap <silent> <M-' . n . '> :call <SID>execNormal("' . n . 'gt", "n")<CR>'
  execute 'tnoremap <silent> <M-' . n . '> <C-\><C-n>:call <SID>execNormal("' . n . 'gt", "t")<CR>'
endfor

" ---------------------------------
" | Source project-specific setup |
" ---------------------------------

for file in globpath('~/.vim/config/projects', '*', 0, 1)
  execute 'source ' . file
endfor
