@newlines_count
Feature: newlines_count

```korekto
! V /\w/
! V {u v w}
! :NL /\n/
! :NL {;}
u;:if[u,v];v	#I9 Modus Ponem
S{s,t}	#D10 Statements
s	#P11
:if[s,t]	#P12
t	#C13/I9,P11,P12 Modus Ponem
```

  Background:
    * Given command "korekto"

  Scenario: Newline count
    """
    Korekto expects a type :nl for newlines
    that do not capture.
    It is case sensitive, so the :NL above is not recognized.
    Newlines are counted in the regexp inspection
    to ensure the proper number of newlines
    for the acceptence method being used.
    """
    * Given option "< features/newlines_count.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:9:!:expected 2 newlines"
