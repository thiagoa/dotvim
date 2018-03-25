function! s:is_stack_project()
  let a:parent_dir = fnamemodify(getcwd(), ":h:t")
  return (a:parent_dir == "stack-development")
endfunction

function! s:current_project()
  return fnamemodify(getcwd(), ":t")
endfunction

function! s:test_strategy(test_cmd)
  if s:current_project() == 'stack-api' || s:current_project() == 'stack-admin'
    let test_cmd = substitute(a:test_cmd, getcwd() . '/', '', '')
    let a:cmd = "../bin/" . test_cmd
  else
    let file = substitute(a:test_cmd, './bin/rspec ', '', '')
    let a:cmd = "../bin/bundle exec rspec " . file
  endif

  call neovim#test#default_strategy(a:cmd)
endfunction

call neovim#test#register_strategy('stack', function('s:is_stack_project'), function('s:test_strategy'))
