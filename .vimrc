" First vimrc

set nocompatible

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb

let mapleader=','

set fillchars=""
set so=7                   " Set 7 lines to the cursor - when moving vertically using j/k

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set relativenumber         " Set relative number column
set number                 " Display line numbers
set ruler                  "Always show current position

set hidden                 " Enable hidden buffers

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.
set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.
set ignorecase             " Case insensitive
set smartcase              "

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set wrapscan               " Searches wrap around end-of-file.
let report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set list                   " Show non-printable characters.
set showbreak=↪\
set linebreak
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:±,eol:¬,nbsp:␣,trail:•

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" Mappings
" nnoremap <silent> <esc> :noh<cr><esc>
" nnoremap <silent> <C-c> :noh<cr><C-c>
" Clear search by Tim Pope https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nmap n :norm! nzzzv<CR>
nmap N :norm! Nzzzv<CR>
noremap j gj
noremap k gk
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>rv :source $MYVIMRC<cr>

" Put all temporary files under the save directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo
