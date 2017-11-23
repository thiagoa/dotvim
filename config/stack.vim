function! stack#is_stack_project()
  let a:parent_dir = fnamemodify(getcwd(), ":h:t")
  return (a:parent_dir == "stack-development")
endfunction

function! s:currentProject()
  return fnamemodify(getcwd(), ":t")
endfunction

function! stack#test_strategy(test_cmd)
  let a:cmd = "../bin/bundle " . s:currentProject() . ' ' . a:test_cmd
  call neovim#default_test_strategy(a:cmd)
endfunction

function! s:stackWorkspace()
  tabnew term://zsh
  silent file 1-devterm
  if stack#is_stack_project()
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

command! -nargs=0 StackWorkspace call s:stackWorkspace()
