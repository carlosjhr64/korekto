@no_axiom_match
Feature: No axiom match

```korekto
{a =}	#D1
a=a #T
Does not get here #D
```

  Background:
    * Given command "korekto --trace"

  Scenario: No axiom match
    * Given option "< features/no_axiom_match.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:D1:\n-:6:!:does not match any 'A' statement"
