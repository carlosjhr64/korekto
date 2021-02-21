@simple
Feature: simple

```korekto
/^(\w)(\w\w)\2\1$/	#A1
/^ABABAA\nCABABC\nBACA$/	#I2
{A B C}	#D3
ABABAA	#T4/A1
CABABC	#T5/A1
BACA	#C6/I2,T4,T5
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
    * Then stdout is "-:5:A1:\n-:6:I2:\n-:7:D3:\n-:8:T4/A1:\n-:9:T5/A1:\n-:10:C6/I2,T4,T5:"
