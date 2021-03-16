@section
Feature: section

```korekto
! section: 'Anything'
/.*/	#L1 Let anything!
! section: 'Work'
Anything?	#S2/Anything.L1 Let anything!
```

  Background:
    * Given command "korekto"

  Scenario: Section
    * Given option "< features/section.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /-:8:S2.Anything.L1:Let anything!/
