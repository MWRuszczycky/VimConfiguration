set guifont=Deja\ Vu\ Sans\ Mono\ 10
set guioptions-=T
set guioptions-=m
cd $HOME
" Start in file directory
set autochdir

" Window size and position
winpos 265 0
set columns=202
set lines=60

" Map <F7> to compile pdfLaTeX command
nmap <F7> :! pdflatex --output-directory=../build % <CR>

" Map <F6> to compile BibTeX command, openout_any=a overrides the
" security feature that does not allow writing to parent directories.
nmap <F6> :! env openout_any=a bibtex ../build/%< <CR>

" Map <F5> to open pdf document
nmap <F5> :! evince ../build/%<.pdf <CR>

" Code folding
set foldmethod=syntax           "fold based on indent
set foldnestmax=5               "deepest fold level
set foldlevel=0                 "all folds start at this level folded

" C++ formatting
set cindent
set nosmartindent
set autoindent
set cinoptions=:0

colorscheme BluesAndGreens

" Highligt tabs and extrawhitespace at end of lines
highlight extrawhitespace guibg=#691919
augroup removewhitespace
    autocmd!
    autocmd BufWinEnter * match extrawhitespace /\(\s\+$\)\|\(\t\)/
augroup END
