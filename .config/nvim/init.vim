" ================ EfforiaKnight ================
" ================ Modeline and Notes ================ {
" vim: foldmarker={,} foldmethod=marker foldlevel=0:
" }

" ================ Vim-Plug auto install ================ {
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }

" ================ Plugins ================ {
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
" Plug 'dkarter/bullets.vim'

" Adds gutter signs and highlights based on git diff
" <leader>hn to go to next hunk
" <leader>hp to go to previous hunk
" <leader>hs to stage hunks within cursor
" <leader>hr to revert hunks within cursor
" <leader>hv to preview the hunk
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" Usage
" [count]["x]gr{motion}
" [count]["x]grr
" {Visual}["x]gr
Plug 'vim-scripts/ReplaceWithRegister'

" http://vim.wikia.com/wiki/Moving_through_camel_case_words
" Plug 'chaoren/vim-wordmotion'

" ----------------------------------------------------------------------------
" Code support
" ----------------------------------------------------------------------------
Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
Plug 'EfforiaKnight/vim-cursorword'

" Syntax for almsot all types
Plug 'sheerun/vim-polyglot'

" Plug 'sbdchd/neoformat'
Plug 'w0rp/ale'
" Plug 'neomake/neomake'
Plug 'jiangmiao/auto-pairs'

" Change surround: cs<target><replace>
" Add surround: ys<text object><target>
" Delete surround: ds<target>
Plug 'tpope/vim-surround'

Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'EfforiaKnight/vim-slime'
" Plug 'jpalardy/vim-slime'

