"""""""""""""""""""""
" VIM CONFIGURATION "
""""""""""""""""""""" 

" Pathogen config - Loads all modularized bundles (plugins, etc), and rebuilds help tags
" Always place these lines above all others in .vimrc
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Unset compatibility mode with original vi
set nocompatible

" Checks if gui is running to fix a NERDTree bug which
" makes it loose syntax highlighting in some color schemes,
" after opening a file. Macvim turns on syntax highlighting 
" automatically, so there's only need to run this in the shell vim
if !has("gui_running")
    syntax on
endif

" Enables plugins and indenting per-filetype
filetype plugin on

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
set scrolloff=8
"set sidescrolloff=7
"set sidescroll=1

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
"set nocindent

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

" Default file format
set fileformat=unix

set nowrap

" Status line configuration: shows git current branch, file encoding, etc
if has("statusline")
    set statusline=%<%f\ \ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

" Sets leader key (specific for user mappings, to avoid conflicting with vim's defaults)
let mapleader = ","
let g:mapleader = ","

""""""""""""""
"  MAPPINGS  "
""""""""""""""

" NERDTree shortcut
nnoremap <D-1> :NERDTree %<CR> :echo 'Current file directory...'<CR>
nnoremap <C-n> :NERDTreeToggle<CR> :echo 'Toggle NERDTree'<CR>

" Taglist shortcut
nnoremap <C-p> :TlistToggle<CR>

" Resets snippets (UltiSnips)
nnoremap <Leader>n :w<CR>:py UltiSnips_Manager.reset()<CR>

" Command T shortcut (cmd-T is already working for "open new tab")
noremap <D-r> :CommandT<CR>

" Command T shortcut (force flush)
noremap <D-R> :CommandTFlush<CR> :CommandT<CR>

" Mapping to disable hlsearch
nnoremap <C-l> :nohls<CR><C-L>
inoremap <C-l> <C-O>:nohls<CR>

" Tabularize mappings
if exists(":Tabularize")
  nmap <Leader>a = :Tabularize / = <CR>
  vmap <Leader>a = :Tabularize / = <CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a> :Tabularize /=><CR>
  vmap <Leader>a> :Tabularize /=><CR>
endif

" Auto close pairs simple mappings - DEPRECATED
" As UltiSnips doesn't allow these mappings in the placeholders,
" now the pairs itself are snippets. Type (<Tab> to close the pair and insert
" the cursor in the middle. With an added bonus of more control.
"inoremap ( ()<Left>
inoremap <expr> ' g:InsertPair("'")
inoremap <expr> " g:InsertPair('"')

" These mappings are still useful for smart out-of-pair behaviour, or to
" quickly delete pairs, by deleting only one of them
inoremap {<CR> {<CR>}<Esc>O
"inoremap <expr> ) strpart(getline('.'), col('.') - 1, 1) == ")" ? "\<Right>" : ")"
"inoremap <expr> } strpart(getline('.'), col('.') - 1, 1) == "}" ? "\<Right>" : "}"
"inoremap <expr> ] strpart(getline('.'), col('.') - 1, 1) == "]" ? "\<Right>" : "]"
"inoremap <expr> <backspace> g:ClosePairs()

" Centers content when navigating search results
"nmap n nzz
"nmap N Nzz

" Fast saving - DEPRECATED in favour of easymotion plugin
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

" Mappings to add ; at the end of lines
nnoremap <Leader>; :call <SID>AppendEOL(';')<CR>
nnoremap <S-CR> :call <SID>AppendEOL(';')<CR>
nnoremap <Leader>, :call <SID>AppendEOL(',')<CR>
inoremap <D-S-CR> <Esc> :call <SID>AppendEOL(';')<CR>o
inoremap <S-CR> <Esc> :call <SID>AppendEOL(';')<CR>

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

" Map historic navigation in home arrows to something more useful (get the latest command beginning with ...)
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>


""""""""""""""""""""""""
" PLUGIN CONFIGURATION "
""""""""""""""""""""""""


" Taglist
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

" UltiSnips
let g:UltiSnipsEditSplit='horizontal'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<D-0>"

" NERDTree
let g:NERDTreeWinPos = "right"

" Command-T
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1


"""""""""""""""""""""""""""""
" CUSTOM UTILITY FUNCTIONS "
""""""""""""""""""""""""""""


" Inserts a closing pair when typing a character
" Map your auto close stuff with 'char' parameter
function! g:InsertPair(char)
   let next_char = strpart(getline('.'), col('.') - 1, 1)
   let char_is_rightside = next_char == a:char
   if char_is_rightside
       return "\<Right>"
   else
       "return a:char . a:char . "\<Left>"
       return a:char
   endif
endfunction

" Automatically delete pairs
function! g:ClosePairs()
    let pair = strpart(getline('.'), col('.') - 2, 2)
    let pair_is_closed = pair == '()' || pair == "''" || pair == '""' || pair == '[]'
    if pair_is_closed
        return "\<Right>\<BS>\<BS>"
    else
        return "\<BS>"
    endif
endfunction

" Appends a character at the end of the line
function! s:AppendEOL(param)
    if getline('.') !~ a:param.'$'
        let original_cursor_position = getpos('.')
        exec("s/$/".a:param."/")
        call setpos('.', original_cursor_position)
    endif
endfunction

" Drag tabs to the left... pick up a mapping to use it
function! s:DragTabLeft()
    let n = tabpagenr()
    let move = n - 2
    execute 'tabmove' (n == 0 ? tabpagenr('$') : move)
    let &showtabline = &showtabline
endfunction

" Drag tabs to the right... pick up a mapping to use it
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

function! DisableIndent()
    set autoindent&
    set cindent&
    set smartindent&
    set indentexpr&
endfunction

filetype plugin indent on
au filetype php call DisableIndent()


"""""""""""""""""
" ABBREVIATIONS "
""""""""""""""""

" Avoid typing errors in the command line
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

" Expand to current path
cabbr <expr> %% expand('%:p:h')


"""""""""""""""""
" AUTO COMMANDS "
"""""""""""""""""

" Reloads vim config files and apply changes automatically
autocmd! bufwritepost .gvimrc source %
autocmd! bufwritepost .vimrc source %

" Autosave on focus lost
autocmd! FocusLost * silent! wa

" Tag preview fix, when using folds and/or fold plugins. The tag preview
" always opens unfolded, regardless of current configuration
autocmd BufWinEnter * if &previewwindow | setlocal foldlevel=999 | endif

" Some files and directories to ignore. See :help wildignore. Set this in your .vimrc.local file
" set wildignore+=*.jpg,*.gif,*.png,application/logs/**,assets/imgs/**,application/cache/**

" Can't remember the reason why this is here. Will discover later.
autocmd QuickFixCmdPre make w

" NERD Tree specific
"autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Setup vim when opening
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LOCAL CONFIGURATION (LOAD CUSTOM CONFIG FILE OUT OF SCM) "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
function! Bufnames(A, L, P) 
    redir => bufnames 
    silent ls 
    redir END 
    let list = [] 
    for name in split(bufnames, "\n") 
        let buf = fnamemodify(split(name, '"')[-2], ":t") 
        if match(buf, "No Name") == -1 
            call add(list, buf) 
        endif 
    endfor 
    return filter(sort(list), 'v:val =~ "^".a:A') 
endfunction 
