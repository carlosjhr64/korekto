@type_in_use
Feature: type_in_use

```korekto
! P /original/
! P /redefinition attemp/
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Type in use
    * Given option "< features/type_in_use.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:6:0:!:type P in use"
