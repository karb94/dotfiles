" vim: set foldmethod=marker foldlevel=0:
" pluginst os is vim running under
" let g:os = substitute(system('uname'), '\n', '', '')

lua require('plugins')
lua require('options')
lua require('mappings')
"==============================================================================
" MAPPINGS
"==============================================================================
"{{{
" inoremap lk <Esc>
" vnoremap lk <Esc>
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
cnoremap <C-j> <C-n>
cnoremap <C-k> <C-p>
" nnoremap <silent> <leader>B :b#<CR>
" nnoremap <leader>b :b 
" nnoremap <leader>e :cc<CR>
" nnoremap <leader>v :vsplit<CR><C-w>w
" nnoremap <leader>w <C-w>
" nnoremap <silent> <tab> <C-w><C-w>:if &buftype==#'quickfix'\|wincmd w\|endif<CR>
" nnoremap <silent> <leader>q :q!<CR>
" nnoremap <silent> <leader>Q :qa!<CR>
" nnoremap <silent> <leader>s :w<CR>
" nnoremap <silent> <leader>x :x<CR>
" nnoremap <silent> <leader>X :xa<CR>
" nnoremap <silent> <leader>v <C-v>
" nnoremap <silent> ]t :tabn<CR>
" nnoremap <silent> [t :tabp<CR>
" noremap <leader><leader>p "0p
" noremap <leader><leader>P "*p
" nnoremap <leader>b :b 
" nnoremap <leader>z :%foldclose<CR>
" nnoremap <leader>Z :%foldopen<CR>
" nnoremap <silent> ]c :<C-u>cnext<CR>
" nnoremap <silent> [c :<C-u>cprevious<CR>
" nnoremap <silent> <leader>o :set paste<CR>m`o<Esc>``:set nopaste<CR>
" nnoremap <silent> <leader>O :set paste<CR>m`O<Esc>``:set nopaste<CR>
" nnoremap <silent> <leader>p :put<CR>=`[
" nnoremap <silent> <leader>P :put!<CR>=`[
" nnoremap <silent> Y yg_
" nnoremap <silent> p pm`=`]``
" nnoremap <silent> P Pm`=`]``
" nnoremap <leader>rc :source $MYVIMRC<CR>
" nnoremap <silent> <leader>j J
" nnoremap U :redo<CR>

set wildcharm=<C-z>
" cnoremap <expr> <Tab>   getcmdtype() =~ '[\/?]' ? "<C-g>" : "<C-z>"
" cnoremap <expr> <S-Tab> getcmdtype() =~ '[\/?]' ? "<C-t>" : "<S-Tab>"
" nnoremap <silent> <leader>m :silent make!\|redraw!\|cw<CR>
" Terminal mappings
tnoremap <C-]> <C-\><C-n>
" TermDebugger mappings
" nnoremap <silent> <localleader>m :w<CR>:Neomake! make<CR>
" nnoremap <silent> <localleader>d :w<CR>:Neomake! debug<CR>
let s:fivep = float2nr(0.10*winheight(0))
" exec "nnoremap J ".s:fivep."<C-e>"
" exec "nnoremap K ".s:fivep."<C-y>"
nnoremap <silent> L :execute "normal! " . &l:scrolloff . "L"<CR>
nnoremap <silent> H :execute "normal! " . &l:scrolloff . "H"<CR>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" }}}

"==============================================================================
" FUNCTIONS
"==============================================================================
" {{{

function! Redir(cmd, rng, start, end)
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    if a:cmd =~ '^!'
        let cmd = a:cmd =~' %'
                    \ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
                    \ : matchstr(a:cmd, '^!\zs.*')
        if a:rng == 0
            let output = systemlist(cmd)
        else
            let joined_lines = join(getline(a:start, a:end), '\n')
            let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
            let output = systemlist(cmd . " <<< $" . cleaned_lines)
        endif
    else
        redir => output
        execute a:cmd
        redir END
        let output = split(output, "\n")
    endif
    vnew
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, output)
endfunction

command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

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
" xnoremap <silent> is :<c-u>call InsideSpaces(v:count1)<cr>
" onoremap <silent> is :<c-u>call InsideSpaces(v:count1)<cr>

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
  nnoremap <buffer> <nowait> <Esc> :q<CR>
  nmap <buffer> <nowait> j <C-e>M
  nmap <buffer> <nowait> k <C-y>M
  nmap <buffer> <nowait> d <C-d>M
  nmap <buffer> <nowait> u <C-u>M
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

if !&diff

    augroup help_buffers
        autocmd!
        autocmd FileType man,help
                    \ if (!&modifiable) |
                    \ call EnableReadingMode() | endif
        autocmd WinEnter,BufWinEnter * if (&l:buftype == '' && !exists('b:ReadingMode')) |
                    \ setlocal relativenumber cursorline |
                    \ let &l:scrolloff=float2nr(0.15*winheight(0)) |
                    \ endif
        autocmd WinLeave * if (&l:buftype == '' && !exists('b:ReadingMode')) |
                    \ setlocal norelativenumber nocursorline | endif
    augroup END
endif

function! LaunchDebugger() abort
  let context = g:neomake_hook_context
  if context.jobinfo.exit_code == 0
    echom printf('The "%s" job has completed without errors',
          \ context.jobinfo.maker.name)
    " if context.jobinfo.maker.name == 'debug'
    "   Termdebug
    " endif
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
function! s:CustomizeColors()
	if has('guirunning') || has('termguicolors')
		let cursorline_gui=''
		let cursorline_cterm='ctermfg=white'
	else
		let cursorline_gui='guifg=white'
		let cursorline_cterm=''
	endif
	exec 'hi CursorLine ' . cursorline_gui . ' ' . cursorline_cterm 
endfunction
augroup OnColorScheme
	autocmd!
	autocmd ColorScheme,BufEnter,BufWinEnter * call s:CustomizeColors()
augroup END

augroup packer
    au!
    autocmd BufWritePost plugins.lua PackerCompile
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
" }}}
" augroup custom_highlight
"     autocmd!
"     autocmd ColorScheme * highlight NeoscrollHiddenCursor gui=reverse blend=100
" augroup END
