syntax match Unsup   /#[A-Z]\d\+\(\.\w\+\)\?/ contained containedin=Type
syntax match Sup     /#[A-Z]\d\+\(\.\w\+\)\?\/\S\+/ contained containedin=Type
syntax match Title   / [^:]\+/ contained containedin=Type
syntax match Undef   /:[^#]\+$/ contained containedin=Type
syntax match Type    /\s#[A-Z][^#]\+/ contains=Unsup,Sup,Title,Undef
syntax match Comment /# .\+$/
syntax match Syntax  /^[?] \S.\+$/
syntax match Patch   /^::[A-Z]\w\+#\w\+[^=]\+=.\+$/
syntax match Import  /^< [\/A-Za-z\_\-\.]\+$/
syntax match Setting /^! \S.*$/
highlight Unsup   ctermfg=brown
highlight Sup     ctermfg=darkgreen
highlight Title   ctermfg=darkblue
highlight Undef   ctermfg=red
highlight Comment ctermfg=darkblue
highlight Import  ctermfg=brown
highlight Patch   ctermfg=darkgrey
highlight Syntax  ctermfg=darkgrey
highlight Setting ctermfg=darkmagenta
setlocal tabstop=23
map <F7> :Korekto<CR>
