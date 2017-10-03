" ------------------------------
" | Thiago's vim configuration |
" ------------------------------
"
" No comments, let's make this clean. When in doubt, :help or Google!

source ~/.vim/PlugFile.vim

syntax on

filetype plugin on
filetype plugin indent on

set hidden
set history=1000
set shell=/bin/zsh
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
set nowritebackup
set noswapfile
set nowildmenu
set wildmode=longest,full
set wildignore+=*/tmp/*,*/public/system/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif
set incsearch
set hlsearch
set ignorecase
set smartcase
set nocompatible
set timeoutlen=1000 ttimeoutlen=0
set laststatus=2
set autoread
set backspace=start,indent,eol
set listchars=tab:>-,trail:·,eol:$
set shortmess=atI
set splitbelow

source ~/.vim/config/mappings.vim
source ~/.vim/config/plugin.vim
source ~/.vim/config/functions.vim
source ~/.vim/config/autocommands.vim
source ~/.vim/config/abbreviations.vim
source ~/.vim/config/local.vim
