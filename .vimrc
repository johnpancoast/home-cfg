
" johns vimrc...
"

set background=dark
colorscheme flatland

" use file extensions for syntax highlights
filetype plugin on
syntax on

" tabs to spaces
set expandtab

" amount of spaces to insert for the tab key
set tabstop=4

" number of spaces for indentation
set shiftwidth=4

" If you backspace on the spaces, treat them like one tab character
" (so you don't have to backspace each space character)
set softtabstop=4

" autoindent to current position in a block when going to next line
set autoindent

" line numbers
set nu

" no compatible
set nocompatible

" highlight searches
set hlsearch

" jump to last line i was on when opening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" for phpstorm
set visualbell
set noerrorbells
