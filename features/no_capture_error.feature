@no_capture_error
Feature: no_capture_error

```korekto
no captures #M
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: No axiom match
    * Given option "< features/no_capture_error.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:!:pattern with no captures"
