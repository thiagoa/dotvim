" ------------------------------
" | Thiago's vim configuration |
" ------------------------------
"
" No comments, let's make this clean! When in doubt :help or Google!

let $VIM_HOME = expand('<sfile>:h:p')
let $CONFIG_HOME = $VIM_HOME.'/config'

source $VIM_HOME/PlugFile.vim

syntax on

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
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
set timeoutlen=1000 ttimeoutlen=0
set laststatus=2
set autoread
set backspace=start,indent,eol
set listchars="tab:>-,trail:�,eol:$"
set shortmess=atI
set splitbelow
set splitright

color dracula

let g:ale_linters = {
\   'ruby': ['standardrb'],
\}

let g:rails_projections = {
      \  "app/controllers/*_controller.rb": {
      \      "test": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_controller_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \   "spec/requests/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \ }

command Eroute Einitializer

source $CONFIG_HOME/functions.vim
source $CONFIG_HOME/mappings.vim
source $CONFIG_HOME/plugin.vim
source $CONFIG_HOME/autocommands.vim
source $CONFIG_HOME/abbreviations.vim
source $CONFIG_HOME/local.vim

if has('nvim')
  set inccommand=split
  set clipboard=unnamed " Enables OS-wide-cut-&-paste

  source $CONFIG_HOME/neovim/terminal.vim
  source $CONFIG_HOME/neovim/navigation.vim
  source $CONFIG_HOME/neovim/test.vim

  " The command below avoids a bug on zsh's edit-command-line. If a parameter
  " (such as +'set buffhiden=wipe') has spaces in between, zsh will escape the
  " single quotes and make nvr think there are two parameters. Defining a
  " command is hack to eliminate the problematic space character.
  let $VISUAL="nvr -cc split --remote-wait +SetWipeBuffer"
  command! SetWipeBuffer set bufhidden=wipe

  for file in globpath($CONFIG_HOME.'/neovim/projects', '*', 0, 1)
    execute 'source '.file
  endfor
endif
