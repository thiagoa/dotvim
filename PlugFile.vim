call plug#begin('~/.vim/plugged')

"--------------

"*******
" MISC *
"*******

Plug 'machakann/vim-highlightedyank'

"*************
" NAVIGATION *
"*************

Plug 'mhinz/vim-startify'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'ton/vim-bufsurf'
Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-rsi'

"********************
" TEXT MANIPULATION *
"********************

Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

"*****************
" FILE UTILITIES *
"*****************

Plug 'danro/rename.vim'
Plug 'DataWraith/auto_mkdir'
Plug 'tpope/vim-vinegar'

"***************
" TEXT OBJECTS *
"***************

Plug 'wellle/targets.vim'
Plug 'austintaylor/vim-indentobject'
Plug 'vim-scripts/argtextobj.vim'
Plug 'kana/vim-textobj-user'

"*********
" THEMES *
"*********

Plug 'rakr/vim-one'
Plug 'dracula/vim'
Plug 'MaxSt/FlatColor'
Plug 'jacoborus/tender.vim'
Plug 'mhinz/vim-janah'

"******
" CVS *
"******

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

"***********
" SNIPPETS *
"***********

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"**************
" PROGRAMMING *
"**************

Plug 'tpope/vim-sleuth'
Plug 'w0rp/ale'
Plug 'roxma/nvim-completion-manager'
Plug 'scrooloose/nerdcommenter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-endwise'
Plug 'rizzatti/funcoo.vim'

"*********
" ELIXIR *
"*********

Plug 'slashmili/alchemist.vim'

"***************
" RUBY / RAILS *
"***************

Plug 'janko-m/vim-test'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'sunaku/vim-ruby-minitest'
Plug 'nelstrom/vim-textobj-rubyblock'

"*********
" PYTHON *
"*********

Plug 'hdima/python-syntax'
Plug 'klen/python-mode'

"******************
" OTHER LANGUAGES *
"******************

Plug 'sheerun/vim-polyglot'

"--------------

call plug#end()
