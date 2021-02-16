@variable_in_use
Feature: variable_in_use

```korekto
! P /now/
! P {a}
! V /later/
! V {a}
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Variable in use
    * Given option "< features/variable_in_use.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:8:0:!:variable a in use"
