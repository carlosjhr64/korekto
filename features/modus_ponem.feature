@modus_ponem
Feature: modus_ponem

```korekto
! V /\w/
! V {u v w}
! :nl /\n/
! :nl {;}
u;:if[u,v];v	#I9 Modus Ponem
S{s,t}	#D10 Statements
s	#P11
:if[s,t]	#P12
t	#C13/I9,P11,P12 Modus Ponem
```

  Background:
    * Given command "korekto"

  Scenario: Modus Ponem
    * Given option "< features/modus_ponem.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:9:I9:Modus Ponem\n-:10:D10:Statements\n-:11:P11:\n-:12:P12:\n-:13:C13/I9,P11,P12:Modus Ponem"
