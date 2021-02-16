@no_inference_match
Feature: no_inference_match

```korekto
{a =} #D
a=a #C
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: No inference match
    * Given option "< features/no_inference_match.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:0:D1:\n-:6:0:!:does not match any inference"