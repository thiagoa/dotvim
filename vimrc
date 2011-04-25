"""""""""""""""""""""
" VIM CONFIGURATION "
""""""""""""""""""""" 

" Pathogen configuration - Loads all modularized bundles (plugins, etc), and rebuilds help tags
" Always place these lines above all others in .vimrc
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Unset compatibility mode with original vi
set nocompatible

" Enables syntax highlighting
syntax on

" Enables plugins and indenting per-filetype
filetype plugin indent on

" Disables autocomplete for files referenced inside the current buffer
set complete-=i

" Command history limit
set history=1000

" Encodings in preference order
set fileencodings=utf-8,iso-8859-1

" Turn off needless toolbar on gvim/mvim
set guioptions-=T

" Turns on line numbers in every file
set number

" Options for context referencing
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" Set visual bell instead of beeping
set visualbell

" Lights up the opposite bracket for easy finding. 
set showmatch matchtime=3

" These characters indicate the content is not enough for showing in one line
set showbreak=...

" Number of pixel lines inserted between characters
set linespace=4

" Default tabs configuration
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Indenting configuration
set smartindent
set autoindent
set nocindent

" Disables backup while file is being written
set nobackup

" Autocomplete configuration
set wildmenu
set wildmode=longest,full

" Search configuration
set incsearch
set hlsearch
set ignorecase
set smartcase

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

" Sets to Show non-visible characters (tabs, spaces, etc)
set listchars=tab:>-,trail:·,eol:$

" Messages configuration
set shortmess=atI

" Status line configuration: shows git current branch, file encoding, etc
if has("statusline")
    set statusline=%<%f\ \ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
    set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
endif

" Sets leader key (specific for user mappings, to avoid conflicting with vim's defaults)
let mapleader = ","
let g:mapleader = ","

""""""""""""""
"  MAPPINGS  "
""""""""""""""

" NERDTree shortcut
nnoremap <C-n> :NERDTreeToggle<CR>

" Taglist shortcut
nnoremap <C-p> :TlistToggle<CR>

" Resets snippets (UltiSnips)
nnoremap <Leader>n :py UltiSnips_Manager.reset()<CR>

" Command T shortcut (cmd-T is already working for "open new tab")
noremap <D-r> :CommandT<CR>

" Mapping to disable hlsearch
nnoremap <C-l> :nohls<CR><C-L>
inoremap <C-l> <C-O>:nohls<CR>

" Centers content when navigating search results
nmap n nzz
nmap N Nzz

" Fast saving
"nmap <Leader>w :w!<cr>

" Fast quit
nnoremap <Leader>q :wq!<cr>

" Goes to middle of the line, considering its contents. Native command "gm" doesn't consider line contents
nnoremap <expr> gM (strlen(getline('.')) / 2) . '<bar>'

" Counterpart of <C-w> } to open tag with ptselect (select from list)
nnoremap <C-w>{ <Esc>:exe "ptselect " . expand("<cword>")<Esc>

" Even faster :tag and :stag commands
nnoremap <D-d> :tag 
nnoremap <D-e> :stag 

" Open tag in new tab
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Map Command-# to switch tabs
noremap  <D-0> 0gt
inoremap <D-0> <Esc>0gt
noremap  <D-1> 1gt
inoremap <D-1> <Esc>1gt
noremap  <D-2> 2gt
inoremap <D-2> <Esc>2gt
noremap  <D-3> 3gt
inoremap <D-3> <Esc>3gt
noremap  <D-4> 4gt
inoremap <D-4> <Esc>4gt
noremap  <D-5> 5gt
inoremap <D-5> <Esc>5gt
noremap  <D-6> 6gt
inoremap <D-6> <Esc>6gt
noremap  <D-7> 7gt
inoremap <D-7> <Esc>7gt
noremap  <D-8> 8gt
inoremap <D-8> <Esc>8gt
noremap  <D-9> 9gt
inoremap <D-9> <Esc>9gt

" Mappings to add ; at the end of lines
nnoremap <Leader>; :call <SID>appendEOL(';')<CR>
nnoremap <S-CR> :call <SID>appendEOL(';')<CR>
nnoremap <Leader>, :call <SID>appendEOL(',')<CR>
nnoremap \; :call <SID>appendEOL(';')<CR>
nnoremap \, :call <SID>appendEOL(',')<CR>
inoremap <D-S-CR> <Esc> :call <SID>appendEOL(';')<CR>o
inoremap <S-CR> <Esc> :call <SID>appendEOL(';')<CR>

" Mapping to quickly execute make command
nmap <Leader>m :make<CR>

" Opens lines above of below in insert mode
inoremap <D-CR> <C-O>o
inoremap <D-S-CR> <C-O>O

" Opens a new line in insert mode

" Movement in insert mode without leaving home keys
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-h> <Left>

" Moves lines up and above in command or visual mode
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" Keeps visual selection when indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" Shows hidden characters
nmap <silent> <leader>s :set nolist!<CR>

" Shortcuts to create new split buffers
nmap <Leader>svh :topleft  vnew<CR>
nmap <Leader>svl :botright vnew<CR>
nmap <Leader>sh  :topleft  new<CR>
nmap <Leader>sl  :botright new<CR>
nmap <Leader>svk :leftabove  vnew<CR>
nmap <Leader>svj :rightbelow vnew<CR>
nmap <Leader>sk  :leftabove  new<CR>
nmap <Leader>sj  :rightbelow new<CR>

" Shortcut to remove blocks of code (e.g. delete function)
nnoremap <silent> <Leader>df dV]M

