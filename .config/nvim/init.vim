" vim: set foldmethod=marker foldlevel=0:
" Check what os is vim running under
" let g:os = substitute(system('uname'), '\n', '', '')

"==============================================================================
" SETTINGS
"==============================================================================
" {{{
lua require('options')
" }}}

"==============================================================================
" CALL PLUGINS
"==============================================================================
"" {{{

"packadd termdebug
"" QUICK PLUGIN OPTIONS
"" vim-highlightedyank

call plug#begin()
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

" Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'lua'}
Plug 'junegunn/vim-easy-align'
" {{{
let g:easy_align_ignore_groups = []
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
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
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'
let g:tex_conceal=""
let g:vimtex_compiler_latexmk = {
            \ 'background' : 1,
            \ 'build_dir' : 'build',
            \ 'callback' : 1,
            \ 'continuous' : 0,
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
" let g:vimtex_quickfix_latexlog = {
"             \ 'packages' : {
"             \   'default' : 0,
"             \ },
"             \}
let g:vimtex_view_method = 'zathura'
let g:vimtex_grammar_textidote = {
            \ 'jar': '/opt/textidote/textidote.jar',
            \ 'args': '',
            \}
" }}}

call plug#end()

lua require('plugins')
" }}}

"==============================================================================
" POST-PLUG
"==============================================================================
" {{{

" }}}

"==============================================================================
" MAPPINGS
"==============================================================================
" {{{
" inoremap lk <Esc>
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
exec "nnoremap J ".s:fivep."<C-e>"
exec "nnoremap K ".s:fivep."<C-y>"
" }}}

"==============================================================================
" COLORSCHEME
"==============================================================================
" {{{

" }}}

"==============================================================================
" FUNCTIONS
"==============================================================================
" {{{

function! SmallWordMotion(count, vmode, forward, start)
    let l:flag = a:forward ? '' : 'b'
    let l:flag = a:start ? l:flag : l:flag . 'e'
    let l:regex = '\C\v(\u?\l+|\u+|[^A-Za-z ]{2,}|(^|\s)\zs[^A-Za-z ]+(\s|$))'
    if a:vmode
        normal gv
    endif
    for _ in range(a:count)
        call search(l:regex, l:flag, line('.'))
    endfor
endfunction
nnoremap <silent> w :<C-u>call SmallWordMotion(v:count1,0,1,1)<CR>
onoremap <silent> w :<c-u>call SmallWordMotion(v:count1,0,1,1)<CR>
xnoremap <silent> w :<c-u>call SmallWordMotion(v:count1,1,1,1)<CR>
nnoremap <silent> b :<C-u>call SmallWordMotion(v:count1,0,0,1)<CR>
onoremap <silent> b v:<c-u>call SmallWordMotion(v:count1,0,0,1)<CR>
xnoremap <silent> b :<c-u>call SmallWordMotion(v:count1,1,0,1)<CR>
nnoremap <silent> e :<C-u>call SmallWordMotion(v:count1,0,1,0)<CR>
onoremap <silent> e v:<c-u>call SmallWordMotion(v:count1,0,1,0)<CR>
xnoremap <silent> e :<c-u>call SmallWordMotion(v:count1,1,1,0)<CR>
" nnoremap  cw cw

function! InsideSmallWord(count)
    let l:line = line('.')
        if (!search('\C\v[a-z]+','ce', l:line))
            return
        endif
    for _ in range(a:count - 1)
        call search('\C\v[a-z]+','e', l:line)
    endfor
    normal! v
        call search('\C\v[A-Z]?[a-z]+','b', l:line)
    normal! o
endfunction
xnoremap <silent> iw :<c-u>call InsideSmallWord(v:count1)<cr>
onoremap <silent> iw :<c-u>call InsideSmallWord(v:count1)<cr>
nnoremap  W w
xnoremap  W w
onoremap  W w
xnoremap  iW iw
onoremap  iW iw

function! InsideSpaces(count)
    let l:line = line('.')
    if (!search('\v.(\s|$)','c', l:line))
        return
    endif
    for _ in range(a:count - 1)
        call search('\v.(\s|$)','c', l:line)
    endfor
    normal! v
    call search('\v(^|\s)\zs.','b', l:line)
    normal! o
endfunction
xnoremap <silent> is :<c-u>call InsideSpaces(v:count1)<cr>
onoremap <silent> is :<c-u>call InsideSpaces(v:count1)<cr>

function! InsideNumbers(count)
    let l:line = line('.')
    if (!search('\v\d','', l:line))
        return
    endif
    for _ in range(a:count - 1)
        call search('\v\zs.(\s|$)','', l:line)
    endfor
    normal! v
    call search('\v(^|\s).','b', l:line)
    normal! o
endfunction
xnoremap <silent> in :<c-u>call InsideNumbers(v:count1)<cr>
onoremap <silent> in :<c-u>call InsideNumbers(v:count1)<cr>

" }}}
"==============================================================================
" AUTOCOMMANDS
"==============================================================================
" {{{
function! EnableDebuggingMode()
  setlocal nonumber norelativenumber nocursorline colorcolumn=
  exec "nnoremap <buffer> J ".s:fivep."<C-e>"
  exec "nnoremap <buffer> K ".s:fivep."<C-y>"
  nnoremap d :call TermDebugSendCommand('delete')<CR>
  nnoremap n :Over<CR>
  nnoremap s :Step<CR>
  nnoremap b :Break<CR>
  nnoremap c :Continue<CR>
  nnoremap r :Run<CR>
endfunction
function! DisableDebuggingMode()
  set number relativenumber cursorline colorcolumn=81
  exec "nnoremap <buffer> J ".s:fivep."<C-e>"
  exec "nnoremap <buffer> K ".s:fivep."<C-y>"
  nunmap d
  nunmap n
  nunmap s
  nunmap b
  nunmap c
  nunmap r
endfunction
function! ToggleDebuggingMode()
  if !exists('g:DebuggingMode')
    let g:DebuggingMode=1
    call EnableDebuggingMode()
  else
    unlet g:DebuggingMode
    call DisableDebuggingMode()
  endif
endfunction
" nnoremap <silent> <leader>t :call ToggleDebuggingMode()<CR>

function! EnableReadingMode()
  setlocal nonumber norelativenumber nocursorline colorcolumn=
  exec "nnoremap <buffer> J ".s:fivep."<C-e>M"
  exec "nnoremap <buffer> K ".s:fivep."<C-y>M"
  nnoremap <buffer> j <C-e>M
  nnoremap <buffer> k <C-y>M
  nnoremap <buffer> d <C-d>M
  nnoremap <buffer> u <C-u>M
  normal M
endfunction
function! DisableReadingMode()
  set number relativenumber cursorline colorcolumn=81
  exec "nnoremap <buffer> J ".s:fivep."<C-e>"
  exec "nnoremap <buffer> K ".s:fivep."<C-y>"
  nunmap <buffer> j
  nunmap <buffer> k
  nunmap <buffer> d
  nunmap <buffer> u
endfunction

function! ToggleReadingMode()
  if !exists('b:ReadingMode')
    let b:ReadingMode=1
    call EnableReadingMode()
  else
    unlet b:ReadingMode
    call DisableReadingMode()
  endif
endfunction
nnoremap <silent> <leader>r :call ToggleReadingMode()<CR>
function! SetScrolloff()
    l:lines = float2nr(0.15*winheight(0))
    echo l:lines
    let &l:scrolloff=l:lines
endfunction
if !&diff
    augroup initialization
        au!
        autocmd WinEnter * if (&l:buftype == '' && !exists('b:ReadingMode')) |
                    \ setlocal relativenumber cursorline |
                    \ let &l:scrolloff=float2nr(0.15*winheight(0)) |
                    \ endif
        autocmd WinLeave * if (&l:buftype == '' && !exists('b:ReadingMode')) |
                    \ setlocal norelativenumber nocursorline | endif
        autocmd BufEnter * if &l:buftype == 'help' |
                    \ call EnableReadingMode() | endif
    augroup END
endif

function! LaunchDebugger() abort
  let context = g:neomake_hook_context
  if context.jobinfo.exit_code == 0
    echom printf('The "%s" job has completed without errors',
          \ context.jobinfo.maker.name)
    if context.jobinfo.maker.name == 'debug'
      Termdebug
    endif
  endif
endfunction
augroup my_neomake_hooks
  au!
  autocmd User NeomakeJobFinished call LaunchDebugger()
augroup END

augroup spellChecking
    au!
    autocmd Filetype tex setlocal spell
augroup END

" Fix for CursorLine highlighting (see neovim issue #9019)
" function! s:CustomizeColors()
" 	if has('guirunning') || has('termguicolors')
" 		let cursorline_gui=''
" 		let cursorline_cterm='ctermfg=white'
" 	else
" 		let cursorline_gui='guifg=white'
" 		let cursorline_cterm=''
" 	endif
" 	exec 'hi CursorLine ' . cursorline_gui . ' ' . cursorline_cterm 
" endfunction
" augroup OnColorScheme
" 	autocmd!
" 	autocmd ColorScheme,BufEnter,BufWinEnter * call s:CustomizeColors()
" augroup END
