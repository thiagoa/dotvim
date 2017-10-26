call plug#begin('~/.vim/plugged')

"*************
" NAVIGATION *
"*************

" Useful 'home screen' & last modified files
Plug 'mhinz/vim-startify'

" Fuzzy file finder
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Search for visual mode selection using * command
Plug 'nelstrom/vim-visual-star-search'

" Navigate buffers like in a web browser
Plug 'ton/vim-bufsurf'

" Extends % command to HTML and other languages
Plug 'vim-scripts/matchit.zip'

" Shortcuts to navigate between buffers, quick fix entries, etc
Plug 'tpope/vim-unimpaired'

" Readline mappings for insert mode (emacs-like)
Plug 'tpope/vim-rsi'

"********************
" TEXT MANIPULATION *
"********************

" Exchange pieces of text
Plug 'tommcdo/vim-exchange'

" Surround text with pairs of characters or HTML tags
Plug 'tpope/vim-surround'

" Extends the '.' command to repeat 'vim-surround' and 'vim-unimpaired' commands
Plug 'tpope/vim-repeat'

"*****************
" FILE UTILITIES *
"*****************

" Rename a buffer and its file at the same time (treats both operations as a
" cohesive unit). The 'delete' counterpart is in 'config/functions.vim'
Plug 'danro/rename.vim'

" Recursively and automatically create directories upon saving (mkdir -p)
Plug 'DataWraith/auto_mkdir'

" I use this instead of NERDTree for file navigation
Plug 'tpope/vim-vinegar'

"***************
" TEXT OBJECTS *
"***************

" Extend default text objects (and add new ones)
Plug 'wellle/targets.vim'

" Indentation-based text object
Plug 'austintaylor/vim-indentobject'

" Text objects for function arguments
Plug 'vim-scripts/argtextobj.vim'

" User-defined text objects. A dependency for other plugins
Plug 'kana/vim-textobj-user'

"*********
" THEMES *
"*********

Plug 'dracula/vim'
Plug 'jacoborus/tender.vim'
Plug 'mhinz/vim-janah'

"*******
" TMUX *
"*******

" Interact with Tmux
Plug 'benmills/vimux'

"******
" CVS *
"******

" The one vim plugin you might want to have
Plug 'tpope/vim-fugitive'

" Fugitive's github functionality
Plug 'tpope/vim-rhubarb'

"***********
" SNIPPETS *
"***********

" The best snippets plugin
Plug 'SirVer/ultisnips'

" Default snippets for many languages
Plug 'honza/vim-snippets'

"**************
" PROGRAMMING *
"**************

" Automatic indentation (adjusts shiftwidth and expandtab based on current file)
Plug 'tpope/vim-sleuth'

" Syntax checking for many languages
Plug 'scrooloose/syntastic'

" Code commenter
Plug 'scrooloose/nerdcommenter'

" Fold and unfold programming constructs (especially Ruby's)
Plug 'AndrewRadev/splitjoin.vim'

" Template helpers (HTML, erb, etc)
Plug 'tpope/vim-ragtag'

" Automatically put 'end' after 'def'
Plug 'tpope/vim-endwise'

" Functional OO VimL (dependency for other stuff)
Plug 'rizzatti/funcoo.vim'

"*********
" ELIXIR *
"*********

Plug 'slashmili/alchemist.vim'

"***************
" RUBY / RAILS *
"***************

" Test runner
Plug 'janko-m/vim-test'

" Rails turbo integration (file navigation, commands, etc)
Plug 'tpope/vim-rails'

" Generic Ruby file navigation
Plug 'tpope/vim-rake'

" Bundler integration (gem paths, Bopen, Bsplit, etc)
Plug 'tpope/vim-bundler'

" Better minitest syntax
Plug 'sunaku/vim-ruby-minitest'

" Ruby text objects
Plug 'nelstrom/vim-textobj-rubyblock'

"*********
" Python *
"*********

Plug 'hdima/python-syntax'
Plug 'klen/python-mode'

"******************
" OTHER LANGUAGES *
"******************

Plug 'sheerun/vim-polyglot'

call plug#end()
