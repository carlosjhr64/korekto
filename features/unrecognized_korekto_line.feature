@unrecognized_korekto_line
Feature: unrecognized_korekto_line

```korekto
Cacahuates # De Mani
Does not get here #D
```

  Background:
    * Given command "korekto"

  Scenario: Unrecongnized korekto line
    * Given option "< features/unrecognized_korekto_line.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:!:unrecognized korekto line"
