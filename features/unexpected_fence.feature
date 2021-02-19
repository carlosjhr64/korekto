@unexpected_fence
Feature: unexpected_fence

```korekto
```korekto
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Unexpected fence
    * Given option "< features/unexpected_fence.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:!:unexpected fence"
