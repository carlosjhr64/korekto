@modus_ponem
Feature: modus_ponem

```korekto
! V /\w/
! V {u v w}
! :NL /\n/
! :NL {;}
u;:if[u,v];v  #I Modus Ponem
S{s,t}        #D Statements
s             #P
:if[s,t]      #P
t             #C
```

  Background:
    * Given command "korekto"

  Scenario: Modus Ponem
    * Given option "< features/modus_ponem.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:9:0:I1:Modus Ponem\n-:10:0:D2:Statements\n-:11:0:P3:\n-:12:0:P4:\n-:13:0:C5/I1,P3,P4:Modus Ponem"
