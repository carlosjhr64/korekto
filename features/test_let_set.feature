@test_let_set
Feature: Test Let/Set

```korekto
! :W /\w/
! :W {a b}
a=b	#L Let 2
A=B	#W
```

  Background:
    * Given command "korekto --trace"

  Scenario: Let Set
    * Given option "< features/test_let_set.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:7:L1:Let 2: =\n-:8:S2/L1:Let 2: A B"