" ----------------------------------------------------------------------------
" Python support
" ----------------------------------------------------------------------------
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'Shougo/echodoc.vim', { 'for': 'python' }
Plug 'Shougo/neopairs.vim', { 'for': 'python' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" ----------------------------------------------------------------------------
" Icons plugin
" ----------------------------------------------------------------------------
Plug 'ryanoasis/vim-devicons'
call plug#end()
" }

" ================ Colors ================ {
syntax enable              " Enable syntax highlighting.
set termguicolors
set background=dark
"let g:onedark_terminal_italics=1
colorscheme solarized8
let g:solarized_term_italics = 1
let g:solarized_enable_extra_hi_groups = 1
hi Search cterm=underline ctermfg=124 gui=underline guifg=#af0000
" }

" ================ Encoding ================ {
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
" }

" ================ Folds ================ {
set foldmethod=marker     " fold based on marker level
set foldnestmax=5         " Limit folds when using indent or syntax
set foldenable            " Auto fold code
set foldlevelstart=1      " start with fold level of 1
set foldopen+=jump

" Improved Vim fold-text
" See: http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
function! FoldText()
    " Get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~? '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    " let foldSizeStr = '| ' . printf("%10s", foldSize . ' lines') . " | "
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat('↯', v:foldlevel)
    let lineCount = line('$')
    " let foldPercentage = printf('[%.1f', (foldSize*1.0)/lineCount*100) . '%] '
    let foldPercentage = ''
    let expansionString = repeat('·', w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction
set foldtext=FoldText()
" }

" ================ UI layout ================ {
set scrolloff=7            " Set 7 lines to the cursor - when moving vertically using j/k
set sidescrolloff=5
set number                 " Display line numbers
set ruler                  " Always show current position
" set signcolumn=yes

" Only have cursorline in current window and in normal window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline

set wildmenu               " Show list instead of just completing
set wildmode=list:longest,full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildignorecase

set laststatus=2           " Always show statusline.
set noshowmode             " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set shortmess=atIc         " Avoids hit enter
set report=0               " Always report changed lines.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.
" }

" ================ UI Special chars ================ {
set list                    " Show non-printable characters.
set showbreak=↪\
set linebreak
set listchars=tab:▷┅,extends:❯,precedes:❮,eol:¬,trail:·
set fillchars=diff:⣿,vert:│ " Change fillchars
set diffopt=vertical        " Use in vertical diff mode
set formatoptions+=n                  " smart auto-indenting inside numbered lists
" set textwidth   =79 " Set width of the wrap
" set colorcolumn =79 " Set color column

augroup trailing " Only show trailing whitespace when not in insert mode
    autocmd!
    autocmd InsertEnter * :set listchars-=trail:·
    autocmd InsertLeave * :set listchars+=trail:·
augroup END
" }

" ================ Spaces & Tabs ================ {
set autoindent             " Indent according to previous line.
set breakindent            " Indent wrapped lines to match start
set breakindentopt=shift:2 " Emphasize broken lines by indenting them
set expandtab              " Use spaces instead of tabs.
set softtabstop=2          " Tab key indents by 4 spaces.
set shiftwidth=2           " >> indents by 4 spaces.
set tabstop=2
set shiftround             " >> indents to next multiple of 'shiftwidth'.
filetype plugin indent on  " Load plugins according to detected filetype.
" }

" ================ Misc  ================ {
set hidden                 " Enable hidden buffers
set clipboard^=unnamedplus " Make default clipboard, system clipboard
set backspace =indent,eol,start  " Make backspace work as you would expect.
set lazyredraw             " Only redraw when necessary.
set autoread
set nojoinspaces           " J command doesn't add extra space
set mouse=a                " Enable mouse
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-iCursor-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20

" Keep the cursor on the same column
set nostartofline
set switchbuf=usetab                " try to reuse windows/tabs when switching buffers
set virtualedit=block               " allow cursor to move where there is no text in visual block mode
set whichwrap=b,h,l,s,<,>,[,],~     " allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries
set iskeyword-=/                    " Ctrl-W in command-line stops at /
set complete+=kspell                " Keyword completion brings in the dictionary if spell check is enabled

" Make sure there's a default dictionary for completion
if filereadable('/usr/share/dict/cracklib-small')
  set dictionary+=/usr/share/dict/cracklib-small
endif

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
    set inccommand=nosplit " Multiple substitute in window
endif
" }

" ================ Leader Map ================ {
let mapleader=','
let maplocalleader="\\"
" }

" ================ Custom mappings ================ {
" ----------------------------------------------------------------------------
" Remap ctrl-c for this issue:
" https://github.com/Shougo/deoplete.nvim/issues/460
" ----------------------------------------------------------------------------
" inoremap <C-c> <Esc>
inoremap <C-c> <C-[>:echom "Use C-[ instead!"<cr>

" ----------------------------------------------------------------------------
" Recover from accidental Ctrl-U
" http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
" ----------------------------------------------------------------------------
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" ----------------------------------------------------------------------------
" Clear search by Tim Pope https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim
" ----------------------------------------------------------------------------
"nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap <silent> <A-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" ----------------------------------------------------------------------------
" When jump to next match also center screen
" Note: Use :norm! to make it count as one command. (i.e. for i_CTRL-o)
" ----------------------------------------------------------------------------
nnoremap <silent> n :norm! nzz<CR>
nnoremap <silent> N :norm! Nzz<CR>
vnoremap <silent> n :norm! nzz<CR>
vnoremap <silent> N :norm! Nzz<CR>

" ----------------------------------------------------------------------------
" Same when moving up and down
" ----------------------------------------------------------------------------
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
vnoremap <C-u> <C-u>zz
vnoremap <C-d> <C-d>zz
vnoremap <C-f> <C-f>zz
vnoremap <C-b> <C-b>zz

" ----------------------------------------------------------------------------
" Refocus folds; close any other fold except the one that you are on
" ----------------------------------------------------------------------------
nnoremap <leader>z zMzvzz

" ----------------------------------------------------------------------------
" Repeat last macro if in a normal buffer.
" ----------------------------------------------------------------------------
nnoremap <silent> <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" ----------------------------------------------------------------------------
" Run `.` or macro over selected lines, taken from:
" https://reddit.com/r/vim/comments/3y2mgt
" ----------------------------------------------------------------------------
vnoremap . :normal .<CR>
vnoremap @ :normal @

" ----------------------------------------------------------------------------
" Remap H and L (top, bottom of screen to left and right end of line)
" ----------------------------------------------------------------------------
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" ----------------------------------------------------------------------------
" Visual linewise up and down by default (and use gj gk to go quicker)
" ----------------------------------------------------------------------------
" nnoremap j gj
" nnoremap k gk
vnoremap j gj
vnoremap k gk

" ----------------------------------------------------------------------------
" Store relative line number jumps in the jumplist if they exceed a threshold.
" ----------------------------------------------------------------------------
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'

" ----------------------------------------------------------------------------
" Don't yank to default register when changing something
" ----------------------------------------------------------------------------
nnoremap c "xc
xnoremap c "xc

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>rv :source $MYVIMRC<CR>:redraw<CR>:noh<CR>:echo $MYVIMRC 'Reloaded'<CR>

" ----------------------------------------------------------------------------
" Split
" ----------------------------------------------------------------------------
noremap <C-w><bar> :<C-u>vsplit<CR>
noremap <C-w>- :<C-u>split<CR>

" ----------------------------------------------------------------------------
" Change to current working directory
" ----------------------------------------------------------------------------
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>
nnoremap <leader>gcd :GitRootCD<cr>

" ----------------------------------------------------------------------------
" Open/close folds
" ----------------------------------------------------------------------------
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" ----------------------------------------------------------------------------
" Jump to previous match with f/t/F/T
" ----------------------------------------------------------------------------
nnoremap \ ,

" ----------------------------------------------------------------------------
" Toggle relative number column
" ----------------------------------------------------------------------------
noremap <leader>rn :set relativenumber!<CR>

" ----------------------------------------------------------------------------
" Move selected lines up and down
" ----------------------------------------------------------------------------
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ----------------------------------------------------------------------------
" Select last pasted text
" ----------------------------------------------------------------------------
nnoremap gp `[v`]

" ----------------------------------------------------------------------------
" Make Y consistent with C and D by yanking up to end of line
" ----------------------------------------------------------------------------
noremap Y y$

" ----------------------------------------------------------------------------
" <Leader>c Close quickfix/location window
" ----------------------------------------------------------------------------
" nnoremap <leader>c :cclose<bar>lclose<cr>
nnoremap  <leader>L :call ToggleLocationfix()<cr>
nnoremap  <leader>C :call ToggleQuickfix()<cr>

function! ToggleLocationfix() abort
  let l:lnr =  winnr("$")
  if l:lnr == 1
      silent! lopen
  else
      silent! lclose
  endif
endfunction

function! ToggleQuickfix() abort
  let l:cnr =  winnr("$")
  if l:cnr == 1
      silent! copen
  else
      silent! cclose
  endif
endfunction

" ----------------------------------------------------------------------------
" Quickfix / Location
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Repurpose cursor keys for one of my most oft-use key sequences
" ----------------------------------------------------------------------------
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------
" Markdown headings
" ----------------------------------------------------------------------------
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l


" ----------------------------------------------------------------------------
" [S]plit line (sister to [J]oin lines) S is covered by cc.
" ----------------------------------------------------------------------------
nnoremap S mzi<CR><ESC>`z

" ----------------------------------------------------------------------------
" Start substitute on current word under the cursor
" ----------------------------------------------------------------------------
nnoremap <leader>s :%s/<C-r><C-w>//gc<Left><Left><Left>
vnoremap <leader>s "xy:%s/<C-r>x//gc<left><left><left>

" ----------------------------------------------------------------------------
" Escape to normal mode in terminal
" ----------------------------------------------------------------------------
tnoremap <Esc> <C-\><C-n>

" ----------------------------------------------------------------------------
" Use Tab and S-Tab to select candidate
" ----------------------------------------------------------------------------
inoremap <expr><Tab>  pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<cr>"

" ----------------------------------------------------------------------------
" Maps for indentation in normal mode
" ----------------------------------------------------------------------------
nnoremap <tab> >>
nnoremap <s-tab> <<

xnoremap <tab> >gv
xnoremap <s-tab> <gv

" ----------------------------------------------------------------------------
" Spell toggle
" ----------------------------------------------------------------------------
imap <F9> <C-\><C-o>:setlocal spell!<CR>
nmap <F9> :setlocal spell!<CR>

" ----------------------------------------------------------------------------
" Restoring next list jump with remapping
" ----------------------------------------------------------------------------
nnoremap <A-o> <c-i>

" ----------------------------------------------------------------------------
" Fix spelling error on the go
" ----------------------------------------------------------------------------
inoremap <c-q> <c-g>u<Esc>[s1z=`]a<c-g>u
nnoremap <c-q> [s1z=<c-o>

" ----------------------------------------------------------------------------
" scroll slightly faster
" ----------------------------------------------------------------------------
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" ----------------------------------------------------------------------------
" qq to record, Q to replay
" ----------------------------------------------------------------------------
nnoremap Q @q

" ----------------------------------------------------------------------------
" Insert empty line above or below
" ----------------------------------------------------------------------------
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
" nnoremap <leader>O  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[+1
" nnoremap <leader>o :<c-u>put =repeat(nr2char(10), v:count1)<cr>']-1

" ----------------------------------------------------------------------------
" Quick save and close buffer
" ----------------------------------------------------------------------------
inoremap <C-s>              <ESC>:update<CR>
nnoremap <C-s>              :update<CR>
nnoremap <leader>w          :update<CR>
nnoremap <silent> <A-q>     :Sayonara!<CR>
nnoremap <silent> <A-k>     :Sayonara<CR>

nnoremap <silent> <A-Right> :call IntelligentVerticalResize('right')<CR>
nnoremap <silent> <A-Left>  :call IntelligentVerticalResize('left')<CR>
nnoremap <silent> <A-Up>    :resize +1<CR>
nnoremap <silent> <A-Down>  :resize -1<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
command! Wsudo w !sudo tee > /dev/null %
" ----------------------------------------------------------------------------
" Readline-style key bindings in command-line
" ----------------------------------------------------------------------------
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! exe "set <S-Left>=\<Esc>b"
silent! exe "set <S-Right>=\<Esc>f"

" ----------------------------------------------------------------------------
" <Leader>?/! | Google it / Feeling lucky
" ----------------------------------------------------------------------------
function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('xdg-open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
xnoremap <leader>? "gy:call <SID>goog(@g, 0)<cr>gv
xnoremap <leader>! "gy:call <SID>goog(@g, 1)<cr>gv

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

" ================ Auto Group Commands ================ {
" vim-python
" http://vi.stackexchange.com/questions/8772/how-can-i-fix-missing-syntax-highlighting-for-python-keywords-such-as-self/8773#8773
augroup NeoPython
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
        \ formatoptions+=croq softtabstop=4 textwidth=79
        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
        \ | let python_highlight_all=1
        \ | syn keyword pythonSelf self
        \ | highlight def pythonSelf cterm=italic gui=italic ctermfg=9 guifg=#cb4b16
        \ | setlocal completeopt-=preview
augroup END

augroup NumberToggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if empty(&buftype) | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if empty(&buftype) | set norelativenumber | endif
augroup END

augroup NeoFish
    autocmd!
    autocmd FileType fish setlocal foldmethod=expr
augroup END

augroup NeoMarkdown
    autocmd!
    autocmd FileType markdown,*commit* setlocal concealcursor=nc conceallevel=2
        \ | setlocal spell
augroup END

augroup Terminal
    autocmd TermOpen * set bufhidden=hide
    autocmd TermOpen * setlocal nospell
    autocmd TermOpen * startinsert
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
" <A-Right> <A-Left>
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

" Change to git root of current file (if in a repo)
function! FindGitRootCD()
  let root = systemlist('git -C ' . expand('%:p:h') . ' rev-parse --show-toplevel')[0]
  if v:shell_error
    return ''
  else
    return {'dir': root}
  endif
endfunction

function! GitRootCD()
  let result = FindGitRootCD()
  if type(result) == type({})
    execute 'lcd' fnameescape(result['dir'])
    echo 'Now in '.result['dir']
  else
    echo 'Not in git repo!'
  endif
endfunction
command! GitRootCD :call GitRootCD()
" }

" ================ Plugin: CursorWord configurations ================ {
set updatetime=400       " Match update highlight

" Toggle cursorword plugin
nnoremap <silent> <f4> :let g:cursorword=!get(g:, 'cursorword', 1)<CR>
" }

" ================ Plugin: FZF configurations ================ {
" set fzf's default input to AG instead of find. This also removes gitignore etc
let $FZF_DEFAULT_COMMAND = 'rg --files --smart-case --no-ignore --hidden --follow --no-messages --glob "!.git/*"'
let $FZF_DEFAULT_OPTS .= ' --inline-info -m --bind ctrl-a:select-all,ctrl-d:deselect-all,alt-t:toggle-all,alt-k:preview-up,alt-j:preview-down'

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('down:60%')
  \                         : fzf#vim#with_preview('right:60%:hidden', '?'),
  \                 <bang>0)

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('down:60%')
  \                         : fzf#vim#with_preview('right:60%:hidden', '?'),
  \                 <bang>0)

command! -nargs=? MRU
  \ call fzf#vim#history(fzf#vim#with_preview('right:60%:hidden', '?'))

if executable('rg')
    let s:rg_options = 'rg --no-messages --line-number --smart-case --hidden --follow --no-heading --color=always --glob "!.git/*" '
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   s:rg_options . shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)

    nnoremap <silent> <Leader>rg       :Rg <C-R><C-W><CR>
    nnoremap <silent> <Leader>RG       :Rg <C-R>=expand("<cWORD>")<CR><CR>
    xnoremap <silent> <Leader>rg       y:Rg <C-R>"<CR>
    set grepprg=rg\ --line-number\ --smart-case\ --no-messages\ --vimgrep
