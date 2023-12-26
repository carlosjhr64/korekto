@let_set
Feature: Let/Set

```korekto
! :W /\w/
! :W {a b}
a=b	#L1 L2: =
A=B	#S2/L1 L2
```

  Background:
    * Given command "korekto --trace"

  Scenario: Let Set
    * Given option "< features/let_set.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:7:L1:L2: =\n-:8:S2/L1:L2"
