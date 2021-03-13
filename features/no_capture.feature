@no_capture
Feature: no_capture

```korekto
! scanner: '.'
! .Newline /\n/
! .Newline {;}
! .Open /[({\[]?/
! .Open {<}
! .Close /[)}\]]?/
! .Close {>}
! Token /\w/
! Token {a b c d e f g}
a(b + c) = <ab> + <ac>	#A1 : (   + ) =
ABC	#D2
A(B + C) = AB + AC	#T3/A1
A(B + C) = (AB) + (AC)	#T4/A1
A(B + C) = (AB + AC)	#T5/A1
A(B + C) = AB) + (AC	#T6/A1
A(B + C) = AB( + )AC	#W
```

  Background:
    * Given command "korekto"

  Scenario: No Capture patterns
    * Given option "< features/no_capture.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout matches /-:14:A1::/
    * Then stdout matches /-:15:D2:/
    * Then stdout matches /-:16:T3/A1:/
    * Then stdout matches /-:17:T4/A1:/
    * Then stdout matches /-:18:T5.A1:/
    * Then stdout matches /-:19:T6.A1:/
    * Then stdout matches /-:20:!:/
