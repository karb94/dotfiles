"Settings
let &t_SI.="\e[6 q"             "Change cursor shape in insert mode
let &t_EI.="\e[2 q"             "Change cursor shape in normal mode
"For CX1
if $HOSTNAME !~ "login-[0-9][0-9]*"
    let &t_SR.="\e[4 q"         "Change cursor shape in replace mode
endif
set signcolumn=no               "Vim gutter always active
set shortmess=F                 "Suppresses the file info message
set nohlsearch                  "no highlights during search
" set number relativenumber       "set relative number on
set nonumber                    "set line number off
set incsearch                   "starts searching while you type
set ignorecase                  "Ingores case in searches
set smartcase                   "In combination with ignorecase, only ignores case when no uppercase is used
set tabstop=4                   "The tab key produces 4 'visual' spaces (only in vim, thus the need for expandtab)
set expandtab                   "Converts tabs into spaces
set path+=**                    "You can search for any file in any subdirectory (as long as you enter the exact name)
set wildmenu                    "It opens a horizontal menu where you cycle with <Tab> and <S-Tab>
set wildmode=longest:full,full  "Will complete to the longest common command
autocmd InsertEnter * set timeoutlen=200    "Time waited for mappings
autocmd InsertLeave * set timeoutlen=600    "Time waited for mappings
set shiftwidth=4                "Sets the number of spaces when indenting with '>>'
set autoindent                  "Sets new line with same indentation as current line
set smartindent                 "Auto-indents for {
let g:os = substitute(system('uname'), '\n', '', '')
if g:os == "Darwin"
    set clipboard=unnamed       "Copies to the general MacOS clipboard
    autocmd VimLeave * call system("xsel -ib", getreg('*'))
elseif g:os == "Linux"
    set clipboard=unnamedplus   "Copies to the Secondary Linux clipboard
    autocmd VimLeave * call system("xsel -ib", getreg('+'))
endif
let mapleader=" "               "Sets leader key

" call has('python3')
"Plugins
call plug#begin()
Plug 'terryma/vim-smooth-scroll'
Plug 'karb94/vim-sneak'
Plug 'morhetz/gruvbox'
Plug 'chrisbra/Colorizer'
call plug#end()

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 5, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 5, 1)<CR>
noremap <silent> K :call smooth_scroll#up(5, 20, 1)<CR>
noremap <silent> J :call smooth_scroll#down(5, 20, 1)<CR>

"Sneak
let g:sneak#use_ic_scs = 1
let g:sneak#map_netrw = 0
let g:sneak#target_labels = ";ftuvnqz/SFGHLTUNRMQZ"
let g:sneak#label = 1
nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>

"Mappings
inoremap lk <Esc>
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
vnoremap lk <Esc>
nnoremap <leader>c mbI#<Esc>`b
nnoremap <leader>u mb^x`b
nnoremap <leader>v :vsplit<CR><C-w>w
nnoremap <C-w> <C-w>w
nnoremap <leader>q :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>o mbo<Esc>`b
nnoremap <leader>O mbO<Esc>`b
nnoremap <silent><leader>o :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><leader>O :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap Y y$
nnoremap <leader>p :put<CR>
nnoremap <leader>rc :source $MYVIMRC<CR>
nnoremap <leader>j J
nnoremap H ^
nnoremap L $
nnoremap U :redo<CR>

nmap <leader>m :!clear; make -C build/<CR>

"Color
" highlight Prompt ctermfg=2 ctermbg=0 cterm=bold
" syntax match Prompt "^.*\$"

"Status bar
set laststatus=2    " Always show status bar
set statusline=%f%r%m%=%P

" Gruvbox
set termguicolors
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'soft'
set background=light

" Reset cursor on start:
augroup initialization
    au!
    " Colorizer only works on new files not buffers so
    " Needs to be activated explicitly
    autocmd VimEnter * :ColorHighlight
    " autocmd VimEnter * :normal! :startinsert :stopinsert G   "Reset cursor shape
    " autocmd VimEnter * :%s/\v\e.{-}m//ge
augroup END
