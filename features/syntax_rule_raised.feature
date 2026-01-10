@syntax_rule_raised
Feature: syntax_rule_raised

```korekto
? raise 'No!' if self=='Cacahuates!'; true
Cacahuates! #D
Does not get here #D
```

  Background:
    * Given command "./bin/korekto -s"

  Scenario: Syntax rule raised
    * Given option "< features/syntax_rule_raised.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:6:!:RuntimeError: raise 'No!' if self=='Cacahuates!'; true"
