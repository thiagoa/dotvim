call plug#begin('~/.vim/plugged')

"*************
" NAVIGATION *
"*************

" Useful home screen / last modified files
Plug 'mhinz/vim-startify'

" Fuzzy file finder
Plug 'kien/ctrlp.vim'

" Use * to search for visual mode selections
Plug 'nelstrom/vim-visual-star-search'

" Easy buffer navigation (like a web browser)
Plug 'ton/vim-bufsurf'

" Powerful % matching
Plug 'vim-scripts/matchit.zip'

" Shortcuts to navigate between buffers, quick fix window, etc
Plug 'tpope/vim-unimpaired'

" Readline mappings for insert mode! (emacs-like)
Plug 'tpope/vim-rsi'

"********************
" TEXT MANIPULATION *
"********************

" Smoothly exchange pieces of text
Plug 'tommcdo/vim-exchange'

" Syntax checking (I do not enable this by default. Pretty heavy...)
Plug 'scrooloose/syntastic'

" Surround text with any pair of characters
Plug 'tpope/vim-surround'

" A more powerful dot command. Repeat 'surround' and 'unimpaired' commands.
Plug 'tpope/vim-repeat'

"*****************
" FILE UTILITIES *
"*****************

" Rename a buffer and its corresponding file at the same time I also have a
" custom function to do the 'delete' counterpart in functions.vim
Plug 'danro/rename.vim'

" Automatic 'mkdir -p' upon saving
Plug 'DataWraith/auto_mkdir'

" I use this instead of NERDTree for file navigation
Plug 'tpope/vim-vinegar'

"***************
" TEXT OBJECTS *
"***************

" Indentation-based text-object
Plug 'austintaylor/vim-indentobject'

" Extend default text objects and add new ones
Plug 'wellle/targets.vim'

" For manipulating function arguments
Plug 'vim-scripts/argtextobj.vim'

" Allows creating custom text objects. A dependency for other plugins
Plug 'kana/vim-textobj-user'

"*********
" THEMES *
"*********

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

Plug 'tpope/vim-fugitive'

"***********
" SNIPPETS *
"***********

Plug 'SirVer/ultisnips'

" Some default snippets
Plug 'honza/vim-snippets'

"**************
" PROGRAMMING *
"**************

" Automatic indentation (adjusts shiftwidth and expandtab based on curfile)
Plug 'tpope/vim-sleuth'

" Code commenter
Plug 'scrooloose/nerdcommenter'

" Fold and unfold some programming constructs, especially Ruby's
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
Plug 'skalnik/vim-vroom'

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
