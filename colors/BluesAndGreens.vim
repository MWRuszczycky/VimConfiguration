set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "BlueAndGreens"

" Colors for vim modes
hi Normal cterm=none ctermfg=lightgrey ctermbg=233       guifg=#fffadc guibg=#1a1a1a
hi Visual cterm=bold ctermfg=16        ctermbg=darkgreen guifg=black   guibg=lightgreen

" Special character colors
hi NonText    term=none ctermfg=darkred guifg=#aa2828
hi SpecialKey term=bold ctermfg=magenta guifg=blue

" Messages
hi ErrorMsg term=bold cterm=bold ctermfg=white     ctermbg=darkred gui=bold guifg=black   guibg=darkred
hi MoreMsg  term=bold cterm=bold ctermfg=green     ctermbg=none    gui=bold guifg=#d174a8 guibg=bg
hi ModeMsg  term=bold cterm=bold ctermfg=none      ctermbg=none    gui=bold guifg=fg      guibg=bg
hi Question term=bold cterm=bold ctermfg=darkgreen ctermbg=none    gui=bold guifg=#d174a8 guibg=bg

" Vim status lines, line numbers, etc.
hi LineNr       term=bold cterm=none ctermfg=lightgrey ctermbg=none     gui=none guibg=#1A1A1A  guifg=#DCDCDC
hi StatusLine   term=bold cterm=bold ctermfg=16        ctermbg=darkcyan gui=bold guifg=white    guibg=#1a1a1a
hi StatusLineNC term=bold cterm=bold ctermfg=16        ctermbg=23       gui=bold guifg=darkgrey guibg=bg
hi VertSplit    term=bold cterm=bold ctermfg=white     ctermbg=none     gui=bold guifg=white    guibg=bg
hi Title        term=bold cterm=none ctermfg=green     ctermbg=none     gui=bold guifg=#74ff74  guibg=bg
hi ColorColumn                                         ctermbg=234                              guibg=#2c2c2c

" Colors for matches (with :match Match /pattern/) and searches (with /pattern)
hi Search     term=bold cterm=bold ctermfg=16 ctermbg=yellow gui=bold guifg=black guibg=yellow
hi Match      term=bold cterm=bold ctermfg=16 ctermbg=cyan   gui=bold guifg=black guibg=cyan
hi IncSearch  term=bold cterm=bold ctermfg=16 ctermbg=yellow gui=bold guifg=black guibg=yellow

" Colors for things I do not really use
hi VisualNOS  term=bold cterm=bold ctermfg=none    ctermbg=none gui=bold guifg=#414141 guibg=black
hi WarningMsg term=bold cterm=none ctermfg=darkred ctermbg=none gui=bold guifg=cyan    guibg=bg
hi WildMenu   term=bold cterm=none ctermfg=white   ctermbg=none gui=none guifg=white   guibg=blue

" Colors for code folding
hi Folded     term=bold cterm=none ctermfg=lightblue ctermbg=none gui=none guifg=#afcfef guibg=bg
hi FoldColumn term=bold cterm=none ctermfg=darkblue  ctermbg=grey gui=none guifg=#ffff74 guibg=#3f3f3f

" Colors for diffing
hi DiffAdd    term=bold cterm=bold ctermfg=16      ctermbg=darkcyan gui=none guifg=fg      guibg=black
hi DiffChange term=bold cterm=bold ctermfg=16      ctermbg=yellow   gui=none guifg=fg      guibg=#124a32
hi DiffDelete term=bold cterm=bold ctermfg=darkred ctermbg=none     gui=bold guifg=#522719 guibg=#09172f
hi DiffText   term=bold cterm=bold ctermfg=yellow  ctermbg=black    gui=bold guifg=fg      guibg=#007f9f

" Cursor colors for gvim
hi Cursor     gui=reverse guifg=#bfbfef guibg=Black
hi lCursor    gui=none    guifg=fg      guibg=bg

" Colors for syntax highlighting
hi Comment    term=none cterm=bold ctermfg=darkgrey ctermbg=none gui=none guifg=#7f7f7f guibg=bg
hi Constant   term=none cterm=none ctermfg=green    ctermbg=none gui=none guifg=#d7beff guibg=bg
hi Special    term=none cterm=none ctermfg=79     ctermbg=none gui=none guifg=#aad28c guibg=bg
hi Identifier term=none cterm=bold ctermfg=114      ctermbg=none gui=none guifg=#37afff guibg=bg
hi Statement  term=none cterm=none ctermfg=117      ctermbg=none gui=none guifg=#37afff guibg=bg
hi PreProc    term=none cterm=none ctermfg=214      ctermbg=none gui=none guifg=#e6cd8c guibg=bg
hi Type       term=none cterm=none ctermfg=38       ctermbg=none gui=none guifg=#5ad5d5 guibg=bg
hi Ignore     term=none cterm=bold ctermfg=grey     ctermbg=none gui=none guifg=grey    guibg=bg
hi Error      term=none cterm=bold ctermfg=1        ctermbg=none gui=bold guifg=#f0873c guibg=#1a1a1a
hi Todo       term=none cterm=bold ctermfg=darkblue ctermbg=blue gui=bold guifg=yellow  guibg=blue
