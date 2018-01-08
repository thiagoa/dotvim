let g:pymode_lint = 0

"""" Grepper """"

let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'grep']

nnoremap <Leader>* :Grepper -cword -noprompt<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

"""" fzf """"

let g:fzf_buffers_jump = 1

"""" Asynchronous Lint Engine """"

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 0

"""" Syntax highlighting for markdown languages """"

let g:markdown_fenced_languages = ['html', 'vim', 'ruby', 'python', 'bash=sh']

"""" Alchemist """"

let g:alchemist#elixir_erlang_src = "~/Code/elixir/src"

"""" Fugitive """"

autocmd BufReadPost fugitive://* set bufhidden=delete

"""" Syntastic """"

let g:syntastic_mode_map = { "mode": "passive" }
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_ignore_files = ['scss$']

"""" Splitjoin """"

let g:splitjoin_ruby_hanging_args=0

""""""" vim-test """"""""

nmap <silent> <Leader>R :TestNearest<CR>
nmap <silent> <Leader>r :TestFile<CR>
nmap <silent> <Leader>a :TestSuite<CR>
nmap <silent> <Leader>L :TestLast<CR>
nmap <silent> <Leader>G :TestVisit<CR>
nmap <silent> <Leader>F :TestFailedExamples<CR>

"""""""" Vim bufsurf """""""""

nnoremap <silent> [v :BufSurfBack<CR>
nnoremap <silent> ]v :BufSurfForward<CR>

""""""""" UltiSnips """""""""""

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

""""""""" Startify """"""""""

let g:startify_change_to_dir=0
