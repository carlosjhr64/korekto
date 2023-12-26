@mapping_result
Feature: Mapping result

```korekto
! W /\w+/
! W {w}
! :nl /\n/
! :nl {;}
w+w;2w	#M1 : + 2
N{a}	#D2
a+a	#P3
2a	#R4/M1,P3
```

  Background:
    * Given command "korekto --trace"

  Scenario: Mapping Result
    * Given option "< features/mapping_result.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:9:M1:: + 2\n-:10:D2:\n-:11:P3:\n-:12:R4/M1,P3:"
