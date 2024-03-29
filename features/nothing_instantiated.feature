@nothing_instantiated
Feature: Nothing_instantiated

```korekto
/^.abc.\nc\wb$/	#E1 E1
{abc}	#D2
cab #X
Does not get here #D
```

  Background:
    * Given command "korekto --trace"

  Scenario: No axiom match
    * Given option "< features/nothing_instantiated.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:E1:E1\n-:6:D2:\n-:7:!:expected 1 undefined: "
