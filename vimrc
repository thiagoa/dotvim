call pathogen#incubate()
call pathogen#helptags()
execute pathogen#infect()

syntax on
filetype plugin on
filetype plugin indent on

set hidden
set history=1000
set shell=/bin/bash
set nofoldenable
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
set nowildmenu
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

source ~/.vim/native_mappings.vim
source ~/.vim/plugin_config.vim
source ~/.vim/functions.vim
source ~/.vim/autocommands.vim
source ~/.vim/abbreviations.vim
