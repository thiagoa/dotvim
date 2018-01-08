command! -nargs=0 TestFailedExamples call s:test_failed_examples()

" ---------------------
" | vim-test strategy |
" ---------------------

function! s:test_failed_examples()
  call neovim#test#default_test_strategy('bundle exec rspec --only-failures')
endfunction

function! s:on_test_finish(job_id, data, event) dict
  if a:data == 0
    call jobstart('bash -c -l "echo Tests 👍 | terminal-notifier -sound Hero"')
  else
    call jobstart('bash -c -l "echo Tests 👎 | terminal-notifier -sound Basso"')
  endif
endfunction

let s:current_test_buffer = 0

function! neovim#test#default_strategy(test_cmd)
  if s:current_test_buffer > 0
    execute 'silent! bw! ' . s:current_test_buffer
  endif

  botright new
  call termopen(a:test_cmd, {'on_exit': function('s:on_test_finish')})
  let s:current_test_buffer = bufnr('%')
  normal G
  wincmd p
  stopinsert
endfunction

let s:test_strategies = []

function! neovim#test#register_strategy(name, condition, function)
  let strategy = { 'condition': a:condition, 'function': function(a:function) }
  call add(s:test_strategies, strategy)
endfunction

function! s:pick_test_strategy(test_cmd)
  for strategy in s:test_strategies
    if strategy['condition']()
      call strategy['function'](a:test_cmd)
      return
    end
  endfor

  call neovim#test#default_strategy(a:test_cmd)
endfunction

let g:test#custom_strategies = {'custom_test_strategy': function('s:pick_test_strategy')}
let g:test#strategy = 'custom_test_strategy'
