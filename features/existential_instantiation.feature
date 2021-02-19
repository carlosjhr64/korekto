@existential_instantiation
Feature: existential_instantiation

```korekto
! V /\w/
! V {X u}
! P /.+/
! P {s t}
! :nl /\n/
! :nl {;}
:Exist[X,sxt];:and[X{u},sut]	#E1 EI
f(x)=x*x	#D2
N{0,1,2,3,...}	#D3
:Exist[N,f(x)=0]	#P4
:and[N{n},f(n)=0]	#X5/E1,P4 EI
```

  Background:
    * Given command "korekto"

  Scenario: Existential Instantiation
    * Given option "< features/existential_instantiation.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:11:E1:EI\n-:12:D2:\n-:13:D3:\n-:14:P4:\n-:15:X5/E1,P4:EI"
