" Set the command to compile with
let &makeprg='python % > /dev/null'
set errorformat=
            \%A\ \ File\ \"%f\"\\,\ line\ %l\\,%.%#,
            \%C\ \ \ \ %.%#,
            \%+Z%[%^\ ]%\\@=%.%#%trror%.%#:\ %m,
            \%-GTraceback%.%#,
            \%+G%.%#

let g:slime_python_ipython = 1
fun! StartREPL(repl)
    execute 'terminal '.a:repl
    setlocal nonumber
    let t:term_id = b:terminal_job_id
    wincmd p
    execute 'let b:slime_config = {"jobid": "'.t:term_id . '"}'
endfun
noremap <silent> <localleader>s :vsplit<bar>:call StartREPL('ipython')<CR>
