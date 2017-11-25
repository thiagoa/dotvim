function! SetupCommandAlias(input, output)
  exec 'cabbrev <expr> '.a:input
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
        \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction

call SetupCommandAlias('grep', 'GrepperRg')
call SetupCommandAlias('git', 'Git')
call SetupCommandAlias('gcommit', 'Gcommit')
call SetupCommandAlias('ci', 'Ci')
call SetupCommandAlias('gremove', 'Gremove')
call SetupCommandAlias('gread', 'Gread')
call SetupCommandAlias('bundle', 'Bundle')
call SetupCommandAlias('vsb', 'vert vsb')
call SetupCommandAlias('W', 'w')
call SetupCommandAlias('WQ', 'wq')
call SetupCommandAlias('Cd', 'cd')
call SetupCommandAlias('E', 'e')
call SetupCommandAlias('B', 'b')
call SetupCommandAlias('Sb', 'sb')
call SetupCommandAlias('Sp', 'sp')
