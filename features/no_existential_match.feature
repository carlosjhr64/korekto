@no_existential_match
Feature: no_existential_match

```korekto
{abc}	#D5
axc #X
```

  Background:
    * Given command "korekto"

  Scenario: No existential match
    * Given option "< features/no_existential_match.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:D5:\n-:6:!:does not match any existential"
