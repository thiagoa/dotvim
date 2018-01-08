function! s:is_stack_project()
  let a:parent_dir = fnamemodify(getcwd(), ":h:t")
  return (a:parent_dir == "stack-development")
endfunction

function! s:current_project()
  return fnamemodify(getcwd(), ":t")
endfunction

function! s:test_strategy(test_cmd)
  let a:cmd = "../bin/bundle " . a:test_cmd
  call neovim#test#default_strategy(a:cmd)
endfunction

call neovim#test#register_strategy('stack', function('s:is_stack_project'), function('s:test_strategy'))

function! s:workspace()
  tabnew term://zsh
  silent file 1-devterm
  if s:is_stack_project()
    vnew
    call termopen("source ../.envrc && ../bin/shell " . s:current_project())
  else
    vsplit term://zsh
  endif
  silent file 2-devterm
  wincmd h
  tabprevious
  stopinsert
endfunction

command! -nargs=0 StackWorkspace call s:workspace()
