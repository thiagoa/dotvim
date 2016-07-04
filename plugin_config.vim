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

"""""" gitv """"""""

let g:Gitv_WipeAllOnClose = 1

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

  # P.S.: Not a CtrlP core variable
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

""""""" YankRing """""

let g:yankring_history_dir = '/tmp'

""""""" Vroom """"""""

let g:vroom_test_unit_command="testrbl -Itest:lib -rminitest/autorun"
let g:vroom_use_vimux=1

""""""" Vimux """"""""

nnoremap <Leader>g :VimuxZoomRunner<CR>

""""""" Tagbar """""""""

nnoremap <Leader>t :TagbarToggle<CR>

let Tlist_Use_Horiz_Window=0
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Inc_Winwidth = 0
let Tlist_Close_On_Select = 1
let Tlist_Process_File_Always = 1
let Tlist_Use_Right_Window = 0
let Tlist_Sql_Settings = 'sql;P:package;t:table'
let Tlist_Ant_Settings = 'ant;p:Project;r:Property;t:Target'
let tlist_php_settings = 'php;c:class;d:constant;f:function'

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

""""""""" Molokai """"""""""

let g:molokai_original=1
let g:rehash256=1

""""""""" Tmux navigator """""""""""

let g:tmux_navigator_no_mappings = 1
nnoremap <Esc>k :TmuxNavigateUp<cr>
nnoremap <Esc>j :TmuxNavigateDown<cr>
nnoremap <Esc>l :TmuxNavigateRight<cr>
nnoremap <Esc>h :TmuxNavigateLeft<cr>

