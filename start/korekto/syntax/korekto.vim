syntax match Comment /#\s.\+$/
syntax match Syntax  /^!.\+$/
syntax match Patch   /^:.\+$/
syntax match Import  /^<.\+$/
highlight Comment ctermfg=darkblue
highlight Syntax  ctermfg=darkred
highlight Patch   ctermfg=darkgreen
highlight Import  ctermfg=darkyellow
