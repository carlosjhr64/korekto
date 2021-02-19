@syntax_rule
Feature: syntax_rule

```korekto
? length < 7
12345678 #D
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Syntax rule
    * Given option "< features/syntax_rule.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:6:!:syntax: length < 7"
