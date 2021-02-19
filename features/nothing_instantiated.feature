@nothing_instantiated
Feature: nothing_instantiated

```korekto
{abc} #D
cab #X
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: No axiom match
    * Given option "< features/nothing_instantiated.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:D1:\n-:6:!:nothing to instantiate"
