@which
Feature: which

```korekto
! scanner: '.'
! Newline /\n/
! Newline {;}
! Variable /\w/
! Variable {A B C}
A=A	#A1 Reflection: =
A;B;A&B	#I2 Conjunction: &
A=B	#L3 Let 1
A=B;2A=2B	#M4 : 2
A=B;C!	#E5 : !
23	#D6
2	#P7
3	#P8
3=3	#W
a=3	#W
2a=23	#W
1!	#W
2&3	#W
```

  Background:
    * Given command "korekto"

  Scenario: Which
    * Given option "< features/which.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /T9.A1.Reflection/
    * Then stdout matches /S10.L3.Let/
    * Then stdout matches /R11.M4,S10/
    * Then stdout matches /X12.E5,S10/
    * Then stdout matches /C13.I2,P7,P8.Conjunction/
    * Then digest is "29147fb08d4d6a19e33cfbb1d5a216d5"
