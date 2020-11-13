set background=dark
colorscheme wood

" use file extensions for syntax highlights
filetype plugin on
syntax on

" no compatible for various fixes
set nocompatible

" tabs to spaces
set expandtab

" amount of spaces to insert for the tab key
set tabstop=4

" number of spaces for indentation
set shiftwidth=4

" If you backspace on the spaces, treat them like one tab character
" (so you don't have to backspace each space character)
set softtabstop=4

" line numbers
set nu

" autoindent to current position in a block when going to next line
set autoindent

" highlight searches
set hlsearch

" set visual bell, disable audible error bells
set visualbell
set noerrorbells

" jump to last line I was on when opening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" osx clipboard copying
" TODO Review what this does again, leaving enabled for now
set clipboard=unnamed

" golang
" TODO Review what this does again, disable for now
"filetype off
"filetype plugin indent off
"set runtimepath+=$GOROOT/misc/vim
"filetype plugin indent on
"syntax on