""""""""""""""""""""""""
" PLUGIN CONFIGURATION "
""""""""""""""""""""""""

" Taglist
let Tlist_Use_Horiz_Window=0
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Inc_Winwidth = 0
let Tlist_Close_On_Select = 1
let Tlist_Process_File_Always = 1
let Tlist_Sql_Settings = 'sql;P:package;t:table'
let Tlist_Ant_Settings = 'ant;p:Project;r:Property;t:Target'
let tlist_php_settings = 'php;c:class;d:constant;f:function'

" UltiSnips
let g:UltiSnipsEditSplit='horizontal'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<Leader>l"

" Command-T
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

" PDV
abbr atas @author Thiago A. Silva

"""""""""""""
" FUNCTIONS "
"""""""""""""

" Adds a character in the end of the line
function! s:appendEOL(param)
    if getline('.') !~ a:param.'$'
        let original_cursor_position = getpos('.')
        exec("s/$/".a:param."/")
        call setpos('.', original_cursor_position)
    endif
endfunction

" Função que leva tabs para esquerda 
function! s:DragTabLeft()
    let n = tabpagenr()
    let move = n - 2
    execute 'tabmove' (n == 0 ? tabpagenr('$') : move)
    let &showtabline = &showtabline
endfunction

" Função que leva tabs para a direita
function! s:DragTabRight()
    let n = tabpagenr()
    execute 'tabmove' (n == tabpagenr('$') ? 0 : n)
    let &showtabline = &showtabline
endfunction

" NERDTree utility function
function! s:UpdateNERDTree(...)
    let stay = 0
    if(exists("a:1"))
        let stay = a:1
    end
    if exists("t:NERDTreeBufName")
        let nr = bufwinnr(t:NERDTreeBufName)
        if nr != -1
            exe nr . "wincmd w"
            exe substitute(mapcheck("R"), "<CR>", "", "")
            if !stay
                wincmd p
            end
        endif
    endif
    if exists(":CommandTFlush") == 2
        CommandTFlush
    endif
endfunction

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
            if winnr("$") == 1
                q
            endif
        endif
    endif
endfunction

" If the parameter is a directory, cd into it (ex: mvim ~/Sites)
function! s:CdIfDirectory(directory)
    let explicitDirectory = isdirectory(a:directory)
    let directory = explicitDirectory || empty(a:directory)
    if explicitDirectory
        exe "cd " . fnameescape(a:directory)
    endif
    " Allows reading from stdin
    " ex: git diff | mvim -R -
    if strlen(a:directory) == 0 
        return
    endif
    if directory
        NERDTree
        wincmd p
        bd
    endif
    if explicitDirectory
        wincmd p
    endif
endfunction

"""""""""""""""""
" ABBREVIATIONS "
""""""""""""""""

" Avoids typing errors in the command line
cab W w
cab WQ wq
cab Cd cd
cab CD cd
cab E e
cab B b
cab Sb sb
cab Sp sp
cab Stag stag

" Speeds up vimgrep
cab vimgrep noautocmd vimgrep

cabbr <expr> %% expand('%:p:h')

"""""""""""""""""
" AUTO COMMANDS "
"""""""""""""""""

" Reloads vim config files and apply changes automatically
autocmd! bufwritepost .gvimrc source %
autocmd! bufwritepost .vimrc source %

" Tag preview fix, when using folds and/or fold plugins. The tag preview
" always opens unfolded, regardless of current configuration
autocmd BufWinEnter * if &previewwindow | setlocal foldlevel=999 | endif

" Some files and directories to ignore. See :help wildignore. Set this in your .vimrc.local file
" set wildignore+=*.jpg,*.gif,*.png,application/logs/**,assets/imgs/**,application/cache/**

" Can't remember the reason why this is here. Will discover later.
autocmd QuickFixCmdPre make w

" NERD Tree specific
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Setup vim when opening
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))

""""""""""""""""""""""""""""""""""""
" LOCAL CONFIGURATION (OUT OF SCM) "
""""""""""""""""""""""""""""""""""""

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
