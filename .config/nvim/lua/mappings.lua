local map = function(mode, mapping, command)

end
":inoremap lk <Esc>
" vnoremap lk <Esc>
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
cnoremap <C-j> <C-n>
cnoremap <C-k> <C-p>
nnoremap <silent> <leader>B :b#<CR>
" nnoremap <leader>b :b 
nnoremap <leader>e :cc<CR>
" nnoremap <leader>v :vsplit<CR><C-w>w
nnoremap <leader>w <C-w>
" nnoremap <silent> <tab> <C-w><C-w>:if &buftype==#'quickfix'\|wincmd w\|endif<CR>
nnoremap <silent> <leader>q :q!<CR>
nnoremap <silent> <leader>Q :qa!<CR>
nnoremap <silent> <leader>s :w<CR>
nnoremap <silent> <leader>x :x<CR>
nnoremap <silent> <leader>X :xa<CR>
nnoremap <silent> <leader>v <C-v>
nnoremap <silent> ]t :tabn<CR>
nnoremap <silent> [t :tabp<CR>
" nnoremap <leader>b :b 
" nnoremap <leader>z :%foldclose<CR>
" nnoremap <leader>Z :%foldopen<CR>
nnoremap <silent> ]c :<C-u>cnext<CR>
nnoremap <silent> [c :<C-u>cprevious<CR>
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

set wildcharm=<C-z>
cnoremap <expr> <Tab>   getcmdtype() =~ '[\/?]' ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[\/?]' ? "<C-t>" : "<S-Tab>"
" nnoremap <silent> <leader>m :silent make!\|redraw!\|cw<CR>
" Terminal mappings
tnoremap <C-]> <C-\><C-n>
" TermDebugger mappings
nnoremap <silent> <leader>m :w<CR>:Neomake! make<CR>
nnoremap <silent> <leader>d :w<CR>:Neomake! debug<CR>
nmap <silent> ,n :Over<CR>
nmap <silent> ,s :Step<CR>
nmap <silent> ,c :call TermDebugSendCommand('continue')<CR>
nmap <silent> ,B :Clear<CR>
nmap <silent> ,e :Evaluate<CR>
nmap <silent> ,b :Break<CR>
nmap <silent> ,ib :call TermDebugSendCommand('info break')<CR>
nmap <silent> ,iw :call TermDebugSendCommand('info watch')<CR>
nmap <silent> ,d :call TermDebugSendCommand('delete')<CR>
nmap <silent> ,q :Gdb<CR>:startinsert<CR>q<CR>:redraw!
nmap <silent> ,r :Run<CR>
let s:fivep = float2nr(0.10*winheight(0))
-- exec "nnoremap J ".s:fivep."<C-e>"
-- exec "nnoremap K ".s:fivep."<C-y>"
exec "nnoremap L " . &l:scrolloff . "L"
exec "nnoremap H " . &l:scrolloff . "H"
