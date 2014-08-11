"""""""""""""""""""""
" VIM CONFIGURATION "
"""""""""""""""""""""

" Unset compatibility mode with original vi
set nocompatible

" Pathogen config - These lines must be on top
call pathogen#incubate()
call pathogen#helptags()
execute pathogen#infect()

" Set syntax on
syntax on

" Enables plugins and indenting per-filetype
filetype plugin on
filetype plugin indent on

" Disables autocomplete for files referenced inside the current buffer
set complete-=i

" Command history limit
set history=1000

" Encodings in preference order
set fileencodings=utf-8,iso-8859-1

" Turns off needless toolbar on gvim/mvim
set guioptions-=T

" Turns on line numbering
set number

" Consider numbers as decimal
set nrformats=

" Disable annoying beep and enable visual bell
set visualbell

" Lights up opposite brackets
set showmatch matchtime=3

" Long line indicator
set showbreak=...  

" Remove dashed lines from split window boundaries
set fillchars+=vert:\ 

" Line spacing
set linespace=2

" Tabs config
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Indent config
set smartindent
set autoindent

" Disables backups to prevent clutter
set nobackup

" Autocomplete config
set wildmenu
set wildmode=longest,full

" Ignored files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Search config
set incsearch
set hlsearch
set ignorecase
set smartcase

" Faster Esc in insert mode
set noesckeys

" Mapping delays config
set timeoutlen=1000 ttimeoutlen=0

" Always show status bar
set laststatus=2

" Updates buffer when modified outside vim
set autoread

" Hide modified buffers when switching - doesn't warn for saving
set hidden

" Backspace key configuration in insert mode (makes it act as expected)
set backspace=start,indent,eol

" Sets directories for backups
set backupdir=~/.vim/backup,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/backup,~/.tmp,~/tmp,/var/tmp,/tmp

" Show non-visible characters (tabs, spaces, etc)
set listchars=tab:>-,trail:·,eol:$

" Messages configuration
set shortmess=atI

" Do not wrap long lines
set nowrap

" Where to look for tag files
set tags=tags;/

"""""""""
"  GIT  "
"""""""""

" Select lines and git blame
vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

""""""""""""""""""
" PLUGINS CONFIG "
""""""""""""""""""
let g:vroom_test_unit_command="testrbl -Itest:lib -rminitest/autorun"
map <Leader>T :Rake test<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1

" Tagbar
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

" Tabularize
nmap <Leader>a :Tabularize /=<CR>
nmap <Leader>a? :Tabularize /?<CR>
vmap <Leader>a = :Tabularize /= <CR>
nmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a; :Tabularize /:\zs<CR>
vmap <Leader>a; :Tabularize /:\zs<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>

" UltiSnips
let g:UltiSnipsEditSplit='horizontal'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<D-0>"

" Search Dash
map <leader>d :call SearchDash()<CR>

""""""""""""""""""""""
"  GENERAL MAPPINGS  "
""""""""""""""""""""""

" Save and run last shell command
nnoremap @! :w<CR>:!!<CR>

let g:tmux_navigator_no_mappings = 1

nnoremap <Esc>k :TmuxNavigateUp<cr>
nnoremap <Esc>j :TmuxNavigateDown<cr>
nnoremap <Esc>l :TmuxNavigateRight<cr>
nnoremap <Esc>h :TmuxNavigateLeft<cr>

nnoremap <Leader>w :w<CR>

" Preserves the cursor position when yanking in visual mode
vnoremap gy ygv<Esc>

" Disable hlsearch
nnoremap <silent><Leader><Space> :nohlsearch<CR>

" Auto close brackets
inoremap {<CR> {<CR>}<Esc>O

" Place cursor at the middle of a line
nnoremap <expr> gM (strlen(getline('.')) / 2) . '<bar>'

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" Show hidden characters
nmap <silent> <Leader>c :set nolist!<CR>

" Delete function (C, PHP, etc)
nnoremap <silent> <Leader>df dV]M

" History navigation with C-p and C-n
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"""""""""""""""""""""""
" OPEN FILE SHORTCUTS "
"""""""""""""""""""""""

" Edit files in the same directory
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>f :!mv <C-R>=expand("%")  <CR>

""""""""
" TAGS "
""""""""

" Open tag at cursor using ptselect
nnoremap <C-w>{ <Esc>:exe "ptselect " . expand("<cword>")<Esc>

" Open tag in new tab
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"""""""""""""""""
" ABBREVIATIONS "
""""""""""""""""

" Avoid typos on ex command line
cab W w
cab WQ wq
cab Cd cd
cab CD cd
cab E e
cab B b
cab Sb sb
cab Sp sp
cab Stag stag

"""""""""""""""""
" AUTO COMMANDS "
"""""""""""""""""

if has("autocmd")
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " Strip whitespaces on certain filetypes
  autocmd BufWritePre *.py,*.rb,*.erb,*.xml,*.js,*.php,*.css,*.scss,*.haml :call <SID>StripTrailingWhitespaces()

  " Pandoc format with gq command
  let pandoc_pipeline  = "pandoc --from=html --to=markdown"
  let pandoc_pipeline .= " | pandoc --from=markdown --to=html"
  autocmd FileType html let &formatprg=pandoc_pipeline
  
  " Syntax highlighting for json files
  autocmd BufRead,BufNewFile *.json set filetype=javascript

  " Find ruby files with gf command
  augroup rubypath
    autocmd!
    autocmd FileType ruby setlocal suffixesadd+=.rb
  augroup END
endif

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

" Reload snippets. Call with ":call ReloadSnips()".
function! ReloadSnips()
    py UltiSnips_Manager.reset()
endfunction

" Search Dash for word under cursor
function! SearchDash()
  let s:browser = "/usr/bin/open"
  let s:wordUnderCursor = expand("<cword>")
  let s:url = "dash://".s:wordUnderCursor
  let s:cmd ="silent ! " . s:browser . " " . s:url
  execute s:cmd
  redraw!
endfunction

" Strip trailing whitespaces
function! <SID>StripTrailingWhitespaces()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Save with sudo (no mapping; use "call g:save()")
function! g:save()
  %!sudo tee > /dev/null %
endfunction

"""""""""""""""""""""""""""""""""""""""
" AUTOLOAD LOCAL CONFIG (OUTSIDE VCS) "
"""""""""""""""""""""""""""""""""""""""

" Include local vim config, if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

let os = substitute(system('uname'), "\n", "", "")

if os == "Linux"
    source ~/.vim/vimrc.linux
elseif os == "Darwin"
    source ~/.vim/vimrc.darwin
else
    source ~/.vim/vimrc.windows
endif

" Change cursor shape to an underscore  when in insert mode
let &t_SI = "\<Esc>]50;CursorShape=2\x7"

" Change back to a block in normal mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set grepprg=ag\ --nogroup\ --nocolor
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

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

map <C-w>[ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
