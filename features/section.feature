@section
Feature: Section

```korekto
! section: 'Anything'
/.*/	#L1.Anything Let anything!
! section: 'Work'
Anything?	#S2.Work/L1.Anything Let anything!
```

  Background:
    * Given command "korekto --trace"

  Scenario: Section
    * Given option "< features/section.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /-:8:S2.Work.L1.Anything:Let anything!/
