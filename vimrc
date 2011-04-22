"""""""""""""""""""""""""""
" CONFIGURAÇÃO DO EDITOR  "
""""""""""""""""""""""""""" 

" Configuração do Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Modo de não compatibilidade com vi original
set nocompatible

" Ativa sintaxe colorida, identação de acordo com tipo 
" de arquivo e plugins de acordo com tipo de arquivo
"syntax on
filetype plugin indent on

" Desativa autocomplete em arquivos referenciados dentro do buffer
set complete-=i

" Histórico de comandos
set history=1000

" Encodings padrão em ordem de preferência
set fileencodings=utf-8,iso-8859-1

" Turn off needless toolbar on gvim/mvim
set guioptions-=T

" Numeração de linhas
set number

" Sempre mostra 3 linhas de contexto acima ou abaixo
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" Acende o outro lado do par {} para fácil identificação
set showmatch matchtime=3

" Mostra comandos incompletos embaixo
set showcmd

" Mostra o modo atual (INSERT, REPLACE, etc) no status
set showmode

set showbreak=...

" Espaço entre as linhas
set linespace=4

" Tabs
set expandtab
set tabstop=4
set softtabstop=4
set smarttab
set shiftwidth=4

" Indentação
set smartindent
set autoindent
set cindent
set nobackup

" Autocomplete
set wildmenu
set wildmode=longest,full

" Busca
set incsearch
set hlsearch
set ignorecase
set smartcase

" Sempre mostrar barra de status
set laststatus=2

" Sempre mostra abas no topo, independente de ter só um arquivo
set showtabline=2

" Relê um arquivo quando modificado
set autoread

" Configura para mostrar arquivos ocultos
set hidden

" Configuração da tecla backspace para agir como esperado no modo de inserção
set backspace=start,indent,eol

" Centraliza todos os backups e temp files
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Mostra caracteres não visíveis
set listchars=tab:>-,trail:·,eol:$

" Configura mensagens de retorno. help shortmess
set shortmess=atI

" Coloca codificação dos arquivos no barra de status
"if has("statusline")
 "set statusline=%<%f\ \ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
 "set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
"endif

" Configuração da tecla leader para mapeamentos personalizados (padrão: \)
let mapleader = ","
let g:mapleader = ","

"""""""""""""""""
"  MAPEAMENTOS  "
"""""""""""""""""

" Usa <C-c> ao invés de <Esc> (mais perto das home rows)
nnoremap <C-c> <Esc><Esc>
vnoremap <C-c> <Esc><Esc>
onoremap <C-c> <Esc><Esc>
inoremap <C-c> <Esc><Esc>

" Mapeamentos do NERDTree
map <C-N> :NERDTree<CR>
map <C-n> :NERDTreeToggle<CR>

map <left> :bprevious<CR>
map <right> :bnext<CR>

" Mapeamento para desativar hlsearch
nnoremap <C-l> :nohls<CR><C-L>
inoremap <C-l> <C-O>:nohls<CR>

" Fast saving
"nmap <Leader>w :w!<cr>
nmap <Leader>q :wq!<cr>

" Mapeamento para ir na metade do comprimento da linha atual
nmap <expr> gM (strlen(getline('.')) / 2) . '<bar>'

" Abre marcadores em janelas separadas
nnoremap <C-w>{ <Esc>:exe "ptselect " . expand("<cword>")<Esc>
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Adiciona ; ou , no final das linhas facilmente
nmap <Leader>; :call <SID>appendEOL(';')<CR>
nmap <S-CR> :call <SID>appendEOL(';')<CR>
nmap <Leader>, :call <SID>appendEOL(',')<CR>
nmap \; :call <SID>appendEOL(';')<CR>
nmap \, :call <SID>appendEOL(',')<CR>
nmap <Leader>m :make<CR>
nmap <Leader>o 2s<C-v>[<C-v>'<Esc>ea<C-v>'<C-v>]<Esc>

" Abre linhas para cima ou para baixo em modo de inserção
"inoremap <C-D-o> <Esc>O
"inoremap <C-i>   <Esc>o

" Movimentos na nas teclas hjkl em modo de inserção (+ CTRL)
inoremap <D-j>   <Down>
inoremap <D-k>   <Up>
inoremap <D-l>   <Right>
inoremap <D-h>   <Left>

" Scroll mais rápido
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" Move linhas para cima e para baixo
nnoremap <C-S-j> :m+<CR>==
nnoremap <C-S-k> :m-2<CR>==
vnoremap <C-S-j> :m'>+<CR>gv=gv
vnoremap <C-S-k> :m-2<CR>gv=gv

vnoremap < <gv
vnoremap > >gv

nnoremap <D-d> :tag 
nnoremap <D-e> :stag 

inoremap <D-S-CR> <Esc> :call <SID>appendEOL(';')<CR>o
inoremap <S-CR> <Esc> :call <SID>appendEOL(';')<CR>

nmap <D-j> gj
nmap <D-h> gh
nmap <D-l> gl
nmap <D-k> gk

map <C-p> :TlistToggle<CR>

nmap <silent> <leader>s :set nolist!<CR>

" Aplica mapeamento para mover tabs
"nnoremap <silent> <A-S-h> :call <SID>DragLeft()<CR>
"nnoremap <silent> <A-S-l> :call <SID>DragRight()<CR>

" Recarrega snippets
map ,n :call ReloadSnippets(snippets_dir, &ft)<CR>

" Ao navegar pelos resultados da busca, centraliza-os na tela
nmap n nzz
nmap N Nzz

" Muda de janelas maximizando a nova
" map <C-J> <C-W>j<C-W>_
" map <C-K> <C-W>k<C-W>_

" window
nmap <Leader>svh  :topleft  vnew<CR>
nmap <Leader>svl  :botright vnew<CR>
nmap <Leader>sh   :topleft  new<CR>
nmap <Leader>sl   :botright new<CR>

" buffer
nmap <Leader>svk   :leftabove  vnew<CR>
nmap <Leader>svj   :rightbelow vnew<CR>
nmap <Leader>sk    :leftabove  new<CR>
nmap <Leader>sj    :rightbelow new<CR>

nnoremap <silent> <Leader>df dV]M

