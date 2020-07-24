set tabstop=2 shiftwidth=2
let &makeprg='make -C build -j $(nproc)'
set errorformat=
            \%-Gmake%.%#,
            \%-IIn\ file\ included\ from%.%#,
            \%-C%\\s%\\+from%.%#,
            \%Z%[%^\ ]%\\@=%f:%l:%c:\ %t%\\a%\\+:\ %m,
            \%A%[%^\ ]%\\@=%f:\ %m,
            \%+G%>%\\s%\\+%\\d%\\+\ \|%.%#,
            \%+G%>%\\s%\\+\|%.%#,
            \%-G%.%#
