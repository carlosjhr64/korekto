@boolean_syntax_rule
Feature: boolean_syntax_rule

```korekto
? self
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Boolean syntax rule
    * Given option "< features/boolean_syntax_rule.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:0:!:syntax rule must eval boolean"
