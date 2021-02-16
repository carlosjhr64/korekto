@no_mapping
Feature: no_mapping

```korekto
{a} #D
a #R
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: No mapping
    * Given option "< features/no_mapping.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:0:D1:\n-:6:0:!:does not match any mapping"