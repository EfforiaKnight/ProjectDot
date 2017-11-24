"  ================ EfforiaKnight ================
"  ================ Modeline and Notes ================ {
" vim: foldmarker={,} foldmethod=marker foldlevel=0:
" }

"  ================ Vim-Plug auto install ================ {
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }

"  ================ Plugins ================ {
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'
Plug 'joshdick/onedark.vim'
"Plug 'tomasr/molokai'
Plug 'christoomey/vim-tmux-navigator'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-asterisk'
" Plug 'justinmk/vim-sneak'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }
Plug 'tpope/vim-obsession'
Plug 'junegunn/vim-peekaboo'
Plug 'mhinz/vim-sayonara'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'

" http://vim.wikia.com/wiki/Moving_through_camel_case_words
" Plug 'chaoren/vim-wordmotion'

" Code support
Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Yggdroot/indentLine'
" Plug 'sheerun/vim-polyglot'
Plug 'sbdchd/neoformat'
"Plug 'w0rp/ale'
Plug 'neomake/neomake'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'

" Python support
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'Shougo/echodoc.vim', { 'for': 'python' }
Plug 'Shougo/neopairs.vim', { 'for': 'python' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Icons plugin
Plug 'ryanoasis/vim-devicons'
call plug#end()
" }

"  ================ Colors ================ {
syntax enable              " Enable syntax highlighting.
set termguicolors
set background=dark
"let g:onedark_terminal_italics=1
colorscheme solarized8_dark
" }

"  ================ Encoding ================ {
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
" }

" ================ Folds ================ {
"set foldmethod=indent      " fold based on indent level
set foldnestmax=1         " max 10 depth
"set foldenable             " Auto fold code
set foldlevelstart=1        " start with fold level of 1
" }

"  ================ UI layout ================ {
set scrolloff=7            " Set 7 lines to the cursor - when moving vertically using j/k
"set relativenumber         " Set relative number column
set number                 " Display line numbers
set ruler                  " Always show current position

" Only have cursorline in current window and in normal window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline

set wildmenu               " Show list instead of just completing
set wildmode=list:longest,full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildignorecase

set laststatus  =2         " Always show statusline.
set noshowmode             " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set shortmess=at           " Avoids hit enter
set report      =0         " Always report changed lines.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.
" }

"  ================ UI Special chars ================ {
set list                    " Show non-printable characters.
set showbreak=↪\
set linebreak
set listchars=tab:▸\ ,extends:❯,precedes:❮,eol:¬,trail:·
set fillchars=diff:⣿,vert:│ " Change fillchars
set diffopt=vertical        " Use in vertical diff mode

augroup trailing " Only show trailing whitespace when not in insert mode
    autocmd!
    autocmd InsertEnter * :set listchars-=trail:·
    autocmd InsertLeave * :set listchars+=trail:·
augroup END
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
set backspace =indent,eol,start  " Make backspace work as you would expect.
set lazyredraw             " Only redraw when necessary.
set autoread
set nojoinspaces           " J command doesn't add extra space
set mouse=a                " Enable mouse
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-iCursor-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

let g:python_host_prog = '/bin/python2'
let g:python3_host_prog = '/bin/python'

" Disable tmux navigator when zooming the Vim pane. [vim-tmux-navigator]
let g:tmux_navigator_disable_when_zoomed = 1
" }

" ================ Search ================ {
set incsearch              " Highlight while searching with / or ?
set hlsearch               " Keep matches highlighted.
set ignorecase             " Case insensitive
set smartcase              "
set wrapscan               " Searches wrap around end-of-file.
set synmaxcol   =200       " Only highlight the first 200 columns.
if has('nvim')
    set inccommand=split " Multiple substitute in window
endif

let g:incsearch#highlight = {
\   'match' : {
    \     'group' : 'IncSearchUnderline',
\     'priority' : '10'
\   },
\   'on_cursor' : {
\     'priority' : '100'
\   },
\   'cursor' : {
\     'group' : 'ErrorMsg',
\     'priority' : '1000'
\   }
\ }
" }

" ================ Leader Map ================ {
let mapleader=','
let maplocalleader="\\"
" }

" ================ Custom mappings ================ {
" Remap ctrl-c for this issue:
" https://github.com/Shougo/deoplete.nvim/issues/460
inoremap <C-c> <Esc>

