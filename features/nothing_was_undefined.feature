@nothing_was_undefined
Feature: nothing_was_undefined

```korekto
ABC	#D5
CAB #D
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Nothing was undefined
    * Given option "< features/nothing_was_undefined.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:D5:\n-:6:!:nothing was undefined"
