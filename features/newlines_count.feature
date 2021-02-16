@newlines_count
Feature: newlines_count

```korekto
! V /\w/
! V {u v w}
! :NL /\n/
! :NL {;}
u;:if[u,v];v	#I1 Modus Ponem
S{s,t}	#D2 Statements
s	#P3
:if[s,t]	#P4
t	#C5/I1,P3,P4 Modus Ponem
```

  Background:
    * Given command "korekto"

  Scenario: Newline count
    """
    Korekto expects a type :nl for newlines
    that do not capture.
    Newlines are counted in the regexp inspection
    to ensure the proper number of newlines
    for the acceptence method being used.
    """
    * Given option "< features/newlines_count.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:9:0:!:expected 2 newlines"
