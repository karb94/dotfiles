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
set number relativenumber       "set relative number on
set incsearch                   "starts searching while you type
set ignorecase                  "Ingores case in searches
set smartcase                   "In combination with ignorecase, only ignores case when no uppercase is used
autocmd InsertEnter * set timeoutlen=200    "Time waited for mappings
autocmd InsertLeave * set timeoutlen=600    "Time waited for mappings
let g:os = substitute(system('uname'), '\n', '', '')
if g:os == "Darwin"
    set clipboard=unnamed       "Copies to the general MacOS clipboard
    autocmd VimLeave * call system("xsel -ib", getreg('*'))
elseif g:os == "Linux"
    set clipboard=unnamedplus   "Copies to the Secondary Linux clipboard
    autocmd VimLeave * call system("xsel -ib", getreg('+'))
endif
let mapleader=" "               "Sets leader key
noremap <leader>q :q!<CR>

" call has('python3')
"Plugins
call plug#begin()
Plug 'karb94/vim-smoothie'
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

"Status bar
" set laststatus=2    " Always show status bar
" set statusline=%f%r%m%=%P

" Gruvbox
set termguicolors
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'soft'
set background=dark

" Reset cursor on start:
autocmd VimEnter * :ColorHighlight
