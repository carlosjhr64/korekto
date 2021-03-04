# Syntax
```korekto
### Ruby Monkey Patches ###
::Array#blp(k,m) = (m==0)?self<<k:(k==last)?self[0..-2]:self<<k
::Array#bli      = inject([]){|a,km| a.blp(*km)}
::Array#blm(g)   = map{|c| g.index(c).divmod(2)}
::Array#bls(g)   = select{|c| g.include?(c)}
::String#balance(g)   = chars.bls(g).blm(g).bli
::String#balanced?(g) = balance(g).empty?
### Syntax ###
? balanced? '(){}[]'
? length < 66
# Scanner
! scanner: ':\w+|.'
### Patterns ###
#
! Newline /\n/
! Newline {;}
#
! Glob /\S*/
! Glob {a b c d e}
#
! Token /\(\S+\)|:\w+\[\S+?\]|:\w+|\d+\.\d+|\d+|\p{L}/
! Token {A B C D E}
#
! Operator /:[A-Z]/
! Operator {F G H O}
#
! Digets /\d+/
! Digets {I J K L M N}
#
! Variables /[a-z]/
! Variables {u v w x y z}
#
```
