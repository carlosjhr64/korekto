@no_inference_match
Feature: No inference match

```korekto
{a =}	#D1
a=a #C
Does not get here #D
```

  Background:
    * Given command "korekto --trace"

  Scenario: No inference match
    * Given option "< features/no_inference_match.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:D1:\n-:6:!:does not match any 'I' statement"
