syntax match Comment /# [^#]\+$/
syntax match Pass    /\s#[A-Z][^#]*$/
syntax match Syntax  /^[?] \w.\+$/
syntax match Patch   /^::[A-Z]\w\+#\w\+[^=]\+=.\+$/
syntax match Import  /^< [\/A-Za-z\_\-\.]\+$/
highlight Comment ctermfg=darkblue
highlight Pass    ctermfg=darkgreen
highlight Syntax  ctermfg=darkmagenta
highlight Patch   ctermfg=darkgrey
highlight Import  ctermfg=darkyellow
setlocal tabstop=23
