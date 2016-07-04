" Default theme. Should be overriden by vimrc.local
color solarized
set background=dark

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
