" Meditate.vim -- Vim color scheme.
" Author: Hwan Goh (Hwan.Goh@gmail.com
" Description: Modified from 'apprentice' by Romain Lafourcade (https://github.com/romainl/Apprentice)
" Changes: see https://jonasjacek.github.io/colors/ for good reference on colours
        " Wheat4(101) to LightSkyBlue3(109)
        " DarkOrange(208) to IndianRed1(203)
        " Wheat1(116) to DarkSlateGray3(116)
        " Grey74(250) to Grey70(249)

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "meditate"

if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
    hi Normal ctermbg=235 ctermfg=249 cterm=NONE guibg=#262626 guifg=#b2b2b2 gui=NONE
    hi NonText ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
    hi EndOfBuffer ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
    hi LineNr ctermbg=234 ctermfg=242 cterm=NONE guibg=#1c1c1c guifg=#6c6c6c gui=NONE
    hi FoldColumn ctermbg=234 ctermfg=242 cterm=NONE guibg=#1c1c1c guifg=#6c6c6c gui=NONE
    hi Folded ctermbg=234 ctermfg=242 cterm=NONE guibg=#1c1c1c guifg=#6c6c6c gui=NONE
    hi MatchParen ctermbg=234 ctermfg=116 cterm=NONE guibg=#1c1c1c guifg=#87d7d7 gui=NONE
    hi SignColumn ctermbg=234 ctermfg=242 cterm=NONE guibg=#1c1c1c guifg=#6c6c6c gui=NONE
    hi Comment ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
    hi Conceal ctermbg=NONE ctermfg=249 cterm=NONE guibg=NONE guifg=#b2b2b2 gui=NONE
    hi Constant ctermbg=NONE ctermfg=203 cterm=NONE guibg=NONE guifg=#ff5f5f gui=NONE
    hi Error ctermbg=NONE ctermfg=131 cterm=reverse guibg=NONE guifg=#af5f5f gui=reverse
    hi Identifier ctermbg=NONE ctermfg=67 cterm=NONE guibg=NONE guifg=#5f87af gui=NONE
    hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi PreProc ctermbg=NONE ctermfg=66 cterm=NONE guibg=NONE guifg=#5f8787 gui=NONE
    hi Special ctermbg=NONE ctermfg=65 cterm=NONE guibg=NONE guifg=#5f875f gui=NONE
    hi Statement ctermbg=NONE ctermfg=110 cterm=NONE guibg=NONE guifg=#8fafd7 gui=NONE
    hi String ctermbg=NONE ctermfg=108 cterm=NONE guibg=NONE guifg=#87af87 gui=NONE
    hi Todo ctermbg=NONE ctermfg=NONE cterm=reverse guibg=NONE guifg=NONE gui=reverse
    hi Type ctermbg=NONE ctermfg=103 cterm=NONE guibg=NONE guifg=#8787af gui=NONE
    hi Underlined ctermbg=NONE ctermfg=66 cterm=underline guibg=NONE guifg=#5f8787 gui=underline
    hi Pmenu ctermbg=238 ctermfg=249 cterm=NONE guibg=#444444 guifg=#b2b2b2 gui=NONE
    hi PmenuSbar ctermbg=240 ctermfg=NONE cterm=NONE guibg=#585858 guifg=NONE gui=NONE
    hi PmenuSel ctermbg=66 ctermfg=235 cterm=NONE guibg=#5f8787 guifg=#262626 gui=NONE
    hi PmenuThumb ctermbg=66 ctermfg=66 cterm=NONE guibg=#5f8787 guifg=#5f8787 gui=NONE
    hi ErrorMsg ctermbg=131 ctermfg=235 cterm=NONE guibg=#af5f5f guifg=#262626 gui=NONE
    hi ModeMsg ctermbg=108 ctermfg=235 cterm=NONE guibg=#87af87 guifg=#262626 gui=NONE
    hi MoreMsg ctermbg=NONE ctermfg=66 cterm=NONE guibg=NONE guifg=#5f8787 gui=NONE
    hi Question ctermbg=NONE ctermfg=108 cterm=NONE guibg=NONE guifg=#87af87 gui=NONE
    hi WarningMsg ctermbg=NONE ctermfg=131 cterm=NONE guibg=NONE guifg=#af5f5f gui=NONE
    hi TabLine ctermbg=238 ctermfg=109 cterm=NONE guibg=#444444 guifg=#87afaf gui=NONE
    hi TabLineFill ctermbg=238 ctermfg=238 cterm=NONE guibg=#444444 guifg=#444444 gui=NONE
    hi TabLineSel ctermbg=109 ctermfg=235 cterm=NONE guibg=#87afaf guifg=#262626 gui=NONE
    hi ToolbarLine ctermbg=234 ctermfg=NONE cterm=NONE guibg=#1c1c1c guifg=NONE gui=NONE
    hi ToolbarButton ctermbg=240 ctermfg=249 cterm=NONE guibg=#585858 guifg=#b2b2b2 gui=NONE
    hi Cursor ctermbg=242 ctermfg=NONE cterm=NONE guibg=#6c6c6c guifg=NONE gui=NONE
    hi CursorColumn ctermbg=236 ctermfg=NONE cterm=NONE guibg=#303030 guifg=NONE gui=NONE
    hi CursorLineNr ctermbg=236 ctermfg=73 cterm=NONE guibg=#303030 guifg=#5fafaf gui=NONE
    hi CursorLine ctermbg=236 ctermfg=NONE cterm=NONE guibg=#303030 guifg=NONE gui=NONE
    hi helpLeadBlank ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi helpNormal ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi StatusLine ctermbg=109 ctermfg=235 cterm=NONE guibg=#87afaf guifg=#262626 gui=NONE
    hi StatusLineNC ctermbg=238 ctermfg=109 cterm=NONE guibg=#444444 guifg=#87afaf gui=NONE
    hi StatusLineTerm ctermbg=109 ctermfg=235 cterm=NONE guibg=#87afaf guifg=#262626 gui=NONE
    hi StatusLineTermNC ctermbg=238 ctermfg=109 cterm=NONE guibg=#444444 guifg=#87afaf gui=NONE
    hi Visual ctermbg=235 ctermfg=110 cterm=reverse guibg=#262626 guifg=#8fafd7 gui=reverse
    hi VisualNOS ctermbg=NONE ctermfg=NONE cterm=underline guibg=NONE guifg=NONE gui=underline
    hi VertSplit ctermbg=238 ctermfg=238 cterm=NONE guibg=#444444 guifg=#444444 gui=NONE
    hi WildMenu ctermbg=110 ctermfg=235 cterm=NONE guibg=#8fafd7 guifg=#262626 gui=NONE
    hi Function ctermbg=NONE ctermfg=116 cterm=NONE guibg=NONE guifg=#87d7d7 gui=NONE
    hi SpecialKey ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
    hi Title ctermbg=NONE ctermfg=231 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi DiffAdd ctermbg=235 ctermfg=108 cterm=reverse guibg=#262626 guifg=#87af87 gui=reverse
    hi DiffChange ctermbg=235 ctermfg=103 cterm=reverse guibg=#262626 guifg=#8787af gui=reverse
    hi DiffDelete ctermbg=235 ctermfg=131 cterm=reverse guibg=#262626 guifg=#af5f5f gui=reverse
    hi DiffText ctermbg=235 ctermfg=203 cterm=reverse guibg=#262626 guifg=#ff5f5f gui=reverse
    hi IncSearch ctermbg=131 ctermfg=235 cterm=NONE guibg=#af5f5f guifg=#262626 gui=NONE
    hi Search ctermbg=116 ctermfg=235 cterm=NONE guibg=#87d7d7 guifg=#262626 gui=NONE
    hi Directory ctermbg=NONE ctermfg=73 cterm=NONE guibg=NONE guifg=#5fafaf gui=NONE
    hi debugPC ctermbg=67 ctermfg=NONE cterm=NONE guibg=#5f87af guifg=NONE gui=NONE
    hi debugBreakpoint ctermbg=131 ctermfg=NONE cterm=NONE guibg=#af5f5f guifg=NONE gui=NONE
    hi SpellBad ctermbg=NONE ctermfg=131 cterm=undercurl guibg=NONE guifg=#af5f5f gui=undercurl guisp=#af5f5f
    hi SpellCap ctermbg=NONE ctermfg=73 cterm=undercurl guibg=NONE guifg=#5fafaf gui=undercurl guisp=#5fafaf
    hi SpellLocal ctermbg=NONE ctermfg=65 cterm=undercurl guibg=NONE guifg=#5f875f gui=undercurl guisp=#5f875f
    hi SpellRare ctermbg=NONE ctermfg=203 cterm=undercurl guibg=NONE guifg=#ff5f5f gui=undercurl guisp=#d75f5f
    hi ColorColumn ctermbg=234 ctermfg=NONE cterm=NONE guibg=#1c1c1c guifg=NONE gui=NONE

elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
    set t_Co=16

    hi Normal ctermbg=black ctermfg=lightgrey cterm=NONE
    hi NonText ctermbg=NONE ctermfg=darkgrey cterm=NONE
    hi EndOfBuffer ctermbg=NONE ctermfg=darkgrey cterm=NONE
    hi LineNr ctermbg=black ctermfg=lightgrey cterm=NONE
    hi FoldColumn ctermbg=black ctermfg=lightgrey cterm=NONE
    hi Folded ctermbg=black ctermfg=lightgrey cterm=NONE
    hi MatchParen ctermbg=black ctermfg=yellow cterm=NONE
    hi SignColumn ctermbg=black ctermfg=lightgrey cterm=NONE
    hi Comment ctermbg=NONE ctermfg=darkgrey cterm=NONE
    hi Conceal ctermbg=NONE ctermfg=lightgrey cterm=NONE
    hi Constant ctermbg=NONE ctermfg=red cterm=NONE
    hi Error ctermbg=NONE ctermfg=darkred cterm=reverse
    hi Identifier ctermbg=NONE ctermfg=darkblue cterm=NONE
    hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE
    hi PreProc ctermbg=NONE ctermfg=darkcyan cterm=NONE
    hi Special ctermbg=NONE ctermfg=darkgreen cterm=NONE
    hi Statement ctermbg=NONE ctermfg=blue cterm=NONE
    hi String ctermbg=NONE ctermfg=green cterm=NONE
    hi Todo ctermbg=NONE ctermfg=NONE cterm=reverse
    hi Type ctermbg=NONE ctermfg=magenta cterm=NONE
    hi Underlined ctermbg=NONE ctermfg=darkcyan cterm=underline
    hi Pmenu ctermbg=darkgrey ctermfg=lightgrey cterm=NONE
    hi PmenuSbar ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi PmenuSel ctermbg=darkcyan ctermfg=black cterm=NONE
    hi PmenuThumb ctermbg=darkcyan ctermfg=darkcyan cterm=NONE
    hi ErrorMsg ctermbg=darkred ctermfg=black cterm=NONE
    hi ModeMsg ctermbg=green ctermfg=black cterm=NONE
    hi MoreMsg ctermbg=NONE ctermfg=darkcyan cterm=NONE
    hi Question ctermbg=NONE ctermfg=green cterm=NONE
    hi WarningMsg ctermbg=NONE ctermfg=darkred cterm=NONE
    hi TabLine ctermbg=darkgrey ctermfg=darkyellow cterm=NONE
    hi TabLineFill ctermbg=darkgrey ctermfg=darkgrey cterm=NONE
    hi TabLineSel ctermbg=darkyellow ctermfg=black cterm=NONE
    hi ToolbarLine ctermbg=black ctermfg=NONE cterm=NONE
    hi ToolbarButton ctermbg=darkgrey ctermfg=lightgrey cterm=NONE
    hi Cursor ctermbg=lightgrey ctermfg=NONE cterm=NONE
    hi CursorColumn ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi CursorLineNr ctermbg=darkgrey ctermfg=cyan cterm=NONE
    hi CursorLine ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi helpLeadBlank ctermbg=NONE ctermfg=NONE cterm=NONE
    hi helpNormal ctermbg=NONE ctermfg=NONE cterm=NONE
    hi StatusLine ctermbg=darkyellow ctermfg=black cterm=NONE
    hi StatusLineNC ctermbg=darkgrey ctermfg=darkyellow cterm=NONE
    hi StatusLineTerm ctermbg=darkyellow ctermfg=black cterm=NONE
    hi StatusLineTermNC ctermbg=darkgrey ctermfg=darkyellow cterm=NONE
    hi Visual ctermbg=black ctermfg=blue cterm=reverse
    hi VisualNOS ctermbg=NONE ctermfg=NONE cterm=underline
    hi VertSplit ctermbg=darkgrey ctermfg=darkgrey cterm=NONE
    hi WildMenu ctermbg=blue ctermfg=black cterm=NONE
    hi Function ctermbg=NONE ctermfg=yellow cterm=NONE
    hi SpecialKey ctermbg=NONE ctermfg=darkgrey cterm=NONE
    hi Title ctermbg=NONE ctermfg=white cterm=NONE
    hi DiffAdd ctermbg=black ctermfg=green cterm=reverse
    hi DiffChange ctermbg=black ctermfg=magenta cterm=reverse
    hi DiffDelete ctermbg=black ctermfg=darkred cterm=reverse
    hi DiffText ctermbg=black ctermfg=red cterm=reverse
    hi IncSearch ctermbg=darkred ctermfg=black cterm=NONE
    hi Search ctermbg=yellow ctermfg=black cterm=NONE
    hi Directory ctermbg=NONE ctermfg=cyan cterm=NONE
    hi debugPC ctermbg=darkblue ctermfg=NONE cterm=NONE
    hi debugBreakpoint ctermbg=darkred ctermfg=NONE cterm=NONE
    hi SpellBad ctermbg=NONE ctermfg=darkred cterm=undercurl
    hi SpellCap ctermbg=NONE ctermfg=cyan cterm=undercurl
    hi SpellLocal ctermbg=NONE ctermfg=darkgreen cterm=undercurl
    hi SpellRare ctermbg=NONE ctermfg=red cterm=undercurl
    hi ColorColumn ctermbg=black ctermfg=NONE cterm=NONE
