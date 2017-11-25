set inccommand=split
set clipboard=unnamed " Enables OS-wide-cut-&-paste

source ~/.vim/config/neovim/terminal.vim
source ~/.vim/config/neovim/navigation.vim
source ~/.vim/config/neovim/test.vim

for file in globpath('~/.vim/config/neovim/projects', '*', 0, 1)
  execute 'source ' . file
endfor
