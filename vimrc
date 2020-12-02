execute pathogen#infect()

" =================================================================== 
" Settings

set number
set display+=lastline
" Do not make automatic backup files
set nobackup
set noswapfile
" Enable 256 colors in vim
set t_Co=256

" Set text wrapping and breaking between words
set wrap
set linebreak

" Change tabs to 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" Maintain indentation level
set autoindent

" Default backspace behavior: Can only backspace over what was just
" entered since start of insert mode but not newlines or indents.
set backspace=

" Set two color columns
set cc=70,80

" Turn on syntax highlighting
syntax enable

" =================================================================== 
" Status line

set statusline=                         " Reset
set laststatus=2                        " Always show the status line
set statusline+=%.20f                   " Full path truncated to 20 characters
set statusline+=\ %m                    " Indicate if file has beed modified
set statusline+=\ \|\ FileType:\ %y     " Filetype
set statusline+=\ \|\ Bfr:\ %n          " Buffer number
set statusline+=\ \|\ Col:\ %2c         " Column number
set statusline+=\ \|\ Line:\ %4l\/%-L   " Line/total lines
set statusline+=\ \|\ %p%%              " Percent file
set statusline+=%k " Key

" ====================================================================
" Mappings

" Remap the leader to comma
let mapleader = ","

" Reload the gvimrc and vimrc
nnoremap <leader>rc :source $MYVIMRC<CR> :source $MYGVIMRC<CR>

" Map Ctrl-N to escape and write from insert mode
inoremap <C-n> <esc>:w<CR>

" Jump ahead one character in insert mode
inoremap <C-t> <esc>la

" Keep page centered
nnoremap j gjzz
nnoremap k gkzz

" When opening new lines, center the text
nnoremap o zzo
nnoremap O zzO

" Open new lines without leaving normal mode and keep centered
nnoremap <leader>o zzo<esc>
nnoremap <leader>O zzO<esc>

" Map t to l
vnoremap t l
vnoremap l t
nnoremap t l
nnoremap l t

" Moving between buffer windows
nnoremap <C-h> <C-W><left>
nnoremap <C-t> <C-W><right>
nnoremap <C-w> <C-W><down>
nnoremap <C-c> <C-W><up>

" Cycling between buffers in a singel window
nnoremap <C-n> :bn<CR>

" Write and delete buffer without closing window
nnoremap <C-x> :w<CR>:bn<CR>:bd#<CR>

" -------------------------------------------------------------------
" Quick pairs

