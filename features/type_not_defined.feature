@type_not_defined
Feature: type_not_defined

```korekto
! P {p}
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Type not defined
    * Given option "< features/type_not_defined.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:0:!:type P not defined"
