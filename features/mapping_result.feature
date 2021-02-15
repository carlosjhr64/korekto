@mapping_result
Feature: mapping_result

```korekto
! W /\w+/
! W {w}
! :nl /\n/
! :nl {;}
w+w;2w	#M1
N{a}	#D2
a+a	#P3
2a	#R4/M1,P3
```

  Background:
    * Given command "korekto"

  Scenario: Mapping Result
    * Given option "< features/mapping_result.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:9:0:M1:\n-:10:0:D2:\n-:11:0:P3:\n-:12:0:R4/M1,P3:"
