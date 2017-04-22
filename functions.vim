" ******************************************************************
" Returns a dictionary that maps open buffers to their current lines
"
" Author: Thiago A. Silva
function! s:GetBufferCurrentLines()
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
" List all files that your current branch has changed on the quickfix list.
"
" Author: Thiago A. Silva
function! s:GitBranchFiles()
    let buffer_current_lines = s:GetBufferCurrentLines()

    let git_output = system('git show --pretty="" --name-only origin/master..HEAD | sort | uniq')
    let branch_files = []

    for filename in split(git_output)
        let current_line = get(buffer_current_lines, filename, '1')
        call add(branch_files, {'filename': filename, 'lnum': current_line})
    endfor

    call setqflist(branch_files)
    cwindow
endfunction

command! -nargs=0 GitBranchFiles :call s:GitBranchFiles()


" ************************************************************
" Put current git status files on the quickfix list
"
" Author: Thiago A. Silva
function! s:GitStatus()
    let buffer_current_lines = s:GetBufferCurrentLines()

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

command! -nargs=0 GitStatus :call s:GitStatus()


" *********************************************************************
" Returns complete buffer list, including unlisted buffers
"
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! s:GetCompleteBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction


" *********************************************************************
" Toggle quickfix or location list
"
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! ToggleList(bufname, pfx)
  let buflist = s:GetCompleteBufferList()
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

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>z :call ToggleList("Quickfix List", 'c')<CR>


" **************************
" Reload UltiSnips snippets
"
" Author: Thiago A. Silva
function! s:ReloadSnips()
    py3 UltiSnips_Manager.reset()
endfunction

command! -nargs=0 ReloadSnips :call s:ReloadSnips()


" ******************************************
" List all shortcuts mapped with leader keys
"
" Source unknown
function! ListLeaders()
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
function! s:GrepBuffers (expression)
  exec 'vimgrep/'.a:expression.'/ '.join(s:BuffersList())
endfunction

function! s:BuffersList()
  let all = range(0, bufnr('$'))
  let res = []
  for b in all
    if buflisted(b)
      call add(res, bufname(b))
    endif
  endfor
  return res
endfunction

command! -nargs=+ GrepBufs call s:GrepBuffers(<q-args>)


" ************************************************************
" Delete buffer and file altogether
"
" Author: Thiago A. Silva
function! s:Remove()
	let l:curfile = expand("%:p")

    if delete(l:curfile)
        echoerr "Could not delete " . l:curfile
    endif

    silent exe "bwipe! " . fnameescape(l:curfile)
endfunction

command! -nargs=0 Remove :call s:Remove()