" Inline quick pairs
imap <leader>'  ''<esc>i
imap <leader>"  ""<esc>i
imap <leader>qq ``''<esc>hi
imap <leader>(  ()<esc>i
imap <leader>[  []<esc>i
imap <leader><  <><esc>i
imap <leader>{  {}<esc>i
imap <leader>$  $$<esc>i
imap <leader>*  **<esc>i
imap <leader>** ****<esc>hi
imap <leader>_  __<esc>i
imap <leader>__ ____<esc>hi
imap <leader>cc /**/<esc>hi
imap <leader>bb ``<esc>i
imap <leader>pp """"""<esc>hhi

" Multiline quickpairs
imap <leader>{<CR> {}<esc>i<CR><esc>O
imap <leader>cc<CR> /*<CR><CR><esc>i*/<esc>ki<space><space>
imap <leader>bb<CR> ```<CR>```<esc>ka
imap <leader>pp<CR> """<CR>"""<esc>ka

" ===================================================================
" Functions

" ------------------------------------------------------------------- 
" Folding

" Markdown folds
function! MarkdownLevel(lnum)
    let str = getline(a:lnum)
    let x = strlen( matchstr(str, '^#\+') )
    " Code blocks often have single # denoting comments and we do not
    " want to fold on these. So, only fold at ## and higher.
    if x > 1
        return ">" . (x - 1)
    " All code blocks must provide a type for this to work correctly.
    elseif str =~ '^```\w'
        return 'a1'
    elseif str =~ '^```'
        return 's1'
    elseif foldlevel(a:lnum - 1) != '-1'
        return foldlevel(a:lnum - 1)
    else
        return '='
endfunction

" LaTeX folds
function! LatexLevel(lnum)
    let str = getline(a:lnum)
    if str =~ '^\\section'
        return '>1'
    elseif str =~ '^\\subsection'
        return '>2'
    elseif str =~ '^\\subsubsection'
        return '>3'
    elseif str =~ '^\\paragraph'
        return '>4'
    elseif str =~ '^\\begin'
        return 'a1'
    elseif str =~ '^\\end'
        return 's1'
    elseif foldlevel(a:lnum-1) != '-1'
        return foldlevel(a:lnum - 1)
    else
        return '='
    endif
endfunction

" Bash folds
function! BashLevel(lnum)
    let str = getline(a:lnum)
    " Start a level-1 fold for each function
    if str =~ '{$'
        return '>1'
    elseif str =~ '^}'
        return '<1'
    " Add level at if, case, while, until and for. Only whitespace
    " may proceed these keywords if the fold is to be recognized.
    elseif str =~ '^ *\(if\|case\|for\|while\|until\) '
        return 'a1'
    " Folds over if, case, while, until and for must have their final
    " keyword on a separate line with no trailing whitespace.
    elseif str =~ '^ *\(fi\|done\|esac\)$'
        return 's1'
    " Any non-whitespace that starts a line and is not part of an if
    " control block will reset the foldlevel to 0. The else keyword
    " must be on its own line with only preceding whitespace.
    elseif str =~ '^ *else$'
        return '='
    elseif str =~ '^ *elif '
        return '='
    elseif str =~ '^\S'
        return '0'
    " Handle everything else.
    elseif foldlevel(a:lnum - 1) != '-1'
        return foldlevel(a:lnum - 1)
    else
        return '='
endfunction

" ===================================================================
" Formatting by file type

" -------------------------------------------------------------------
" Python formatting
augroup filetype_py
    autocmd!
    autocmd FileType python setlocal foldmethod=indent
augroup END

" -------------------------------------------------------------------
" Haskell formatting
augroup filetype_hs
    autocmd!
    autocmd FileType haskell setlocal foldmethod=indent
augroup END

" -------------------------------------------------------------------
" Markdown formatting
augroup filetype_mkd
    autocmd!
    autocmd FileType markdown setlocal foldexpr=MarkdownLevel(v:lnum)
    autocmd FileType markdown setlocal foldmethod=expr
augroup END

" -------------------------------------------------------------------
" LaTeX formatting
augroup filetype_tex
    autocmd!
    autocmd FileType tex setlocal foldexpr=LatexLevel(v:lnum)
    autocmd FileType tex setlocal foldmethod=expr
augroup END

" -------------------------------------------------------------------
" Vimscript formatting
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=indent
augroup END

" -------------------------------------------------------------------
" Bash formatting
augroup filetype_sh
    autocmd!
    autocmd FileType sh setlocal foldexpr=BashLevel(v:lnum)
    autocmd FileType sh setlocal foldmethod=expr
augroup END

" ---------------------------------------------------------------------
" HTML formatting
augroup filetype_html
    autocmd!
    autocmd FileType html setlocal foldmethod=indent
augroup END

" ===================================================================
" Colors

" -------------------------------------------------------------------
" Setting the cursor color based on mode

if &term =~ "xterm\\|rxvt"
  " Use a light grey cursor in insert mode
  let &t_SI = "\<Esc>]12;darkgrey\x7"
  " Use a magenta cursor otherwise
  let &t_EI = "\<Esc>]12;darkmagenta\x7"
  silent !echo -ne "\033]12;darkmagenta\007"
  " Reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]12;lightgrey\007"
endif

" -------------------------------------------------------------------
" Highlighting & color schemes

" Colorscheme
colorscheme BluesAndGreens

" Keep same transparency as the terminal
hi Normal guibg=NONE ctermbg=NONE

" Highlight unwanted whitespace and tabs
highlight tabbedWS   ctermbg=234
highlight trailingWS ctermbg=52
augroup showUnwantedWhitespace
    autocmd!
    autocmd BufWinEnter * syntax match tabbedWS   /\(\t\)/    containedin=ALL
    autocmd BufWinEnter * syntax match trailingWS /\(\s\+$\)/ containedin=ALL
augroup END
