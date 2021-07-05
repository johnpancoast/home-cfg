""""""""""""""""""""""""""""
" John's vimrc
"
" Includes a general section below that applies to all uses of vim along with
" possible additional configuration from included vimrc files.

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

" show the coordinates where the cursor's at
set ruler

" autoindent to current position in a block when going to next line
set autoindent

" highlight searches
set hlsearch

" set visual bell, disable audible error bells
set visualbell
set noerrorbells

" when opening a file, send the cursor to the last line I was on
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" allow system clipboard and vim yanks to be passed back and forth
" TODO Install VIM via brew to get a version that's compiled with +clipboard
" support for this to work.
" set clipboard^=unnamed,unnamedplus

""""""""""""""""""""""""""""
" Includes
"
" Use syntax `source [file]` to include a separate vimrc file.
"
source ~/.vimrc-jetbrains
source ~/.vimrc-go
