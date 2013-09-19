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

" Always consider numbers as decimal
set nrformats=

" Set visual bell instead of beeping
set visualbell

" Lights up the opposite bracket for easy finding.
set showmatch matchtime=3

" These characters indicate the content is not enough for showing in one line
set showbreak=...  

" Number of pixel lines inserted between characters
set linespace=2

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

" Faster Esc in insert mode
set noesckeys

" Mapping delays configuration
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

" Sets to Show non-visible characters (tabs, spaces, etc)
set listchars=tab:>-,trail:�,eol:$

" Messages configuration
set shortmess=atI

" Do not wrap long lines by default
set nowrap

" Where to look for tag files
set tags=tags;/

" Status line configuration: shows git current branch, file encoding, etc
if has("statusline")
    set statusline=%<%f\ \ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

" Sets leader key (specific for user mappings, to avoid conflicting with vim's defaults)
let g:mapleader = ","

" Always current directory with CtrlP (no guesses)
let g:ctrlp_working_path_mode = '0'

""""""""""""""
"  MAPPINGS  "
""""""""""""""

" Ben Orenstein's mappings to edit files in the same directory
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

" Ben Orenstein's mapping to select somes lines and see the blame log
vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" This mapping preserves the cursor position when yanking in visual mode
vnoremap gy ygv<Esc>

" Check syntax shortcut
map <silent> <Leader>o :AsyncMake<CR>
map <silent> <Leader>z :cclose<CR>

" NERDTree shortcut
nnoremap <C-n> :NERDTreeToggle<CR> :echo 'Toggle NERDTree'<CR>

" Taglist shortcut
nnoremap <Leader>t :TlistToggle<CR>

" Gundo shortcut
nnoremap <Leader>u :GundoToggle<CR>

" Resets snippets (UltiSnips)
nnoremap <silent> <Leader>r :w<CR>:py UltiSnips_Manager.reset()<CR>

" Mapping to disable hlsearch
nnoremap <silent> <Leader>/ :nohlsearch<CR>
inoremap <C-l> <C-O>:nohls<CR>

" No backwards Ex mode
nnoremap Q <nop>

" Tabularize mappings
nmap <Leader>a :Tabularize /=<CR>
nmap <Leader>a? :Tabularize /?<CR>
vmap <Leader>a = :Tabularize /= <CR>
nmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a; :Tabularize /:\zs<CR>
vmap <Leader>a; :Tabularize /:\zs<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>

" Automatically close brackets and place cursor in the middle with {<CR>
inoremap {<CR> {<CR>}<Esc>O

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

" Uppercase word in insert mode
inoremap <C-k> <esc>mzgUiw`za

map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> 10gt

inoremap <D-1> <Esc>1gt
inoremap <D-2> <Esc>2gt
inoremap <D-3> <Esc>3gt
inoremap <D-4> <Esc>4gt
inoremap <D-5> <Esc>5gt
inoremap <D-6> <Esc>6gt
inoremap <D-7> <Esc>7gt
inoremap <D-8> <Esc>8gt
inoremap <D-9> <Esc>9gt
inoremap <D-0> <Esc>10gt

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
let g:nerdtree_tabs_smart_startup_focus = 0

" Command-T
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

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

" Speeds up vimgrep command
cab vimgrep noautocmd vimgrep

" Expand to current directory
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

" Can't remember the reason why this is here. Will discover later.
autocmd QuickFixCmdPre make w

" NERD Tree specific
"autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Setup vim when opening
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))

" Start vim with focus in the text buffer instead of in NERDTree
autocmd VimEnter * wincmd h

" Restore cursor position
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" Syntax highlighting for json files, not available by default
autocmd BufRead,BufNewFile *.json set filetype=javascript

"""""""""""""""""""""""""""""
" CUSTOM UTILITY FUNCTIONS "
""""""""""""""""""""""""""""

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
        NERDTree
        return
    endif
    if explicitDirectory
        wincmd p
    endif
endfunction

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
" Tim Pope's cucumbertables gist
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction


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

" Search Dash for word under cursor
function! SearchDash()
  let s:browser = "/usr/bin/open"
  let s:wordUnderCursor = expand("<cword>")
  let s:url = "dash://".s:wordUnderCursor
  let s:cmd ="silent ! " . s:browser . " " . s:url
  execute s:cmd
  redraw!
endfunction
map <leader>d :call SearchDash()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""
" LOCAL CONFIGURATION BASED ON OPERATING SYSTEM "
"""""""""""""""""""""""""""""""""""""""""""""""""

let os = substitute(system('uname'), "\n", "", "")

if os == "Linux"
    source ~/.vim/vimrc.linux
elseif os == "Darwin"
    source ~/.vim/vimrc.darwin
else
    source ~/.vim/vimrc.windows
endif

augroup rubypath
  autocmd!
  autocmd FileType ruby setlocal suffixesadd+=.rb
augroup END
