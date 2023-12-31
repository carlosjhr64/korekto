"### Korekto Syntax ###
" Korekto Type
syntax match KorektoUnsup /#[A-Z]\d\+\(\.\w\+\)\?\(\/\)\@!/ containedin=KorektoType
syntax match KorektoSup   /#[A-Z]\d\+\(\.\w\+\)\?\/\S\+/ contained containedin=KorektoType
syntax match KorektoTitle /\(#[A-Z]\d\S*\s\)\@<=[^:]\+/ contained containedin=KorektoType
syntax match KorektoUndef /\(:\)\@<=.\+$/ contained containedin=KorektoType
syntax match KorektoType  /#[A-Z]\d[^#]\+$/ contains=KorektoUnsup,KorektoSup,KorektoTitle,KorektoUndef
" Korekto Statement
syntax match KorektoLetter      /[A-Za-z𝐀-𝟿]/ contained containedin=KorektoStatement
syntax match KorektoNumber      /[0-9]/ contained containedin=KorektoStatement
syntax match KorektoPunctuation /[^0-9A-Za-z𝐀-𝟿]/ contained containedin=KorektoStatement
syntax match KorektoStatement   /^.\+\(\s#[A-Z]\d\)\@=/ contains=KorektoLetter,KorektoNumber,KorektoPunctuation
" Korekto Non-Statement
syntax match KorektoComment /^#\+\s.\+/
syntax match KorektoPatch   /^::[A-Z].\+/
syntax match KorektoCommand /^[<!?]\s.\+/
"### Korekto Highlighting ###
highlight KorektoUnsup       ctermfg=brown
highlight KorektoSup         ctermfg=darkgreen
highlight KorektoTitle       ctermfg=blue
highlight KorektoUndef       ctermfg=red
highlight KorektoComment     ctermfg=darkblue
highlight KorektoPatch       ctermfg=grey
highlight KorektoCommand     ctermfg=lightgrey
highlight KorektoPunctuation ctermfg=darkgrey
highlight KorektoNumber 	   ctermfg=darkred
highlight KorektoLetter 	   ctermfg=black
"### Settings ###
setlocal tabstop=3
map <leader><F7> :KorektoPatch<CR>
map <F7> :Korekto<CR>