" Recover from accidental Ctrl-U
" http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Clear search by Tim Pope https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim
"nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap <silent> <A-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" When jump to next match also center screen
" Note: Use :norm! to make it count as one command. (i.e. for i_CTRL-o)
nnoremap <silent> n :norm! nzz<CR>
nnoremap <silent> N :norm! Nzz<CR>
vnoremap <silent> n :norm! nzz<CR>
vnoremap <silent> N :norm! Nzz<CR>

" Same when moving up and down
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
vnoremap <C-u> <C-u>zz
vnoremap <C-d> <C-d>zz
vnoremap <C-f> <C-f>zz
vnoremap <C-b> <C-b>zz

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" Visual linewise up and down by default (and use gj gk to go quicker)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>rv :source $MYVIMRC<CR>:redraw<CR>:noh<CR>:echo $MYVIMRC 'Reloaded'<CR>

" Change to current working directory
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

" Open/close folds
nnoremap <space> za

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Jump to previous match fith f/t/F/T
nnoremap \ ,

" Move selected lines up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Select last pasted text
nnoremap gp `[v`]

" Make Y consistent with C and D by yanking up to end of line
noremap Y y$

" QuickFix navigation
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

" Location list navigation
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>

" Error mnemonic (Neomake uses location list)
nnoremap ]e :lnext<CR>
nnoremap [e :lprevious<CR>

nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>

" [S]plit line (sister to [J]oin lines) S is covered by cc.
nnoremap S mzi<CR><ESC>`z

" Start substitute on current word under the cursor
nnoremap <leader>s :%s///gc<Left><Left><Left>

" Escape to normal mode in terminal
tnoremap <Esc> <C-\><C-n>

" Use Tab and S-Tab to select candidate
inoremap <expr><Tab>  pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Maps for indentation in normal mode
nnoremap <tab> >>
nnoremap <s-tab> <<

" Spell toggle
imap <F9> <C-\><C-o>:setlocal spell!<CR>
nmap <F9> :setlocal spell!<CR>

" Indenting in visual mode
xnoremap <tab> >gv
xnoremap <s-tab> <gv

" Restoring next list jump with remaping
nnoremap <A-o> <c-i>

" Fix spelling error on the go
imap <c-s> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <c-s> [s1z=<c-o>

" scroll slightly faster
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Insert empty line above or below
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
" nnoremap <leader>O  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[+1
" nnoremap <leader>o :<c-u>put =repeat(nr2char(10), v:count1)<cr>']-1

" Quick save and close buffer
nnoremap ,w :w<CR>
nnoremap <silent> <leader>c :Sayonara!<CR>
nnoremap <silent> <A-k> :Sayonara<CR>

nnoremap <silent> <C-Right> :call IntelligentVerticalResize('right')<CR>
nnoremap <silent> <C-Left> :call IntelligentVerticalResize('left')<CR>
nnoremap <silent> <C-Up> :resize +1<CR>
nnoremap <silent> <C-Down> :resize -1<CR>

" Search visual selected text with * and #
"function! s:VSetSearch()
"  let temp = @@
"  norm! gvy
"  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
"  let @@ = temp
"endfunction
"
"vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
"vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" If you are in a split window, Alt-k closes the window.
" If there is only one window (no split), Alt-k closes the current buffer
" and move to the previous one.
" function! CloseWindowOrBuffer()
"     if winnr('$') > 1    " there is more than one window, i.e. there is a split
"         call feedkeys("\<c-w>q")
"     else
"         call feedkeys(":bp | bd #\<cr>")
"     endif
" endfunction

" nnoremap <A-k> :call CloseWindowOrBuffer()<cr>
" inoremap <A-k> <Esc>:call CloseWindowOrBuffer()<cr>
" }

" ================ Auto Commands ================ {
" vim-python
" http://vi.stackexchange.com/questions/8772/how-can-i-fix-missing-syntax-highlighting-for-python-keywords-such-as-self/8773#8773
augroup neo-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
        \ formatoptions+=croq softtabstop=4 textwidth=79
        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
        \ | let python_highlight_all=1
        \ | syn keyword pythonSelf self
        \ | highlight def pythonSelf cterm=italic gui=italic ctermfg=9 guifg=#cb4b16
    autocmd FileType python setlocal completeopt-=preview
augroup END

augroup neo-markdown
    autocmd!
    autocmd FileType markdown setlocal concealcursor=nc conceallevel=2
        \ | setlocal spell
augroup END

augroup vimrcEx
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   execute 'normal! g`"zvzz' |
      \ endif

    " Keywordprg settings
    autocmd FileType vim setlocal keywordprg=:help
augroup END
" }

" ================ Functions ================ {
" Be aware of whether you are right or left vertical split
" so you can use arrows more naturally.
" Inspired by https://github.com/ethagnawl.
function! IntelligentVerticalResize(direction) abort
  let l:window_resize_count = 5
  let l:current_window_is_last_window = (winnr() == winnr('$'))

  if (a:direction ==# 'left')
    let [l:modifier_1, l:modifier_2] = ['+', '-']
  else
    let [l:modifier_1, l:modifier_2] = ['-', '+']
  endif

  let l:modifier = l:current_window_is_last_window ? l:modifier_1 : l:modifier_2
  let l:command = 'vertical resize ' . l:modifier . l:window_resize_count . '<CR>'
  execute l:command
endfunction
" }

" ================ Plugin: FZF configurations ================ {
" set fzf's default input to AG instead of find. This also removes gitignore etc
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
let $FZF_DEFAULT_OPTS .= ' --inline-info --border'
"let &grepprg = 'ag --nogroup --nocolor --column'
"command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)

command! -bang -nargs=* MRU
  \ call fzf#vim#history(fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

let s:ag_options = ' --one-device --hidden --ignore .git'
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                  s:ag_options,
  \                 <bang>0 ? fzf#vim#with_preview('down:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" nnoremap <silent> <Leader><Leader> :Files<CR>
" prevent fzf to open files inside NERD_tree buffer
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader><Enter>  :Buffers<CR>

nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R>=expand("<cWORD>")<CR><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
"nnoremap <silent> <Leader>/        :Ag <CR>

nnoremap <silent> q: :History:<CR>
nnoremap <silent> q/ :History/<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <Leader>? :Helptags<CR>
nnoremap <silent> <Leader>p :MRU<CR>

imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" }

" ================ Plugin: Commentary configurations ================ {
noremap <leader>/ :Commentary<cr>
" }

" ================ Plugin: Incsearch configurations ================ {
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)

" Keep cursor position across matches
let g:asterisk#keeppos = 1

" Emacs like keymaps
let g:incsearch#emacs_like_keymap=1
map *   <Plug>(incsearch-nohl)<Plug>(asterisk-*)
map g*  <Plug>(incsearch-nohl)<Plug>(asterisk-g*)
map #   <Plug>(incsearch-nohl)<Plug>(asterisk-#)
map g#  <Plug>(incsearch-nohl)<Plug>(asterisk-g#)

map z*  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map gz* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
map z#  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
map gz# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)
" }

" ================ Plugin: Neoformat configurations ================ {
let g:neoformat_python_yapf = {
        \ 'exe': 'yapf',
        \ 'args': ['based_on_style=pep8'],
        \ }
let g:neoformat_enabled_python = ['autopep8','yapf']
nnoremap <leader>= :<C-u>Neoformat<cr>
vnoremap <leader>= :Neoformat<cr>
" }

" ================ Plugin: IndentLine configurations ================ {
" IndentLine
let g:indentLine_char = '┊'
let g:indentLine_setColors = 0
"let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude = ['markdown']
" }

" ================ Plugin: Airline configurations ================ {
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_close_button = 0
"let g:airline#extensions#tabline#buffer_nr_format = '%s '
"let g:airline#extensions#tabline#buffer_nr_show = 0
" let g:airline#extensions#ale#error_symbol = '⨉ '
" let g:airline#extensions#ale#warning_symbol = '⚠ '

" Show status of Obsession plugin
" https://github.com/vim-airline/vim-airline/wiki/Configuration-Examples-and-Snippets#integration-with-vim-obsession
let g:airline_section_z = airline#section#create(['%{ObsessionStatus('''', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])

let g:airline_solarized_bg='dark'

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <A-1> <Plug>AirlineSelectTab1
nmap <A-2> <Plug>AirlineSelectTab2
nmap <A-3> <Plug>AirlineSelectTab3
nmap <A-4> <Plug>AirlineSelectTab4
nmap <A-5> <Plug>AirlineSelectTab5
nmap <A-6> <Plug>AirlineSelectTab6
nmap <A-7> <Plug>AirlineSelectTab7
nmap <A-8> <Plug>AirlineSelectTab8
nmap <A-9> <Plug>AirlineSelectTab9
nmap <A-[> <Plug>AirlineSelectPrevTab
nmap <A-]> <Plug>AirlineSelectNextTab
" }

" ================ Plugin: NERDTree configurations ================ {
let g:NERDTreeIgnore = ['\.vim$', '\~$', '.*\.pyc$', '.git', '__pycache__']
let g:NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowHidden=1
let g:NERDTreeRespectWildIgnore=1
nnoremap <F1> :NERDTreeToggle<CR>
" }

" ================ Plugin: Jedi configurations ================ {
let g:jedi#use_splits_not_buffers = "winwidth"
" let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = "<F3>"
" }

" ================ Plugin: Deoplete configurations ================ {
" auto select first match
set completeopt+=noinsert

call deoplete#custom#source('_', 'converters', ['converter_auto_paren', 'converter_remove_overlap'])
call deoplete#custom#source('_', 'min_pattern_length', 1)
call deoplete#custom#source('jedi', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#source('jedi', 'disabled_syntaxes', ['Comment'])

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:echodoc_enable_at_startup = 1
let g:deoplete#enable_refresh_always = 0
let g:deoplete#file#enable_buffer_path=1
let g:deoplete#max_list = 10000

let g:deoplete#sources = {}
let g:deoplete#sources.python = ['jedi', 'member', 'file']

let g:deoplete#sources#jedi#server_timeout = 120

inoremap <silent><expr><BS> deoplete#smart_close_popup()."\<C-h>"
inoremap <silent><expr><C-l>    pumvisible() ? deoplete#mappings#refresh() : "\<C-l>"
inoremap <silent><expr><C-z>    deoplete#mappings#undo_completion()
inoremap <silent><expr> <C-Space> deoplete#mappings#manual_complete()
" }

" ================ Plugin: ALE configurations ================ {
"let g:ale_linters = {
"\   'python': ['flake8'],
"\}
" let g:ale_sign_error = '⨉'
"let g:ale_sign_warning = '⚠️'
"let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
" }

" ================ Plugin: Neomake configurations ================ {
" Run NeoMake on read and write operations
" autocmd! BufReadPost,BufWritePost * Neomake

" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" let g:neomake_warning_sign = {
"       \ 'text': '⚠️',
"       \ 'texthl': 'WarningMsg',
"       \ }
" let g:neomake_error_sign = {
"       \ 'text': '⨉',
"       \ 'texthl': 'ErrorMsg',
"       \ }
"let g:neomake_python_enabled_makers = ['pylama']
" E501 is line length of 80 characters
"let g:neomake_python_flake8_maker = { 'args': ['--ignore=E115,E266,E501,E302'], }
" General Neomake configuration
" let g:neomake_open_list=2
" let g:neomake_list_height=7
" nnoremap <F5> :w<cr>:Neomake<cr>
" }

" ================ Plugin: Tagbar configurations ================ {
nmap <F8> :TagbarToggle<CR>
inoremap <F8> <esc>:TagbarToggle<CR>
" }

" ================ Plugin: Highlighter configurations ================ {
let g:highlighter#auto_update = 2 " 0: disable (default), 1: after saving the file, 2: after saving and opening the file
" }

" ================ Plugin: Gitgutter configurations ================ {
let g:gitgutter_grep_command = 'ag'
nnoremap <silent> <leader>gg :GitGutterToggle<cr>
nnoremap <silent> <leader>gl :GitGutterLineHighlightsToggle<cr>
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
set spellfile   =$HOME/.local/share/nvim/spell/en.utf-8.add
set updatecount =100
set undofile

let g:fzf_history_dir = '~/.local/share/nvim/fzf-history'
" set undodir     =$HOME/.config/nvim/files/undo/
" set viminfo     ='100,n$HOME/files/info/viminfo
" }
