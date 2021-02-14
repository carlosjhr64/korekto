@abc
Feature: simple

```korekto
/^(\w)(\w\w)\2\1$/ #A
/^ABABAA\nCABABC\nBACA$/ #I
{A B C} #D
ABABAA #T
CABABC #T
BACA   #C
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
    * Then stdout is "-:5:0:A1:\n-:6:0:I2:\n-:7:0:D3:\n-:8:0:T4/A1:\n-:9:0:T5/A1:\n-:10:0:C6/I2,T4,T5:"
