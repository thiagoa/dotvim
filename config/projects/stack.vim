function! s:isStackProject()
  let a:parent_dir = fnamemodify(getcwd(), ":h:t")
  return (a:parent_dir == "stack-development")
endfunction

function! s:currentProject()
  return fnamemodify(getcwd(), ":t")
endfunction

function! s:testStrategy(test_cmd)
  let a:cmd = "../bin/bundle " . s:currentProject() . ' ' . a:test_cmd
  call neovim#default_test_strategy(a:cmd)
endfunction

call neovim#register_test_strategy('stack', function('s:isStackProject'), function('s:testStrategy'))

function! s:stackWorkspace()
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

command! -nargs=0 StackWorkspace call s:stackWorkspace()
