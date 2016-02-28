" Utility function to map open buffers to current line
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

" Put current git branch files in the quickfix list
"
" If the file is already open in a buffer, the quickfix entry
" will point at the same line
"
" Author: Thiago A. Silva
function! s:BranchFilesToQuickFix()
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

command! -nargs=0 BranchFilesToQuickFix :call s:BranchFilesToQuickFix()

" Put current git status files in the quickfix list
"
" If the file is already open in a buffer, the quickfix entry
" will point at the same line
"
" Author: Thiago A. Silva
function! s:StatusFilesToQuickFix()
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

command! -nargs=0 StatusFilesToQuickFix :call s:StatusFilesToQuickFix()
