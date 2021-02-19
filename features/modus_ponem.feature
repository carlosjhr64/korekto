@modus_ponem
Feature: modus_ponem

```korekto
! V /\w/
! V {u v w}
! :nl /\n/
! :nl {;}
u;:if[u,v];v	#I1 Modus Ponem
S{s,t}	#D2 Statements
s	#P3
:if[s,t]	#P4
t	#C5/I1,P3,P4 Modus Ponem
```

  Background:
    * Given command "korekto"

  Scenario: Modus Ponem
    * Given option "< features/modus_ponem.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:9:I1:Modus Ponem\n-:10:D2:Statements\n-:11:P3:\n-:12:P4:\n-:13:C5/I1,P3,P4:Modus Ponem"
