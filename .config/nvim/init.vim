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

" Allow mouse interaction in normal mode
set mouse=n

" Show cursorline, colorcolumn and signcolumn
set cursorline colorcolumn=81 signcolumn=yes

" Less laggy than syntax mode
set foldmethod=manual

" Sets g flag on all substitutions by default
set gdefault

" Incremental smart case highlight search
set incsearch smartcase ignorecase hlsearch

" Live substitution command
set inccommand=split

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
set wildignorecase wildmenu wildmode=full

" 4 whitespaces for <Tab> and indent. Auto-smart indent.
set tabstop=4 expandtab shiftwidth=4 autoindent smartindent
" set expandtab autoindent smartindent

"Status bar
set laststatus=2    " Always show status bar
" set statusline=\ %f\ %y\ %r\ %m%=Column:\ %c\ \ \|\ \ %P\ \ 

" Time waited for key codes
set ttimeoutlen=0
autocmd InsertEnter * set timeoutlen=200 " Time waited for mappings
autocmd InsertLeave * set timeoutlen=600 " Time waited for mappings

" Set python3 bin path
" if g:os == "Darwin"
let g:python3_host_prog='$HOME/miniconda3/envs/neovim/bin/python'
" endif

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
Plug 'tpope/vim-fugitive'
Plug 'wellle/targets.vim'
Plug 'romainl/vim-cool'
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'py' }
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'morhetz/gruvbox'

" Google auto-formating
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

Plug 'junegunn/goyo.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
let g:fzf_layout = { 'window': {
            \ 'width': 1.0,
            \ 'height': 0.3,
            \ 'yoffset': 1.0
            \ } }
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>R :History:<CR>
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>g :Rg<CR>
" }}}

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" {{{
let g:semshi#excluded_hl_groups = ['local','unresolved','parameterUnused']
let g:semshi#mark_selected_nodes = 0
let g:semshi#error_sign = v:false
" }}}

Plug 'neomake/neomake'
" {{{
let g:neomake_virtualtext_current_error=0
function! MyStatusNeomake(buf)
    return neomake#statusline#get(a:buf, {
                \ 'format_running': '[Compiling...]',
                \ 'format_loclist_unknown': '',
                \ 'format_quickfix_issues': '',
                \ })
endfunction

" This function, given a buffer number, returns the current statusline for it.
" it will be called very often.
function! StatusLine(buf)
    return "\ %f\ %y\ %r\ %m"
                \ . MyStatusNeomake(a:buf)
                \ . "%=Column:\ %c\ \ \|\ \ %P\ \ "
endfunction

" This function is set as the initial statusline, but quickly commits suicide
" by setting a local statusline that will always be called with the correct
" buffer number.
function! SetStatusLine()
    let &l:statusline = '%!StatusLine(' . bufnr('%') . ')'
endfunction

" This installs the above setter.
set statusline=%!SetStatusLine()
let g:neomake_open_list = 2
nnoremap <silent> <leader>m :w<CR>:Neomake!<CR>
" }}}

Plug 'junegunn/vim-easy-align'
" {{{
let g:easy_align_ignore_groups = []
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
nmap <leader>i <Plug>(coc-diagnostic-info)
nmap <silent> ]e <Plug>(coc-diagnostic-next)
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> <leader>h :CocCommand clangd.switchSourceHeader<CR>
nmap <silent> gd <Plug>(coc-definition)
" Introduce function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
"CocList
nnoremap <silent> <leader>gm :CocList --normal --no-sort outline -kind Method<CR>

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
" Prevents detecting 'latex' files as 'plain tex' files
let g:tex_flavor = 'latex'
let g:tex_conceal=""
if has('mac')
    let g:vimtex_compiler_progname = '~//usr/local/bin/vim'
endif
let g:vimtex_compiler_latexmk = {
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
" POST-PLUG
"==============================================================================
" Google auto-formating
call glaive#Install()
" coc-python
if $CONDA_PREFIX == ""
    let s:current_python_path="$HOME/miniconda3/envs/default"
else
    let s:current_python_path=$CONDA_PREFIX.'/bin/python'
endif
call coc#config('python', {'pythonPath': s:current_python_path})


"==============================================================================
" MAPPINGS
"==============================================================================
" {{{
" inoremap lk <Esc>
" vnoremap lk <Esc>
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
nnoremap <silent> <leader>B :b#<CR>
" nnoremap <leader>b :b 
nnoremap <leader>e :cc
" nnoremap <leader>v :vsplit<CR><C-w>w
" nnoremap <C-w> <C-w>w
nnoremap <silent> <leader>q :q!<CR>
nnoremap <silent> <leader>Q :qa!<CR>
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>x :x<CR>
nnoremap <silent> <leader>X :xa<CR>
" nnoremap <leader>b :b 
" nnoremap <leader>z :%foldclose<CR>
" nnoremap <leader>Z :%foldopen<CR>
nnoremap <silent> <leader>o :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent> <leader>O :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <silent> <leader>p :put<CR>=`[
nnoremap <silent> <leader>P :put!<CR>=`[
nnoremap <silent> Y yg_
nnoremap <silent> p pm`=`]``
nnoremap <silent> P Pm`=`]``
" nnoremap <leader>rc :source $MYVIMRC<CR>
nnoremap <silent> <leader>j J
nnoremap U :redo<CR>
let s:fivep = float2nr(0.10*winheight(0))
exec "nnoremap J ".s:fivep."<C-e>"
exec "nnoremap K ".s:fivep."<C-y>"

set wildcharm=<C-z>
cnoremap <expr> <Tab>   getcmdtype() =~ '[\/?]' ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[\/?]' ? "<C-t>" : "<S-Tab>"
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
fun! ToggleReadingMode()
    if !exists('b:ReadingMode')
        let b:ReadingMode=1
        normal M
        set nonumber norelativenumber nocursorline colorcolumn=
        exec "nnoremap J ".s:fivep."<C-e>M"
        exec "nnoremap K ".s:fivep."<C-y>M"
        nnoremap j <C-e>M
        nnoremap k <C-y>M
        nnoremap d <C-d>M
        nnoremap u <C-u>M
    else
        unlet b:ReadingMode
        set number relativenumber cursorline colorcolumn=81
        exec "nnoremap J ".s:fivep."<C-e>"
        exec "nnoremap K ".s:fivep."<C-y>"
        nunmap j
        nunmap k
        nunmap d
        nunmap u
    endif
endfun
nnoremap <silent> <leader>r :call ToggleReadingMode()<CR>
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
    " autocmd VimEnter * :normal! :startinsert :stopinsert    "Reset cursor shape
    " autocmd WinEnter * set cursorline
    " autocmd WinLeave * set nocursorline
    autocmd BufWinEnter * if &l:buftype == '' | set relativenumber cursorline | endif
    autocmd BufWinLeave * if &l:buftype == '' | set norelativenumber nocursorline | endif
    autocmd BufWinEnter * if &l:buftype == 'help' | call ToggleReadingMode() | endif
    autocmd BufWinLeave * if &l:buftype == 'help' | call ToggleReadingMode() | endif
    " autocmd Filetype markdown set conceallevel=2
    " autocmd Filetype markdown call matchadd('Conceal', '\v(\[[^\]]*\])@<=\_s?\(.*\)', 10)
augroup END
