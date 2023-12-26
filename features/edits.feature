@edits
Feature: Edits

```korekto
! scanner: '\w+|.'
! .Newline /\n/
! .Newline {;}
! Word /\w+/
! Word {u v w}
u is v;v is w;u is w	#I1 Transitive:   is
Dog Canine Mammal	#D2
Dog is Canine	#P3
Canine is Mammal	#P4
Dog is Mammal	#C5/I1,P3,P4 Wut
```

  Background:
    * Given command "korekto"

  Scenario: Edits
    * Given option "< features/edits.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:14:C5/I1,P3,P4:Transitive"
