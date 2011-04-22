"Author: echofish (http://echofish.org)
"Last change 12 Apr 09

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "phporiginal"

hi clear Boolean
hi clear Character
hi clear Constant
hi clear Debug
hi clear Define
hi clear DiffAdd
hi clear DiffChange
hi clear DiffDelete
hi clear DiffText
hi clear Directory
hi clear Error
hi clear ErrorMsg
hi clear Exception
hi clear Float
hi clear FoldColumn
hi clear Folded
hi clear Function
hi clear Identifier
hi clear Identifier
hi clear Ignore
hi clear Include
hi clear Keyword
hi clear Label
hi clear Macro
hi clear ModeMsg
hi clear MoreMsg
hi clear NonText
hi clear Normal
hi clear Operator
hi clear Pmenu
hi clear PmenuSbar
hi clear PmenuSel
hi clear PmenuThumb
hi clear PreCondit
hi clear PreProc
hi clear Question
hi clear Region
hi clear Repeat
hi clear Search
hi clear SignColumn
hi clear SpecialComment
hi clear SpecialKey
hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi clear SpellRare
hi clear Statement
hi clear StorageClass
hi clear Structure
hi clear TabLineSel
hi clear Tag
hi clear Title
hi clear Todo
hi clear Type
hi clear Typedef
hi clear Underlined
hi clear WildMenu
hi clear Cursor
hi clear CursorColumn
hi clear CursorIM
hi clear CursorLine

hi Comment guifg=#FF8000 ctermfg=yellow gui=none cterm=none
hi Cursor guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=black
hi CursorColumn gui=none cterm=none
hi CursorIM gui=none cterm=none
hi CursorLine gui=none cterm=none
hi Function guifg=#0000FF ctermfg=blue gui=none cterm=none
hi LineNr guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=black gui=none cterm=none
hi MatchParen guifg=#DD0000 guibg=none ctermbg=none ctermfg=red gui=bold cterm=bold 
hi Normal guifg=#007700 gui=none ctermfg=green cterm=none
hi StatusLine guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=black gui=none cterm=none
hi StatusLineNC guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=black gui=none cterm=none
hi String guifg=#DD0000 gui=none ctermfg=red cterm=none
hi TabLine gui=underline guibg=lightgrey cterm=underline ctermbg=lightgrey
hi VertSplit guifg=#FFFFFF guibg=darkgrey gui=none ctermfg=white ctermbg=darkgrey cterm=none
hi Visual guibg=#000000 gui=none cterm=none ctermbg=black
hi VisualNOS gui=bold,underline cterm=bold,underline

hi link Delimiter Normal
hi link Operator Normal
hi link Statement Normal
hi link Define Normal
hi link phpOperator Normal
hi link phpRelation Normal
hi link phpComparison Normal
hi link Conditional Normal
hi link SpecialKey Normal
hi link Tag Normal
hi link Typedef Normal
hi link PreProc Normal
hi link DiffAdd Normal
hi link DiffChange Normal
hi link DiffDelete Normal
hi link DiffText Normal
hi link Directory Normal
hi link Error Normal
hi link ErrorMsg Normal
hi link FoldColumn Normal
hi link Folded Normal
hi link Ignore Normal
hi link ModeMsg Normal
hi link MoreMsg Normal
hi link NonText Normal
hi link Pmenu Normal
hi link PmenuSbar Normal
hi link PmenuSel Normal
hi link PmenuThumb Normal
hi link Question Normal
hi link Search Normal
hi link SignColumn Normal
hi link SpellBad Normal
hi link SpellCap Normal
hi link SpellLocal Normal
hi link SpellRare Normal
hi link TabLineSel Normal
hi link Title Normal
hi link Todo Normal
hi link Type Normal
hi link Underlined Normal
hi link WildMenu Normal
hi link Boolean Normal
hi link Character Normal
hi link Debug Normal
hi link Exception Normal
hi link Float Normal
hi link Include Normal
hi link Macro Normal
hi link PreCondit Normal
hi link SpecialComment Normal
hi link Keyword Normal
hi link Label Normal
hi link Repeat Normal
hi link StorageClass Normal
hi link phpStorageClass Normal
hi link phpRegion Normal
hi link Region Normal
hi link Constant String
hi link Special String
hi link SpecialChar String
hi link IncSearch VertSplit
hi link TabLineFill VertSplit
hi link Structure Delimiter
hi link Identifier Function
hi link Operator Function
hi link Number Function
hi link phpMethodsVar Function
hi link phpFunctions Function
hi link phpMethods Function
hi link phpSpecialFunction Function
