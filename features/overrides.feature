@overrides
Feature: overrides

```korekto
::String#length = "Cacahuates!"
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Overrides
    * Given option "--patch < features/overrides.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:!:overrides: ::String#length"
