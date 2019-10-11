filetype off
filetype plugin on
syntax on
syntax enable


"Settings
let &t_SI.="\e[6 q"             "Change cursor shape in insert mode
let &t_SR.="\e[4 q"             "Change cursor shape in replace mode
let &t_EI.="\e[2 q"             "Change cursor shape in normal mode
set nohlsearch                  "no highlights during search
set number relativenumber       "set relative number on
set incsearch                   "starts searching while you type
set ignorecase                  "Ingores case in searches
set smartcase                   "In combination with ignorecase, only ignores case when no uppercase is used
set tabstop=4                   "The tab key produces 4 'visual' spaces (only in vim, thus the need for expandtab)
set expandtab                   "Converts tabs into spaces
set path+=**                    "You can search for any file in any subdirectory (as long as you enter the exact name)
set wildmenu                    "It opens a horizontal menu where you cycle with <Tab> and <S-Tab>
set wildmode=longest:full,full  "Will complete to the longest common command
autocmd InsertEnter * set timeoutlen=100    "Time waited for mappings
autocmd InsertLeave * set timeoutlen=600    "Time waited for mappings
set shiftwidth=4                "Sets the number of spaces when indenting with '>>'
set autoindent                  "Sets new line with same indentation as current line
set smartindent                 "Auto-indents for {
set signcolumn=yes
let mapleader=" "               "Sets leader key


"Install the plugin manager vim-plug if it is not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call has('python3')
"Plugins
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ycm-core/YouCompleteMe', { 'do': '/usr/bin/python ./install.py --clang-completer >> logfile' }
Plug 'SirVer/ultisnips'
call plug#end()

"Sneak
map <leader>f <Plug>Sneak_s
map <leader>F <Plug>Sneak_S
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
let g:sneak#target_labels = ";ftuvnqz/SFGHLTUNRMQZ"

nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
let g:sneak#label = 1

"Fuzzy Finder (FZF)
nnoremap <leader>b :Buffers<CR>
nnoremap <C-r> :History:<CR>
nnoremap <C-t> :Files<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>g :Rg<CR>

"" YouCompleteMe
let g:ycm_key_list_select_completion=['<C-n>','<Tab>']
let g:ycm_key_list_previous_completion=['<C-p>','<S-Tab>']
let g:ycm_max_num_identifier_candidates = 3
let g:ycm_max_num_candidates = 5

"" Ultisnips
"Stupid workaround
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="**"
let g:UltiSnipsJumpForwardTrigger="<C-n>"
let g:UltiSnipsJumpBackwardTrigger="<C-p>"
let g:UltiSnipsEditSplit="vertical"

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
nnoremap <leader>p :put<CR>
nnoremap <leader>rc :source $MYVIMRC<CR>
nnoremap <leader>j J
nnoremap J 3<C-e>
nnoremap K 3<C-y>
nnoremap U :redo<CR>

nmap <leader>m :!clear; make -C build/<CR>

"Color
colorscheme peachpuff
highlight SpellBad cterm=bold ctermfg=9 ctermbg=0
highlight LineNr ctermfg=Yellow
highlight CursorLineNr ctermfg=Yellow
highlight Normal ctermfg=White
highlight Visual ctermbg=Black ctermfg=202
highlight incsearch ctermbg=Black ctermfg=202
highlight Pmenu ctermbg=233 ctermfg=White
highlight PmenuSel ctermbg=18 ctermfg=White
highlight MatchParen ctermbg=Black ctermfg=202
highlight Comment ctermbg=Black ctermfg=202
highlight SignColumn ctermbg=Black
highlight Error ctermbg=Black ctermfg=Red

"Status bar
set laststatus=2
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermbg=Yellow ctermfg=0
  elseif a:mode == 'r'
    hi statusline ctermbg=Red  ctermfg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline  ctermbg=21 ctermfg=Black

" default the statusline to green when entering Vim
hi statusline ctermbg=21 ctermfg=Black
set statusline=%f%r%m%=%P
