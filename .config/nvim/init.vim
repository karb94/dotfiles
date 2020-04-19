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
set cursorline colorcolumn=80 signcolumn=yes

" Less laggy than syntax mode
set foldmethod=manual

" Sets g flag on all substitutions by default
set gdefault

" Incremental smart case highlight search
set incsearch smartcase ignorecase hlsearch

" Fix redrawing issues only with fast connections
" if !has('nvim')
"     let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
"     let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"     set ttyscroll=1
"     set t_ut=""
" endif

" Sets scrolloff to 20% of window height
let &scrolloff=float2nr(0.15*winheight(0))

" Greedy command line completion
set wildmenu wildmode=longest:full,full

" 4 whitespaces for <Tab> and indent. Auto-smart indent.
set tabstop=4 expandtab shiftwidth=4 autoindent smartindent

"Status bar
set laststatus=2    " Always show status bar
set statusline=\ %f\ %y\ %r\ %m%=Column:\ %c\ \ \|\ \ %P\ \ 

" Fix stupid python double indenting
" let g:pyindent_open_paren = 'shiftwidth()'
" let g:pyindent_continue = 'shiftwidth()'

" Time waited for key codes
set ttimeoutlen=0
autocmd InsertEnter * set timeoutlen=200 " Time waited for mappings
autocmd InsertLeave * set timeoutlen=600 " Time waited for mappings

" hi Normal guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
" let &t_ti = &t_ti . "\033]10;#ebdbb2\007\033]11;#1d2021\007"
" let &t_te = &t_te . "\033]110\007\033]111\007"

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

Plug 'karb94/vim-smoothie'
" {{{
let g:smoothie_update_interval = 1
let g:smoothie_base_speed = 30
" }}}

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

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" {{{
let g:semshi#mark_selected_nodes = 0
" }}}

Plug 'neomake/neomake'

Plug 'junegunn/vim-easy-align'
" {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

Plug 'karb94/jupytext.vim'
" {{{
let g:jupytext_fmt = 'py:light'
autocmd BufRead,BufNewFile *.ipynb set foldmethod="marker"
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

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" {{{
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=50
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
" Introduce function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" }}}

Plug 'SirVer/ultisnips'
" {{{
"Stupid workaround
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-n>"
let g:UltiSnipsJumpBackwardTrigger="<C-p>"
let g:UltiSnipsEditSplit="vertical"
" }}}

Plug 'lervag/vimtex', { 'for': ['tex','bib'] }
" {{{
let g:tex_conceal=""
if has('mac')
    let g:vimtex_compiler_progname = '~//usr/local/bin/vim'
endif
let g:vimtex_compiler_latexmk = {
            \ 'backend' : 'jobs',
            \ 'background' : 1,
            \ 'build_dir' : 'build',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'hooks' : [],
            \ 'options' : [
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}
" Disable overfull/underfull \hbox and all package warnings
let g:vimtex_quickfix_latexlog = {
            \ 'packages' : {
            \   'default' : 0,
            \ },
            \}
let g:vimtex_view_method = 'zathura'
" }}}

call plug#end()
" }}}


"==============================================================================
" MAPPINGS
"==============================================================================
" {{{
" inoremap lk <Esc>
" vnoremap lk <Esc>
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
nnoremap <leader>c mbI#<Esc>`b
nnoremap <leader>u mb^x`b
nnoremap <leader>B :b#<CR>
nnoremap <leader>v :vsplit<CR><C-w>w
nnoremap <C-w> <C-w>w
nnoremap <leader>q :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>X :xa<CR>
nnoremap <leader>z :%foldclose<CR>
nnoremap <leader>Z :%foldopen<CR>
nnoremap <silent><leader>o :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><leader>O :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <leader>p :put<CR>=`[
nnoremap Y yg_
nnoremap p pm`=`]``
nnoremap P Pm`=`]``
nnoremap <leader>rc :source $MYVIMRC<CR>
nnoremap <leader>j J
nnoremap U :redo<CR>
" let s:fivep = float2nr(0.10*winheight(0))
" exec "nnoremap J ".s:fivep."<C-e>"
" exec "nnoremap K ".s:fivep."<C-y>"

set wildcharm=<C-z>
cnoremap <expr> <Tab>   getcmdtype() =~ '[\/?]' ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[\/?]' ? "<C-t>" : "<S-Tab>"
nnoremap <leader>e :e **/*

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
" FUNCTIONS
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
    " autocmd VimEnter * :normal! :startinsert :stopinsert    "Reset cursor shape
    autocmd WinEnter * set relativenumber cursorline
    autocmd WinLeave * set norelativenumber nocursorline
augroup END

" Highlight match pattern in search but disable highlight after committing
" Not necessary with vim-cool
" augroup vimrc-incsearch-highlight
"     autocmd!
"     autocmd CmdlineEnter /,\? :set hlsearch
"     autocmd CmdlineLeave /,\? :set nohlsearch
" augroup END

" }}}
