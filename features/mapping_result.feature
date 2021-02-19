@mapping_result
Feature: mapping_result

```korekto
! W /\w+/
! W {w}
! :nl /\n/
! :nl {;}
w+w;2w	#M9
N{a}	#D10
a+a	#P11
2a	#R12/M9,P11
```

  Background:
    * Given command "korekto"

  Scenario: Mapping Result
    * Given option "< features/mapping_result.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:9:M9:\n-:10:D10:\n-:11:P11:\n-:12:R12/M9,P11:"
