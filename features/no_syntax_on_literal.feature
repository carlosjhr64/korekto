@no_syntax_on_literal
Feature: on_syntax_on_literal

```korekto
? !self[0]=='/' and !self[-1]=='/'
/^OK$/	#A1
```

  Background:
    * Given command "korekto"

  Scenario: No syntax on literal
    * Given option "< features/no_syntax_on_literal.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:6:A1:"
