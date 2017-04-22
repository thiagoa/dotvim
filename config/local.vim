if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

let os = substitute(system('uname'), "\n", "", "")

if os == "Linux"
    source ~/.vim/config/os.linux.vim
elseif os == "Darwin"
    source ~/.vim/config/os.darwin.vim
endif
