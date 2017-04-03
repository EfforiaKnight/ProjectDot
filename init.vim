"  ================ Constantine Gusev ================
"  ================ Modeline and Notes ================ {
" vim: foldmarker={,} foldmethod=marker foldlevel=0:
" }

"  ================ Colors ================ {
syntax enable              " Enable syntax highlighting.
" }

"  ================ Encoding ================ {
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
" }

" ================ Leader Map ================ {
let mapleader=','
" }

"  ================ UI layout ================ {
set fillchars=""
set scrolloff=7            " Set 7 lines to the cursor - when moving vertically using j/k
set relativenumber         " Set relative number column
set number                 " Display line numbers
set ruler                  "Always show current position
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set laststatus  =2         " Always show statusline.
set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.
set report      =0         " Always report changed lines.
" }

"  ================ UI Special chars ================ {
set list                   " Show non-printable characters.
set showbreak=↪\
set linebreak
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:±,eol:¬,nbsp:␣,trail:•
" }

"  ================ Spaces & Tabs ================ {
set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.
filetype plugin indent on  " Load plugins according to detected filetype.
" }

"  ================ Misc  ================ {
set hidden                 " Enable hidden buffers
set clipboard^=unnamedplus " Make default clipboard, system clipboard
set backspace   =indent,eol,start  " Make backspace work as you would expect.
set lazyredraw             " Only redraw when necessary.
" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif
" }

" ================ Search ================ {
set incsearch              " Highlight while searching with / or ?
set hlsearch               " Keep matches highlighted.
set ignorecase             " Case insensitive
set smartcase              "
set wrapscan               " Searches wrap around end-of-file.
set synmaxcol   =200       " Only highlight the first 200 columns.
if has('nvim')
    set inccommand=nosplit " Multiple substitute in window
endif
" }

" ================ Custom mappings ================ {
" Clear search by Tim Pope https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim
"nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap <silent> <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
nmap <silent> n :norm! nzzzv<CR>
nmap <silent> N :norm! Nzzzv<CR>
noremap j gj
noremap k gk
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>rv :source $MYVIMRC<cr>

" Move selected lines up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Insert empty line above or below
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
" nnoremap <leader>O  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[+1
" nnoremap <leader>o :<c-u>put =repeat(nr2char(10), v:count1)<cr>']-1
" }

" ================ Backups ================ {
" Put all temporary files under the save directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
set backup
set writebackup
set backupdir   =$HOME/.local/share/nvim/backup/
set backupext   =-vimbackup
set backupskip  =
" set directory   =$HOME/.config/nvim/files/swap/
set updatecount =100
set undofile
" set undodir     =$HOME/.config/nvim/files/undo/
" set viminfo     ='100,n$HOME/files/info/viminfo
" }
