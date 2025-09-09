" Disable compatibility with vi which can cause inexpected issues.
set nocompatible

" Enable file type detection. Vim will be able to try to detect the type of
" file in use
filetype on

" Enable plugins and load plugin for the selected file type
filetype plugin on

" Load an indent file for the detected file type
filetype indent on

" Turn syntax highlighting on
syntax on

" Add numbers to each line on the left-hand side
set number

" Set shift width to 2 spaces
set shiftwidth=2

" Set tab width to 2 colums
set tabstop=2

" Use space characters instead of tabs
set expandtab

" Do not save backup files
set nobackup

" While searching through a file incrementally highlight matching characters
" as you type
set incsearch

" Ignore capital letters during search
set ignorecase

" Override the ignorecase option if searching for capital letters 
" This will allow you to search specifically for capital letters
set smartcase

" Show partial command you type in the last line of the screen
set showcmd

" Show the mode you are in on the last line
set showmode

" Show matching words during a search
set showmatch

" Use highlighting when doing a search
set hlsearch

" Set the number of commands to save in history (default is 20)
set history=1000

" Enable auto completion menu after pressing TAB
set wildmenu

" Make wildmenu behave like similar to bash completion
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
