"### Korekto syntax ###
syntax match KorektoUnsup   /#[A-Z]\d\+\(\.\w\+\)\?/ contained containedin=KorektoType
syntax match KorektoSup     /#[A-Z]\d\+\(\.\w\+\)\?\/\S\+/ contained containedin=KorektoType
syntax match KorektoTitle   / [^:]\+/ contained containedin=KorektoType
syntax match KorektoUndef   /:[^#]\+$/ contained containedin=KorektoType
syntax match KorektoType    /#[A-Z][^#]\+$/ contains=KorektoUnsup,KorektoSup,KorektoTitle,KorektoUndef
syntax match KorektoComment /#\+ .\+$/
syntax match KorektoSyntax  /^[?] \S.\+$/
syntax match KorektoPatch   /^::[A-Z]\w\+#\w\+[^=]\+=.\+$/
syntax match KorektoImport  /^< [\/A-Za-z\_\-\.]\+$/
syntax match KorektoSetting /^! \S.*$/
"### Additional math syntax ###
syntax match KorektoOperator   /[!?$&@*+-/<=>^~,.:;|(){}\[\]"'`_]/ contained containedin=KorektoStatement
syntax match KorektoItalic     /[𝐴-𝑧𝛢-𝜛]/ contained containedin=KorektoStatement
syntax match KorektoBold       /[𝐀-𝐳𝚨-𝛡]/ contained containedin=KorektoStatement
syntax match KorektoBoldItalic /[𝑨-𝒛𝜜-𝝕]/ contained containedin=KorektoStatement
syntax match KorektoMinuscule  /[ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ]/ contained containedin=KorektoStatement
syntax match KorektoStatement  /^[^#!?<][^#]*/ contains=KorektoOperator,KorektoItalic,KorektoBold,KorektoBoldItalic,KorektoMinuscule
"### Korekto highlighting ###
highlight KorektoUnsup   ctermfg=brown
highlight KorektoSup     ctermfg=darkgreen
highlight KorektoTitle   ctermfg=darkblue
highlight KorektoUndef   ctermfg=darkred
highlight KorektoComment ctermfg=darkblue
highlight KorektoImport  ctermfg=brown
highlight KorektoPatch   ctermfg=darkgrey
highlight KorektoSyntax  ctermfg=darkgrey
highlight KorektoSetting ctermfg=darkmagenta
"### Additional math highlighting ###
highlight KorektoOperator   ctermfg=grey
highlight KorektoItalic     ctermfg=darkgreen
highlight KorektoBold       ctermfg=darkred
highlight KorektoBoldItalic ctermfg=darkcyan
highlight KorektoMinuscule  ctermfg=darkgrey
"### Additional settings ###
setlocal tabstop=3
map <F7> :Korekto<CR>
