
" Settings for PHP filetype
"
setlocal omnifunc=syntaxcomplete#Complete
set omnifunc=phpcomplete#CompletePHP

set keywordprg=pman

" Set up automatic formatting
set formatoptions+=tcqlro

setlocal autoindent
setlocal cinwords=if,else,elseif,do,while,foreach,for,case,default,function,class,interface,abstract,private,public,protected,final

" Generates ctags when saving PHP files
autocmd! bufwritepost *.php silent !/Users/thiago/Scripts/generate_php_tags.sh &

" Jump to matching bracket for 3/10th of a second (works with showmatch)
set matchtime=3
set showmatch

" Set maximum text width (for wrapping)
"set textwidth=110

set keywordprg="help"

" Enable folding of class/function blocks
"let php_folding = 1

setlocal foldmethod=manual
"EnableFastPHPFolds

" Do not use short tags to find PHP blocks
"let php_noShortTags = 0

" Highlighti SQL inside PHP strings
let php_sql_query=1

" Highlighti SQL inside PHP strings
let php_htmlInStrings=1

let g:PHP_outdentphpescape = 0

" Use PHP syntax check when doing :make
set makeprg=/Applications/MAMP/bin/php/php5.2.17/bin/php\ -d\ display_errors=1\ -l\ %

" Parse PHP error outpu
set errorformat=%m\ in\ %f\ on\ line\ %l

" Function to locate endpoints of a PHP block {{{
function! PhpBlockSelect(mode)
	let motion = "v"
	let line = getline(".")
	let pos = col(".")-1
	let end = col("$")-1

	if a:mode == 1
		if line[pos] == '?' && pos+1 < end && line[pos+1] == '>'
			let motion .= "l"
		elseif line[pos] == '>' && pos > 1 && line[pos-1] == '?'
			" do nothing
		else
			let motion .= "/?>/e\<CR>"
		endif
		let motion .= "o"
		if end > 0
			let motion .= "l"
		endif
		let motion .= "?<\\?php\\>\<CR>"
	else
		if line[pos] == '?' && pos+1 < end && line[pos+1] == '>'
			" do nothing
		elseif line[pos] == '>' && pos > 1 && line[pos-1] == '?'
			let motion .= "h?\\S\<CR>""
		else
			let motion .= "/?>/;?\\S\<CR>"
		endif
		let motion .= "o?<\\?php\\>\<CR>4l/\\S\<CR>"
	endif

	return motion
endfunction
" }}}

" Mappings to select full/inner PHP block
nmap <silent> <expr> vaP PhpBlockSelect(1)
nmap <silent> <expr> viP PhpBlockSelect(0)
" Mappings for operator mode to work on full/inner PHP block
omap <silent> aP :silent normal vaP<CR>
omap <silent> iP :silent normal viP<CR>

" Mapping to convert from object notation to array notation
nnoremap <Leader>o 2s<C-v>[<C-v>'<Esc>ea<C-v>'<C-v>]<Esc>

" Mappings for PHP Documentor for VIM
inoremap <buffer> <C-S> <Esc>:call PhpDocSingle()<CR>i
nnoremap <buffer> <C-S> :call PhpDocSingle()<CR>
vnoremap <buffer> <C-S> :call PhpDocRange()<CR>
" Generate @uses tag based on inheritance info
let g:pdv_cfg_Uses = 1

" Exuberant Ctags
nmap <silent> <D-]> :!$HOME/Scripts/generate_php_tags.sh <CR>

" Set tag filename(s)
set tags=tags;/

func! PhpUnComment() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line = a:firstline
    let l:endline = a:lastline

while l:line <= l:endline
if getline (l:line) =~ '^\s*\/\/.*$'
let l:newline = substitute (getline (l:line), '^\(\s*\)\/\/ \(.*\).*$', '\1\2', '')
else
let l:newline = substitute (getline (l:line), '^\(\s*\)\(.*\)$', '\1// \2', '')
endif
call setline (l:line, l:newline)
let l:line = l:line + 1
endwhile

    let &g:paste = l:paste
endfunc

" Map <CTRL>-a to (un-)comment function
vnoremap <buffer> <C-a> :call PhpUnComment()<CR>

let g:pdv_cfg_Type = "mixed"
let g:pdv_cfg_Package = "Mix"
let g:pdv_cfg_Version = ""
let g:pdv_cfg_Author = "Thiago A. Silva"
let g:pdv_cfg_Copyright = "(C) 2012 Mix Internet Ltda."
let g:pdv_cfg_License = ""
