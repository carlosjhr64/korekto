@no_axiom_match
Feature: no_axiom_match

```korekto
{a =}	#D5
a=a #T
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: No axiom match
    * Given option "< features/no_axiom_match.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:D5:\n-:6:!:does not match any axiom"