endif

if executable('ag')
    let s:ag_options = ' --one-device --color-match="31" --color-line-number="32" --color-path="35" --nogroup --follow --silent --hidden --ignore .git'
    command! -bang -nargs=* Ag
                \ call fzf#vim#ag(<q-args>,
                \                  s:ag_options,
                \                 <bang>0 ? fzf#vim#with_preview('down:60%')
                \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
                \                 <bang>0)

    nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
    nnoremap <silent> <Leader>AG       :Ag <C-R>=expand("<cWORD>")<CR><CR>
    xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
    "nnoremap <silent> <Leader>/        :Ag <CR>
    " set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
endif

command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

" nnoremap <silent> <Leader><Leader> :Files<CR>
" prevent fzf to open files inside NERD_tree buffer
nnoremap <silent> <expr> <C-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <expr> <M-S-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":GFiles\<cr>"

  " <M-p> for open buffers
nnoremap <silent> <M-Enter> :Buffers<cr>
nnoremap <silent> <Leader><Enter> :call fzf#vim#gitfiles('?')<CR>

nnoremap <silent> <Leader>` :Marks<CR>
nnoremap <silent> q:        :History:<CR>
nnoremap <silent> q/        :History/<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>p :MRU<CR>

imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = "--color --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d% %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" }

" ================ Plugin: Commentary configurations ================ {
noremap <leader>/ :Commentary<cr>
" }

" ================ Plugin: Incsearch configurations ================ {
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map n  <Plug>(incsearch-nohl-n)zzzv
map N  <Plug>(incsearch-nohl-N)zzzv

let g:incsearch#auto_nohlsearch = 1

" Keep cursor position across matches
let g:asterisk#keeppos = 1

" Emacs like keymaps
let g:incsearch#emacs_like_keymap=1

augroup incsearch-keymap
    autocmd!
    autocmd VimEnter * call s:incsearch_keymap()
augroup END

function! s:incsearch_keymap()
    IncSearchNoreMap <Tab> <Over>(buffer-complete)
    IncSearchNoreMap <S-Tab> <Over>(buffer-complete-prev)
    IncSearchNoreMap <C-j> <Over>(incsearch-next)
    IncSearchNoreMap <C-k>  <Over>(incsearch-prev)
endfunction

map *   <Plug>(incsearch-nohl)<Plug>(asterisk-*)zz
map g*  <Plug>(incsearch-nohl)<Plug>(asterisk-g*)zz " Whole word
map #   <Plug>(incsearch-nohl)<Plug>(asterisk-#)zz
map g#  <Plug>(incsearch-nohl)<Plug>(asterisk-g#)zz " Whole word

map z*  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)zz  " Stay
map gz* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)zz " Stay and whole word
map z#  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)zz  " Stay
map gz# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)zz " Stay and whole word


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

" ================ Plugin: Neoformat configurations ================ {
" let g:neoformat_python_yapf = {
"         \ 'exe': 'yapf',
"         \ 'args': ['based_on_style=pep8'],
"         \ }
" let g:neoformat_enabled_python = ['autopep8','yapf']
" nnoremap <leader>= :<C-u>Neoformat<cr>
" vnoremap <leader>= :Neoformat<cr>
" }

" ================ Plugin: IndentLine configurations ================ {
" IndentLine
let g:indentLine_char = '┊'
let g:indentLine_setColors = 0
"let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude = ['markdown','help']
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

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.spell = '✓'

let g:airline#extensions#ale#error_symbol = '✘ '
let g:airline#extensions#ale#warning_symbol = '⚠ '

" enable/disable vim-obsession integration
let g:airline#extensions#obsession#enabled = 1
" set marked window indicator string
let g:airline#extensions#obsession#indicator_text = '◈'

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
let g:NERDTreeIgnore = ['\~$', '.*\.pyc$', '.git$[[dir]]', '.swp', '__pycache__']
let g:NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowHidden=1
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeDirArrowExpandable="▸"
let g:NERDTreeDirArrowCollapsible="▾"
nnoremap <F1> :call NERDTreeToggleFind()<CR>

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

function! NERDTreeToggleFind()
    " Focus on NERDTree if it's open and not Focused
    " Close NERDTree and jump back to original window
    " Execute NERDTreeFind if NERDTree not open
    if exists("g:NERDTree.IsOpen") && g:NERDTree.IsOpen() && !exists("b:NERDTree")
        NERDTreeFocus
    elseif exists("b:NERDTree")
        wincmd q
        wincmd p
    else
        NERDTreeFind
    endif
endfunction

augroup NeoNERDTree
    autocmd!
    " Close vim if the only window left open is a NERDTree
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
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
let g:ale_linters = {
\   'python': ['flake8'],
\}
let g:ale_fixers = {
\    'python': ['yapf', 'add_blank_lines_for_python_control_statements', 'remove_trailing_lines'],
\}

let g:ale_python_flake8_options = '--ignore=E501'

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '➤'
let g:ale_sign_info = 'ℹ'
highlight link ALEErrorSign DiffDelete
highlight link ALEWarningSign DiffChange
let g:ale_sign_column_always = 1
" let g:ale_statusline_format = ['✘ %d', '⚠ %d', '✓ ok']
" let g:ale_lint_delay = 1000
nmap <leader>= <Plug>(ale_fix)
nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)
" }

" ================ Plugin: Neomake configurations ================ {
" Run NeoMake on read and write operations
" autocmd! BufReadPost,BufWritePost * Neomake

" When writing a buffer, and on normal mode changes (after 750ms).
" call neomake#configure#automake('nw', 750)
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

" ================ Plugin: Undotree configurations ================ {
nnoremap <F7> :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
" }

" ================ Plugin: Polyglot configurations ================ {
let g:polyglot_disabled = ['python'] " Neovim python syntax is better
" }

" ================ Plugin: VimSlime configurations ================ {
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_default_config = {"socket_name": "default", "target_pane": "2"}
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1
" }

" ================ Plugin: Bullets ================ {
  " let g:bullets_enabled_file_types = ['markdown', 'text', 'gitcommit']
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
