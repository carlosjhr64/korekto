@simple
Feature: simple

```korekto
/^(\w)(\w\w)\2\1$/	#A5
/^ABABAA\nCABABC\nBACA$/	#I6
{A B C}	#D7
ABABAA	#T8/A5
CABABC	#T9/A5
BACA	#C10/I6,T8,T9
```

  Background:
    * Given command "korekto"

  Scenario: --version
    * Given option "--version"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /^\d+\.\d+\.\d+$/

  Scenario: --help
    * Given option "--help"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /^Usage:\s+korekto /

  Scenario: ABC
    * Given option "< features/simple.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:5:A5:\n-:6:I6:\n-:7:D7:\n-:8:T8/A5:\n-:9:T9/A5:\n-:10:C10/I6,T8,T9:"
