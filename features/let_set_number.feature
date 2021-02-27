@let_set_number
Feature: let_set_number

```korekto
! :W /\w/
! :W {a b}
a=b	#L1 L3: =
A=B	#S
```

  Background:
    * Given command "korekto"

  Scenario: Let Set Number
    * Given option "< features/let_set_number.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:7:L1:L3: =\n-:8:!:expected 3 undefined: A B"
