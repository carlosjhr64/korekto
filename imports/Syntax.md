# Syntax
```korekto
### Syntax ###
? balanced? '(){}[]'
? length < 66
# Scanner
! scanner: ':\w+|.'
### Patterns ###
# -----------------------------------------------------
! .Newline /\n/
! .Newline {;}
# -----------------------------------------------------
! Glob /\S*/
! Glob {a b c d e}
# -----------------------------------------------------
! Token /\(\S+\)|:\w+\[\S+?\]|:\w+|\d+\.\d+|\d+|\p{L}/
! Token {A B C D E}
# -----------------------------------------------------
! Operator /:[A-Z]/
! Operator {F G H O}
# -----------------------------------------------------
! Digets /\d+/
! Digets {I J K L M N}
# -----------------------------------------------------
! Variables /[a-z]/
! Variables {u v w x y z}
```
