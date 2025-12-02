" Vim syntax file
" Language: Korekto
" File: syntax/korekto.vim

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "korekto"

" Definitions:
syntax match korektoSyntax "^?.*$"
syntax match korektoHandwave "^~.*$"
syntax match korektoDefinition "^!.*$"
syntax match korektoImport "^<.*$"
syntax match korektoStatement "^[^?~!#][^#]*" contains=korektoKey,korektoCase
syntax match korektoKey ":[A-Za-z0-9_]\+" contained
syntax match korektoCase "[A-Za-z0-9_]\+:\s" contained
syntax match korektoComment "#.*$" contains=korektoSpecialComment
syntax match korektoSpecialComment "#[A-Z]\S\+" contained

" Links:
highlight default link korektoSyntax          PreCondit
highlight default link korektoHandwave        Macro
highlight default link korektoDefinition      Define
highlight default link korektoImport          Include
highlight default link korektoStatement       Statement
highlight default link korektoKey             Function
highlight default link korektoCase            Identifier
highlight default link korektoComment         Comment
highlight default link korektoSpecialComment  SpecialComment
