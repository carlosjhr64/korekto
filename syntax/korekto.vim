" Vim syntax file
" Language: Korekto
" File: syntax/korekto.vim

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "korekto"

" Definitions:
syntax match korektoPreCondit "^?.*$"
syntax match korektoDefine "^!.*$"
syntax match korektoInlude "^<.*$"
syntax match korektoFunction ":[A-Za-z0-9_]\+"
syntax match korektoComment "#.*$" contains=korektoSpecialComment
syntax match korektoSpecialComment "#[A-Z]\S\+" contained

" Links:
highlight default link korektoPreCondit       PreCondit
highlight default link korektoDefine          Define
highlight default link korektoInclude         Include
highlight default link korektoFunction        Function
highlight default link korektoComment         Comment
highlight default link korektoSpecialComment  SpecialComment
