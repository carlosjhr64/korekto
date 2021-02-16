@bad_syntax_rule
Feature: bad_syntax_rule

```korekto
? lEnGtH < 7
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Syntax rule
    * Given option "< features/bad_syntax_rule.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:0:!:NameError: lEnGtH < 7"
