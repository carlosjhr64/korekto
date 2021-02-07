syntax match Comment /^#\s.\+$/
syntax match Fail    /\s#!\s.\+$/
syntax match Pass    /\s#\s.\+$/
syntax match Syntax  /^!.\+$/
syntax match Patch   /^:.\+$/
syntax match Import  /^<.\+$/
highlight Comment ctermfg=darkblue
highlight Fail    ctermfg=darkred
highlight Pass    ctermfg=darkgreen
highlight Syntax  ctermfg=darkmagenta
highlight Patch   ctermfg=darkgrey
highlight Import  ctermfg=darkyellow
