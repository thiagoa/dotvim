"""""""""""""""""""""""""""""
" Settings for PHP filetype "
"""""""""""""""""""""""""""""

" Fold method
setlocal foldmethod=manual

" Use make command to check for syntax errors
setlocal makeprg=php\ -d\ display_errors=1\ -l\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" Syntax highlighting settings
let php_sql_query=1
let php_htmlInStrings=1
let g:PHP_outdentphpescape = 0

" Convert object to array format
nnoremap <Leader>o 2s<C-v>[<C-v>'<Esc>ea<C-v>'<C-v>]<Esc>

" PHPDoc mappings
nnoremap <buffer> <Leader>z :call PhpDocSingle()<CR>
vnoremap <buffer> <Leader>z :call PhpDocRange()<CR>

" Mappings for selecting PHP blocks
nmap <silent> <expr> vaP PhpBlockSelect(1)
nmap <silent> <expr> viP PhpBlockSelect(0)
omap <silent> aP :silent normal vaP<CR>
omap <silent> iP :silent normal viP<CR>

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
