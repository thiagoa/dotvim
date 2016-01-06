"""""""""""""""""""""
" VIM CONFIGURATION "
"""""""""""""""""""""

call pathogen#incubate()
call pathogen#helptags()
execute pathogen#infect()

syntax on

filetype plugin on
filetype plugin indent on

set hidden
set history=1000
set shell=/bin/bash

set noshowmode
set exrc
set shiftround

set fileencodings=utf-8,iso-8859-1

set number

set guioptions-=T

set nrformats=

set visualbell
set showmatch matchtime=3

set complete-=i

set fillchars+=vert:\ 

set linespace=2

set nowrap

set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set smartindent
set autoindent

set nobackup
set backupdir=~/.vim/backup,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/backup,~/.tmp,~/tmp,/var/tmp,/tmp

set wildmenu
set wildmode=longest,full
set wildignore+=*/tmp/*,*/public/system/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif

set incsearch
set hlsearch

set ignorecase
set smartcase
set noesckeys

set nocompatible

set timeoutlen=1000 ttimeoutlen=0
set laststatus=2

set autoread

set backspace=start,indent,eol
set listchars=tab:>-,trail:·,eol:$

set shortmess=atI

let mapleader = "\<Space>"

" Configure :grep to use Ag (The Silver Searcher)
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ -U

    " Aso configure a custom Ag command using :grep
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif

""""""""""""""""""""""""""""
" PLUGINS CONFIG / MAPPING "
""""""""""""""""""""""""""""

" Disable syntastic by default
autocmd VimEnter * SyntasticToggleMode

"""" Syntastic """"

let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_ignore_files = ['scss$']

"""" Splitjoin """"

let g:splitjoin_ruby_hanging_args=0

"""""" gitv """"""""

let g:Gitv_WipeAllOnClose = 1

""""""" CtrlP """"""""

if executable('ag')
  let g:ctrlp_use_caching = 1
  let g:ctrlp_user_command = 'ag %s -U -l -g "(rb|erb|html|js|yml|php|py|ex|java|groovy|gsp|coffee|less|css|txt|md|markdown|rake|sh|haml)$"'
endif

let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

let g:ctrlp_map = '<C-p>'
nnoremap <Leader>b :CtrlPBuffer<CR>

""""""" YankRing """""

let g:yankring_history_dir = '/tmp'

""""""" Vroom """"""""

let g:vroom_test_unit_command="testrbl -Itest:lib -rminitest/autorun"
let g:vroom_use_dispatch=0
map <Leader>T :Dispatch rake test<CR>
map <Leader>Ta :Dispatch rake test:all<CR>

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

let g:UltiSnipsEditSplit='horizontal'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<D-0>"

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

""""""""" Save and run files """""""""

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :qall<CR>

" Save and run last shell command
nnoremap @! :w<CR>:!!<CR>

""""""""""" Copy and paste """""""""""""

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

""""""""" Shortcuts to edit files """""""""""

map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

""""""""""" Tweaks """"""""""""""

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" Restore cursor position
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" Do not remember position of git commit buffer
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Pandoc format with gq command
let pandoc_pipeline  = "pandoc --from=html --to=markdown"
let pandoc_pipeline .= " | pandoc --from=markdown --to=html"
autocmd FileType html let &formatprg=pandoc_pipeline

autocmd BufReadPost fugitive://* set bufhidden=delete

""""""""""" History navigation """""""""""""

let g:toggle_list_no_mappings = 1

nnoremap <silent> <Leader>z :call ToggleQuickfixList()<CR>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

""""""""""" Grep """"""""""""""

" Grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

"""""""""" New commands """""""""""

" Preserves the cursor position when yanking in visual mode
vnoremap gy ygv<Esc>

" Delete function (C, PHP, etc)
nnoremap <silent> <Leader>df dV]M

" Show hidden characters
nmap <silent> <Leader>c :set nolist!<CR>

" Disable hlsearch
nnoremap <silent><Leader><Space> :nohlsearch<CR>

""""""""" New behavior """"""""""

" Auto close brackets on return (essential)
inoremap {<CR> {<CR>}<Esc>O

" Disable auto commenting on all file types
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

""""""""""""" Tags """""""""""""""

set tags=tags;/

" Open tag in vertical split
map <C-w>[ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Open tag at cursor using ptselect
nnoremap <C-w>{ <Esc>:exe "ptselect " . expand("<cword>")<Esc>

" Open tag in new tab
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"""""""""" Abbreviations """""""""""

cab vsb vert sb
cab W w
cab WQ wq
cab Cd cd
cab CD cd
cab E e
cab B b
cab Sb sb
cab Sp sp
cab Stag stag

"""""""""" Ruby """"""""""""

" Auto start Rails server when on a Rails project
"autocmd User Startified
"\ if filereadable(getcwd() . '/Gemfile') |
"\   Rserver! |
"\ endif

" Find ruby files with gf command
augroup rubypath
autocmd!
autocmd FileType ruby setlocal suffixesadd+=.rb
augroup END

" Highlight in red when column width is more than 80 chars
augroup highlight-code-char-max-width
autocmd FileType ruby highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd FileType ruby match OverLength /\%81v.\+/
augroup END

""""""""" Groovy """"""""""""

autocmd Filetype groovy setlocal noexpandtab

"""""""""" JSON """"""""""""

" Syntax highlighting for json files
autocmd BufRead,BufNewFile *.json set filetype=javascript

"""""""""""""
" FUNCTIONS "
"""""""""""""

" Populates arg list with quick fix list
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Reload snippets
function! ReloadSnips()
    py UltiSnips_Manager.reset()
endfunction

" List all shortcuts mapped with leader keys
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

"""""""""""""""""""""""""""""""""""""""
" AUTOLOAD LOCAL CONFIG (OUTSIDE VCS) "
"""""""""""""""""""""""""""""""""""""""

" Include local vim config, if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" Load per OS configuration - detects the OS
let os = substitute(system('uname'), "\n", "", "")

if os == "Linux"
    source ~/.vim/vimrc.linux
elseif os == "Darwin"
    source ~/.vim/vimrc.darwin
else
    source ~/.vim/vimrc.windows
endif