let g:buftabs_only_basename=0

"""""""""""""""""""""""""""
" CONFIGURAÇÃO DE PLUGINS "
"""""""""""""""""""""""""""

" Configuração da Taglist
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

"Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

" Configuração do plugin PHPDOC
abbr atas @author Thiago A. Silva
cabbr cpp !cp /Volumes/public_html/
cabbr <expr> %% expand('%:p:h')

" Variável autor do snipmate
let g:snips_author='Thiago A. Silva'

"""""""""""
" FUNÇÕES "
"""""""""""

" Função para adicionar um caracter no final da linha em modo de comando
function! s:appendEOL(param)
    if getline('.') !~ a:param.'$'
        let original_cursor_position = getpos('.')
        exec("s/$/".a:param."/")
        call setpos('.', original_cursor_position)
    endif
endfunction

" Função que leva tabs para esquerda 
function! s:DragLeft()
    let n = tabpagenr()
    let move = n - 2
    execute 'tabmove' (n == 0 ? tabpagenr('$') : move)
    let &showtabline = &showtabline
endfunction

" Função que leva tabs para a direita
function! s:DragRight()
    let n = tabpagenr()
    execute 'tabmove' (n == tabpagenr('$') ? 0 : n)
    let &showtabline = &showtabline
endfunction

" Recarrega snippets facilmente
fun! ReloadSnippets(snippets_dir, ft)
	call ResetSnippets()
	call GetSnippets(a:snippets_dir, a:ft)
endfun

"if has("gui_running")
  "" GUI is running or is about to start.
  "" Maximize gvim window.
  "set lines=999 columns=999
"else
  "" This is console Vim.
  "if exists("+lines")
    "set lines=50
  "endif
  "if exists("+columns")
    "set columns=100
  "endif
"endif

"""""""""""""""
" ABREVIAÇÕES "
"""""""""""""""

" Evita erros ao salvar
cab W w
cab WQ wq
cab Cd cd
cab CD cd
cab E e
cab Sb sb
cab Sp sp
cab Stag stag

" Abrevia para chamar o vimgrep sem executar os comandos 
" automáticos, ao abrir os arquivos achados
cab vimgrep noautocmd vimgrep
cab B b

""""""""""""""""""""""""
" COMANDOS AUTOMÁTICOS "
""""""""""""""""""""""""

" Recarrega arquivos do vim automaticamente após alteração
autocmd! bufwritepost .gvimrc source %
autocmd! bufwritepost .vimrc source %

" Ao salvar arquivos PHP verifica erros automaticamente
"autocmd! bufwritepost *.php make %

" Adiciona cabeçalho da mix em arquivos PHP
autocmd BufNewFile *.php source ~/.vim/ftplugin/phpmixhead.vim

" Quado visualizar o preview de um arquivo fonte, 
" abra-o com folds totalmente expandidos
autocmd BufWinEnter * if &previewwindow | setlocal foldlevel=999 | endif

"// Entra automaticamente na pasta de sites
set vb

map <D-r> :CommandT<CR>

set wildignore+=*.jpg,*.gif,*.png,application/logs/**,assets/imgs/**,application/cache/**
autocmd QuickFixCmdPre make w

inoremap <D-CR> <C-O>o

if has("gui_running")
    "color jellybeans
    "color blackdust
    "color kellys
    "color twilight
    "color koehler
    "color candy
    "color ps_color
    "color ir_black
    "color bclear
    "color wombat
    "color habilight
    "color mayansmoke
    "color clean
    "color bclear
    color mac_classic
    set gfn=Monaco:h12
endif
