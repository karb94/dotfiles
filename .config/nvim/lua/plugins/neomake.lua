vim.cmd([[
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
]])
