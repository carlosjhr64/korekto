@statement_type_not_implemented
Feature: statement_type_not_implemented

```korekto
Cacahuates #Z
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Statement type not implemented
    * Given option "< features/statement_type_not_implemented.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:0:!:statement type Z not implemented"
