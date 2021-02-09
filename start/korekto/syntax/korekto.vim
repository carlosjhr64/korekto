syntax match Comment /# [^#]\+$/
syntax match Fail    /\s#! \w[^#]*$/
syntax match Pass    /\s#[A-Z][^#]*$/
syntax match Syntax  /^! \w.\+$/
syntax match Patch   /^::[A-Z]\w\+#\w\+[^=]\+=.\+$/
syntax match Import  /^< [A-Za-z\-\.]\+$/
highlight Comment ctermfg=darkblue
highlight Fail    ctermfg=darkred
highlight Pass    ctermfg=darkgreen
highlight Syntax  ctermfg=darkmagenta
highlight Patch   ctermfg=darkgrey
highlight Import  ctermfg=darkyellow
