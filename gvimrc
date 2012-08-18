"""""""""""""""""""""""""""""""
" GRAPHICAL VIM CONFIGURATION "
"""""""""""""""""""""""""""""""
" Some cool colors to consider using. Put color configuration in ~/.gvimrc.local
"if has("gui_running")
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
    "color xoria256
    "color mac_classic
"endif

" Include user's local vim config
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif

set linespace=0
