@undefined
Feature: Undefined

```korekto
ABC	#D1
CaB #P
Does not get here #D
```

  Background:
    * Given command "korekto --trace"

  Scenario: Undefined
    * Given option "< features/undefined.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:D1:\n-:6:!:expected 0 undefined: a"
