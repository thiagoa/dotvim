command! -nargs=0 Remove :call s:remove()
command! -nargs=+ GrepBufs normal mO | :call s:grep_buffers(<q-args>)<CR> | :cwindow<CR> | :redraw<CR>
command! -nargs=0 GitStatus :call s:git_status()
command! -nargs=0 GitBranchFiles :call s:git_branch_files()
command! -nargs=+ Z :call s:z(<q-args>)
command! -nargs=0 Leaders :call s:leaders()
command! -nargs=1 SetIndent call s:set_indent(<f-args>)
command! -nargs=1 SetIndent call s:set_indent(<f-args>)
command! -nargs=0 CdRoot call functions#cd_git_dir()

" ******************************************************************
" Detect and cd to git dir based on current buffer
"
" Author: Thiago A. Silva
function! functions#cd_git_dir()
  let git_dir = functions#current_git_dir()

  exec 'cd ' . git_dir
endfunction

function! functions#current_git_dir()
  let current_dir = expand('%:h')
  let git_dir = system('git -C ' . current_dir . ' rev-parse --show-toplevel')

  if v:shell_error == 0
    return git_dir
  else
    return "."
  endif
endfunction

" ******************************************************************
" cabbrev *only* when command is at the beginning of the ex prompt
"
" Source: Modern Vim book
function! functions#cabbrev(input, output)
  exec 'cabbrev <expr> '.a:input
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
        \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction


" ******************************************************************
" Returns the nearest git directory
"
" Author: Thiago A. Silva
function! functions#git_dir(buffer_dir)
  let current_dir = a:buffer_dir

  while current_dir != '/'
    if isdirectory(current_dir . '/.git')
      return current_dir
    endif

    let current_dir = fnamemodify(current_dir, ':h')
  endwhile

  return a:buffer_dir
endfunction


" ******************************************************************
" Returns the buffer dirname. If it is a terminal, return the
" current directory.
"
" Author: Thiago A. Silva
function! functions#buffer_dir()
  let buffer_dir = expand('%:p:h')
  if !isdirectory(buffer_dir)
    let buffer_dir = getcwd()
  endif

  return buffer_dir
endfunction


" ******************************************************************
" Returns a dictionary which maps open buffers to their current lines
"
" Author: Thiago A. Silva
function! s:get_buffer_current_lines()
  let @z = ''
  redir @z
  silent buffers
  redir END

  let buffer_current_lines = {}
  let buffer_regex = '\v.*"(.*)".*line ([0-9]+)'

  for raw_buffer_info in split(@z, "\n")
    let filename = substitute(raw_buffer_info, buffer_regex, '\1', 'g')
    let line_number = substitute(raw_buffer_info, buffer_regex, '\2', 'g')

    let buffer_current_lines[filename] = line_number
  endfor

  return buffer_current_lines
endfunction


" *************************************************************************
" List all changed files of your current branch on the quickfix list.
"
" Author: Thiago A. Silva
function! s:git_branch_files()
  let buffer_current_lines = s:get_buffer_current_lines()

  let git_output = system('git show --pretty="" --name-only origin/master..HEAD | sort | uniq')
  let branch_files = []

  for filename in split(git_output)
    let current_line = get(buffer_current_lines, filename, '1')
    call add(branch_files, {'filename': filename, 'lnum': current_line})
  endfor

  call setqflist(branch_files)
  cwindow
endfunction


" ************************************************************
" Put current git status files on the quickfix list
"
" Author: Thiago A. Silva
function! s:git_status()
  let buffer_current_lines = s:get_buffer_current_lines()

  let git_output = system('git status -s')
  let git_status_files = []
  let status_file_pattern = '\v^(\s[^\s]|\?\?)\s(.*)$'

  for filename in split(git_output, "\n")
    let current_line = get(buffer_current_lines, filename, '1')
    let filename = substitute(filename, status_file_pattern, '\2', 'g')
    call add(git_status_files, {'filename': filename, 'lnum': current_line})
  endfor

  call setqflist(git_status_files)
  cwindow
endfunction


" *********************************************************************
" Returns complete buffer list (including unlisted buffers)
"
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! s:get_complete_buffer_list()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction


" *********************************************************************
" Toggle quickfix or location list
"
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! functions#toggle_list(bufname, pfx)
  let buflist = s:get_complete_buffer_list()

  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor

  if a:pfx == 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg
    echo "Location List is Empty."
    return
  endif

  let winnr = winnr()

  exec(a:pfx.'open')

  if winnr() != winnr
    wincmd p
  endif
endfunction


" ******************************************
" List all shortcuts mapped with leader keys
"
" Source unknown
function! s:leaders()
  silent! redir @a
  silent! nmap <LEADER>
  silent! redir END
  silent! new
  silent! put! a
  silent! g/^s*$/d
  silent! %s/^.*,//
  silent! normal ggVg
  silent! sort
  silent! let lines = getline(1,"$")
endfunction


" ************************************************************
" Grep in all open buffers.
"
" Taken from somewhere (can not remember where)
"
" Author: Thiago A. Silva
function! s:grep_buffers (expression)
  exec 'vimgrep/'.a:expression.'/ '.join(s:buffers_list())
endfunction

function! s:buffers_list()
  let all = range(0, bufnr('$'))
  let res = []

  for b in all
    if buflisted(b)
      call add(res, bufname(b))
    endif
  endfor

  return res
endfunction


" ************************************************************
" Delete buffer and file altogether
"
" Author: Thiago A. Silva
function! s:remove()
  let l:curfile = expand("%:p")

  if delete(l:curfile)
    echoerr "Could not delete " . l:curfile
  endif

  silent exe "bwipe! " . fnameescape(l:curfile)
endfunction


" ************************************************************
" Quickly change to directory using z.sh
"
" Use g:z_sh_path to customize the path to z.sh
"
" Author: Thiago A. Silva
function! s:z(dest)
  let z_sh_path = get(g:, 'z_sh_path', $HOME . "/bin/z.sh")
  let cmd = 'source ' . z_sh_path . ' && _z ' . a:dest . ' && pwd'
  let result = system(cmd)

  if result == ''
    call EchoWarning('Not found')
  else
    execute('cd ' . result)
    echo '👍'
  endif
endfunction

function! s:echoWarning(msg)
  echohl WarningMsg
  echo "WARNING"
  echohl None
  echon ' ' . a:msg
endfunction

function! s:set_indent(n)
  execute "setlocal shiftwidth=".a:n
  execute "setlocal tabstop=".a:n
  execute "set softtabstop=".a:n
endfunction
