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

"""" Ag (not really a plugin) """"

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ -U

    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif

"""" Splitjoin """"

let g:splitjoin_ruby_hanging_args=0

""""""" CtrlP """"""""

if executable('ag')
  " Extension whitelist to speed up CtrlP
  " P.S.: Not a CtrlP core variable
  let g:ctrlp_exts = [
    \'rb',
    \'erb',
    \'html',
    \'js',
    \'yml',
    \'php',
    \'py',
    \'handlebars',
    \'ex',
    \'java',
    \'groovy',
    \'gsp',
    \'coffee',
    \'less',
    \'css',
    \'txt',
    \'md',
    \'markdown',
    \'rake',
    \'sh',
    \'es6',
    \'haml'
  \]

  " P.S.: Not a CtrlP core variable
  let g:ctrlp_ignored_dirs = ['node_modules', 'tmp', 'log']
  let g:ctrlp_use_caching = 1
  let g:ctrlp_user_command = 'ag %s -U -l ' +
    \ '--ignore-dir='+join(g:ctrlp_ignored_dirs, ' --ignore-dir=')+
    \' -g "('+join(g:ctrlp_exts, '|')+')$"'
endif

let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_map = '<C-p>'

nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>n :CtrlPMRU<CR>

""""""" vim-test """"""""

nmap <silent> <Leader>R :TestNearest<CR>
nmap <silent> <Leader>r :TestFile<CR>
nmap <silent> <Leader>a :TestSuite<CR>
nmap <silent> <Leader>L :TestLast<CR>
nmap <silent> <Leader>G :TestVisit<CR>

""""""" Vimux """"""""

nnoremap <Leader>g :VimuxZoomRunner<CR>

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
