@undefined
Feature: undefined

```korekto
ABC	#D5
CaB #P
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Undefined
    * Given option "< features/undefined.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:D5:\n-:6:!:undefined: a"
