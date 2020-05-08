" vim: set foldmethod=marker foldlevel=1 nomodeline:

" Check what os is vim running under
let g:os = substitute(system('uname'), '\n', '', '')

"==============================================================================
" SETTINGS
"==============================================================================
" {{{

" For CX1
" if $HOSTNAME !~ "login-[0-9][0-9]*"
"     " Change cursor shape in insert mode
"     let &t_SR="\e[4 q"
"     " Vim gutter always active
"     set signcolumn=yes
" endif

" Change cursor shape for start and end of insert mode and replace mode
" mode
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"
let &t_SR="\e[4 q"

" Set leader key
let mapleader=" "

" Notification area text options
set shortmess=mwoOcIF

" Persistent central location for undo files
set undofile undodir=~/.config/nvim/undodir

" Use ~/.vim/swp to store swap files
set directory^=~/.config/nvim/swp

" change unsaved buffers
set hidden

" Backspace behaves like everywhere else
set backspace=indent,eol,start

" Show relative line numbers and current line number
set relativenumber number

" Show cursorline, colorcolumn and signcolumn
set cursorline colorcolumn=81 signcolumn=yes

" Less laggy than syntax mode
set foldmethod=manual

" Sets g flag on all substitutions by default
set gdefault

" Incremental smart case highlight search
set incsearch smartcase ignorecase hlsearch

" Live substitution command
if has('nvim')
    set inccommand=split
endif

" Fix redrawing issues only with fast connections
" if !has('nvim')
"     let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
"     let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"     set ttyscroll=1
"     set t_ut=""
" endif
" set ttyscroll=1

" Sets scrolloff to 20% of window height
let &scrolloff=float2nr(0.15*winheight(0))

" Greedy command line completion
set wildignorecase wildmenu wildmode=longest:full,full

" 4 whitespaces for <Tab> and indent. Auto-smart indent.
set tabstop=4 expandtab shiftwidth=4 autoindent smartindent

"Status bar
set laststatus=2    " Always show status bar
" set statusline=\ %f\ %y\ %r\ %m%=Column:\ %c\ \ \|\ \ %P\ \ 

" Time waited for key codes
set ttimeoutlen=0
autocmd InsertEnter * set timeoutlen=200 " Time waited for mappings
autocmd InsertLeave * set timeoutlen=600 " Time waited for mappings

" Set python3 bin path
if g:os == "Darwin"
    let g:python3_host_prog='$HOME/miniconda3/envs/neovim/bin/python'
elseif g:os == "Linux"
    let g:python3_host_prog='$HOME/.conda/envs/neovim/bin/python'
endif

" Set vim path
" Set a base &path

set path=.,,
" If inside git repo, add git directory to path
function! Set_git_path()
    call system("git rev-parse --is-inside-work-tree")
    let g:inside_git_repo = v:shell_error == 0
    if g:inside_git_repo
        let g:git_root_dir=trim(system("git rev-parse --show-toplevel"))
        let &path = g:git_root_dir
        let l:git_dirs = systemlist("git ls-tree -dr --full-tree --name-only HEAD")
        if empty(l:git_dirs)
            return
        endif
        let l:git_abs_dirs = map(l:git_dirs, { idx, val -> g:git_root_dir . '/' . val })
        let &path .= ',' . join(l:git_abs_dirs, ',')
    endif
endfunction
call Set_git_path()
" }}}


"==============================================================================
" CALL PLUGINS
"==============================================================================
" {{{

call plug#begin()

Plug 'machakann/vim-sandwich'

Plug 'tpope/vim-commentary'

Plug 'wellle/targets.vim'

Plug 'romainl/vim-cool'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
let g:fzf_layout = { 'window': {
            \ 'width': 1.0,
            \ 'height': 0.3,
            \ 'yoffset': 1.0
            \ } }
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>r :History:<CR>
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>g :Rg<CR>
" }}}

Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'py' }

Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }

Plug 'morhetz/gruvbox'

Plug 'junegunn/vim-easy-align'
" {{{
let g:easy_align_ignore_groups = []
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

Plug 'justinmk/vim-sneak'
" {{{
" let g:sneak#no_default_mappings = 1
let g:sneak#use_ic_scs = 1
let g:sneak#map_netrw = 0
let g:sneak#target_labels = ";ftuvnqz/SFGHLTUNRMQZ"
let g:sneak#label = 1
highlight Sneak ctermfg=Black ctermbg=226 cterm=bold
nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
" }}}

call plug#end()
" }}}


"==============================================================================
" MAPPINGS
"==============================================================================
" {{{
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
nnoremap <silent> <leader>B :b#<CR>
nnoremap <leader>v :vsplit<CR><C-w>w
nnoremap <C-w> <C-w>w
nnoremap <silent> <leader>q :q!<CR>
nnoremap <silent> <leader>Q :qa!<CR>
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>x :x<CR>
nnoremap <silent> <leader>X :xa<CR>
nnoremap <silent> <leader>o :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent> <leader>O :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <silent> <leader>p :put<CR>=`[
nnoremap <silent> <leader>P :put!<CR>=`[
nnoremap <silent> Y yg_
nnoremap <silent> p pm`=`]``
nnoremap <silent> P Pm`=`]``
nnoremap <leader>rc :source $MYVIMRC<CR>
nnoremap <silent> <leader>j J
nnoremap U :redo<CR>
let s:fivep = float2nr(0.10*winheight(0))
exec "nnoremap J ".s:fivep."<C-e>"
exec "nnoremap K ".s:fivep."<C-y>"

set wildcharm=<C-z>
cnoremap <expr> <Tab>   getcmdtype() =~ '[\/?]' ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[\/?]' ? "<C-t>" : "<S-Tab>"
nnoremap <leader>e :e **/*
" nnoremap <silent> <leader>m :silent make!\|redraw!\|cw<CR>

" }}}


"==============================================================================
" COLORSCHEME
"==============================================================================
" {{{

if has_key(plugs, 'gruvbox')
    let g:gruvbox_sign_column = 'bg0'
    set termguicolors
    colorscheme gruvbox
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_contrast_light = 'soft'
    let g:gruvbox_sign_column = 'bg0'
    set background=dark
endif

" }}}

"==============================================================================
" AUTOCOMMANDS
"==============================================================================
" {{{

set clipboard+=unnamedplus
" Add yanked text to main clipboard
" if g:os == "Darwin"
"     set clipboard=unnamed
"     autocmd VimLeave * call system("xsel -ib", getreg('*'))
" elseif g:os == "Linux"
"     set clipboard=unnamedplus
"     autocmd VimLeave * call system("xsel -ib", getreg('+'))
" endif

" Reset cursor on start
" Disable cursorline and relativenumber when buffer is not on focus
augroup initialization
    au!
    autocmd WinEnter * set relativenumber cursorline
    autocmd WinLeave * set norelativenumber nocursorline
augroup END