endif

hi link Terminal Normal
hi link Number Constant
hi link CursorIM Cursor
hi link Boolean Constant
hi link Character Constant
hi link Conditional Statement
hi link Debug Special
hi link Define PreProc
hi link Delimiter Special
hi link Exception Statement
hi link Float Number
hi link HelpCommand Statement
hi link HelpExample Statement
hi link Include PreProc
hi link Keyword Statement
hi link Label Statement
hi link Macro PreProc
hi link Number Constant
hi link Operator Statement
hi link PreCondit PreProc
hi link Repeat Statement
hi link SpecialChar Special
hi link SpecialComment Special
hi link StorageClass Type
hi link Structure Type
hi link Tag Special
hi link Terminal Normal
hi link Typedef Type
hi link htmlTagName Statement
hi link htmlEndTag htmlTagName
hi link htmlLink Function
hi link htmlSpecialTagName htmlTagName
hi link htmlTag htmlTagName
hi link htmlBold Normal
hi link htmlItalic Normal
hi link htmlArg htmlTagName
hi link xmlTag Statement
hi link xmlTagName Statement
hi link xmlEndTag Statement
hi link markdownItalic Preproc
hi link asciidocQuotedEmphasized Preproc
hi link diffBDiffer WarningMsg
hi link diffCommon WarningMsg
hi link diffDiffer WarningMsg
hi link diffIdentical WarningMsg
hi link diffIsA WarningMsg
hi link diffNoEOL WarningMsg
hi link diffOnly WarningMsg
hi link diffRemoved WarningMsg
hi link diffAdded String
hi link QuickFixLine Search

let g:terminal_ansi_colors = [
        \ '#1c1c1c',
        \ '#af5f5f',
        \ '#5f875f',
        \ '#87afaf',
        \ '#5f87af',
        \ '#5f5f87',
        \ '#5f8787',
        \ '#6c6c6c',
        \ '#444444',
        \ '#ff5f5f',
        \ '#87af87',
        \ '#87d7d7',
        \ '#8fafd7',
        \ '#8787af',
        \ '#5fafaf',
        \ '#ffffff',
        \ ]

" Generated with RNB (https://github.com/romainl/vim-rnb)
