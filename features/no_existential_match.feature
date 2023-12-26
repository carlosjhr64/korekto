@no_existential_match
Feature: No existential match

```korekto
{abc}	#D1
axc #X
```

  Background:
    * Given command "korekto --trace"

  Scenario: No existential match
    * Given option "< features/no_existential_match.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:D1:\n-:6:!:does not match any 'E' statement"
