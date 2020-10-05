execute pathogen#infect()

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

" Setup the status line
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

" Set two color columns
set cc=70,80

" Turn on syntax highlighting
syntax enable

" Python formatting
augroup filetype_py
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType python setlocal foldmethod=indent
augroup END

" Haskell formatting
augroup filetype_hs
    autocmd!
    autocmd FileType haskell setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType haskell setlocal foldmethod=indent
augroup END

" Markdown folds
function! MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h) || len(h) == 1
        return "="
    else
        return ">" . len(h - 1)
    endif
endfunction

" Markdown formatting
augroup filetype_mkd
    autocmd!
    autocmd FileType markdown setlocal foldexpr=MarkdownLevel()
    autocmd FileType markdown setlocal foldmethod=expr
augroup END

" LaTeX folds
function! LatexLevel()
    " Get the contents of the line
    let str = getline(v:lnum)
    if str =~ '^\\\(sub\)*section'
        " Start a level-1 fold
        return '>1'
    elseif str =~ '^\\paragraph'
        " Start a level-2 fold
        return '>2'
    elseif str =~ '^\\begin'
        " Add one level to the previous fold level
        return 'a1'
    elseif str =~ '^\\end'
        " Subtract one level from the previous fold level
        return "s1"
    " Check if a fold level has been assigned
    elseif foldlevel(v:lnum-1) != "-1"
        " Assign the previous level to keep from tracing way back
        return foldlevel(v:lnum-1)
    else
        " Trace back to find the fold level
        return "="
    endif
endfunction

" LaTeX formatting
augroup filetype_tex
    autocmd!
    autocmd FileType tex setlocal foldexpr=LatexLevel()
    " Use foldexpr to determine the fold level of each line
    autocmd FileType tex setlocal foldmethod=expr
augroup END

" Setting the cursor color based on mode
if &term =~ "xterm\\|rxvt"
  " Use a light grey cursor in insert mode
  let &t_SI = "\<Esc>]12;darkgrey\x7"
  " Use a orange cursor otherwise
  let &t_EI = "\<Esc>]12;darkmagenta\x7"
  silent !echo -ne "\033]12;darkmagenta\007"
  " Reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]12;lightgrey\007"
endif

" Colorscheme
colorscheme BluesAndGreens

" Keep same transparency as the terminal
hi Normal guibg=NONE ctermbg=NONE

" Highlight unwanted whitespace and tabs
highlight tabbedWhiteSpace   ctermbg=234
highlight trailingWhiteSpace ctermbg=52
augroup showUnwantedWhitespace
    autocmd!
    autocmd BufWinEnter * syntax match tabbedWhiteSpace   /\(\t\)/
    autocmd BufWinEnter * syntax match trailingWhiteSpace /\(\s\+$\)/
augroup END
