@regexp_quote_postfix
Feature: Regexp quoate postfix

```korekto
! scanner: '\(\||\|\)|.'
! .Newline /\n/
! .Newline {;}
! .MayOpen /\(?/
! .MayOpen {(|}
! .MayClose /\)?/
! .MayClose {|)}
! Glob /.*/
! Glob {a b c d}
a = b;c(|a|)d;c(b)d	#I1 :   = ( )
a = b;c(|b|)d;c(a)d	#I2
abcxyz	#D3
abc = xyz	#P4
(xyz)xyz	#C5/I1,P4,D3
(xyz)(abc)	#C6/I2,P4,C5
(abc)(abc)	#C7/I2,P4,C6
(abc)(xyz)	#C8/I1,P4,C7
```

  Background:
    * Given command "korekto --trace"

  Scenario: Regexp quote postfix
    * Given option "< features/regexp_quote_postfix.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /C5.I1,P4,D3/
    * Then stdout matches /C6.I2,P4,C5/
    * Then stdout matches /C7.I2,P4,C6/
    * Then stdout matches /C8.I1,P4,C7/
