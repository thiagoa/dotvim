let mapleader = "\<Space>"

nnoremap <Leader>l :call functions#toggle_list("Location List", 'l')<CR>
nnoremap <Leader>z :call functions#toggle_list("Quickfix List", 'c')<CR>

" Dash
nmap <silent> <Leader>o <Plug>DashSearch

" Expand word under cursor on ex mode
cnoremap <M-.> <C-R>=expand('<cword>')<CR>

" Overwrite some unimpaired mappings
nnoremap [b :BufSurfBack<CR>
nnoremap ]b :BufSurfForward<CR>

" fzf.vim
nnoremap \ :Buffers<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-h> :History<CR>

" Faster save and quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :qall<CR>

" Save and run last shell command
nnoremap @! :w<CR>:!!<CR>

" OS clipboard integration
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
nnoremap <Leader>yy "+yy

vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

" Quickly open files in same directory
noremap <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
noremap <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
noremap <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

" Substitute word under cursor
noremap <Leader>S :%s/<C-R>=escape(expand("<cword>"), '/') . '//g'<CR><Left><Left>

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" No arrow keys for history navigation
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Grep word under cursor
nnoremap K :GrepperRg "\b<C-R><C-W>\b"<CR>:cw<CR>

" Preserve cursor position when yanking in visual mode
vnoremap gy ygv<Esc>

" Delete function (C, PHP, etc)
nnoremap <silent> <Leader>df dV]M

" Show hidden characters
nmap <silent> <Leader>c :set nolist!<CR>

" Disable hlsearch
nnoremap <silent><Leader><Space> :nohlsearch<CR>

" Auto close curly braces on return (essential)
inoremap {<CR> {<CR>}<Esc>O

" Auto close brackets on return (essential)
inoremap [<CR> [<CR>]<Esc>O

set tags=tags;/

" Open tag in vertical split
map <C-w>[ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Open tag at cursor using ptselect
nnoremap <C-w>{ <Esc>:exe "ptselect " . expand("<cword>")<Esc>

" Open tag in new tab
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
