"### Korekto Syntax ###
" Korekto Type
syntax match KorektoUnsup /#[A-Z]\d\+\(\.\w\+\)\?\(\/\)\@!/ contained containedin=KorektoType
syntax match KorektoSup   /#[A-Z]\d\+\(\.\w\+\)\?\/\S\+/ contained containedin=KorektoType
syntax match KorektoTitle /\(#[A-Z]\d\S*\s\)\@<=[^:]\+/ contained containedin=KorektoType
syntax match KorektoUndef /\(:\)\@<=.\+$/ contained containedin=KorektoType
syntax match KorektoType  /#[A-Z]\d[^#]\+$/ contains=KorektoUnsup,KorektoSup,KorektoTitle,KorektoUndef
" Korekto Statement
syntax match KorektoLetter      /\a/ contained containedin=KorektoStatement
syntax match KorektoNumber      /\d/ contained containedin=KorektoStatement
syntax match KorektoPunctuation /\W/ contained containedin=KorektoStatement
syntax match KorektoStatement   /^.\+\(\s#[A-Z]\d\)\@=/ contains=KorektoLetter,KorektoNumber,KorektoPunctuation
" Korekto Non-Statement
syntax match KorektoComment /^#.\+/
syntax match KorektoPatch   /^::.\+/
syntax match KorektoCommand /^[<!?]\s.\+/
"### Korekto Highlighting ###
highlight KorektoUnsup       ctermfg=brown
highlight KorektoSup         ctermfg=darkgreen
highlight KorektoTitle       ctermfg=blue
highlight KorektoUndef       ctermfg=red
highlight KorektoComment     ctermfg=darkblue
highlight KorektoPatch       ctermfg=grey
highlight KorektoCommand     ctermfg=lightgrey
highlight KorektoLetter 	   ctermfg=black
highlight KorektoNumber 	   ctermfg=darkred
highlight KorektoPunctuation ctermfg=darkgrey
"### Settings ###
setlocal tabstop=3
map <leader><F7> :KorektoPatch<CR>
map <F7> :Korekto<CR>
