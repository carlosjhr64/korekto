syntax match Undef   /:[^#]\+$/
syntax match Type    /\s#[A-Z][^#:]\+:\?/
syntax match Comment /^\s*#.\+$/
syntax match Syntax  /^[?] \w.\+$/
syntax match Patch   /^::[A-Z]\w\+#\w\+[^=]\+=.\+$/
syntax match Import  /^< [\/A-Za-z\_\-\.]\+$/
syntax match Setting /^! .*$/
highlight Undef   ctermfg=red
highlight Type    ctermfg=darkgreen
highlight Comment ctermfg=darkblue
highlight Import  ctermfg=darkyellow
highlight Patch   ctermfg=darkgrey
highlight Syntax  ctermfg=darkmagenta
highlight Setting ctermfg=brown
setlocal tabstop=23
map <F7> :Korekto<CR>
