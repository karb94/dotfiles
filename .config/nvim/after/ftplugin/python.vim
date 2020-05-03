" Set the command to compile with
let &makeprg='python % > /dev/null'
set errorformat=
            \%A\ \ File\ \"%f\"\\,\ line\ %l\\,%.%#,
            \%C\ \ \ \ %.%#,
            \%+Z%[%^\ ]%\\@=%.%#%trror%.%#:\ %m,
            \%-GTraceback%.%#,
            \%+G%.%#
