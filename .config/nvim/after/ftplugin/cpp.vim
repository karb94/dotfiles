set tabstop=2 shiftwidth=2
let &makeprg='make -C build -j $(nproc)'
set errorformat=
            \%-Gmake%.%#,
            \%-IIn\ file\ included\ from%.%#,
            \%-C%\\s%\\+from%.%#,
            \%Z%[%^\ ]%\\@=%f:%l:%c:\ %t%\\a%\\+:\ %m,
            \%E%[%^\ ]%\\@=%f:%l:%c:\ %t%\\a%\\+:\ %m,
            \%A%[%^\ ]%\\@=%f:\ %m,
            \%+G%>%\\s%\\+%\\d%\\+\ \|%.%#,
            \%+G%>%\\s%\\+\|%.%#,
            \%-G%.%#

let g:neomake_make_maker = {
    \ 'name': 'make',
    \ 'exe': 'make',
    \ 'cwd': 'build',
    \ 'args': ['-j13'],
    \ 'errorformat':
    \   '%-Gmake%.%#,' .
    \   '%-IIn\ file\ included\ from%.%#,' .
    \   '%-C%\\s%\\+from%.%#,' .
    \   '%Z%[%^\ ]%\\@=%f:%l:%c:\ %t%\\a%\\+:\ %m,' .
    \   '%E%[%^\ ]%\\@=%f:%l:%c:\ %t%\\a%\\+:\ %m,' .
    \   '%A%[%^\ ]%\\@=%f:\ %m,' .
    \   '%+G%>%\\s%\\+%\\d%\\+\ \|%.%#,' .
    \   '%+G%>%\\s%\\+\|%.%#,' .
    \   '%-G%.%#'
    \ }

let g:neomake_debug_maker = {
    \ 'name': 'debug',
    \ 'exe': 'make',
    \ 'cwd': 'debug',
    \ 'args': ['-j13'],
    \ 'errorformat':
    \   '%-Gmake%.%#,' .
    \   '%-IIn\ file\ included\ from%.%#,' .
    \   '%-C%\\s%\\+from%.%#,' .
    \   '%Z%[%^\ ]%\\@=%f:%l:%c:\ %t%\\a%\\+:\ %m,' .
    \   '%E%[%^\ ]%\\@=%f:%l:%c:\ %t%\\a%\\+:\ %m,' .
    \   '%A%[%^\ ]%\\@=%f:\ %m,' .
    \   '%+G%>%\\s%\\+%\\d%\\+\ \|%.%#,' .
    \   '%+G%>%\\s%\\+\|%.%#,' .
    \   '%-G%.%#'
    \ }
