@no_mapping
Feature: No mapping

```korekto
{a}	#D1
a #R
Does not get here #D
```

  Background:
    * Given command "korekto --trace"

  Scenario: No mapping
    * Given option "< features/no_mapping.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:D1:\n-:6:!:does not match any 'M' statement in heap"
