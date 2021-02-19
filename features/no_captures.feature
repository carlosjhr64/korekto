@no_captures
Feature: no_captures

```korekto
no captures #M
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: No axiom match
    * Given option "< features/no_captures.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:!:pattern with no captures"
