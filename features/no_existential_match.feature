@no_existential_match
Feature: no_existential_match

```korekto
{abc} #D
axc #X
```

  Background:
    * Given command "korekto"

  Scenario: No existential match
    * Given option "< features/no_existential_match.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:0:D1:\n-:6:0:!:does not match any existential"
