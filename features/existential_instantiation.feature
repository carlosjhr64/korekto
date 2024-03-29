@existential_instantiation
Feature: Existential instantiation

```korekto
! V /\w/
! V {X u}
! P /.+/
! P {s t}
! :nl /\n/
! :nl {;}
:Exist[X,sxt];:and[X{u},sut]	#E1 E1: :Exist [ , x ] :and { }
f(x)=x*x	#D2
N{0,1,2,3,...}	#D3
:Exist[N,f(x)=0]	#P4
:and[N{n},f(n)=0]	#X5/E1,P4 E1
```

  Background:
    * Given command "korekto --trace"

  Scenario: Existential 1 Instantiation
    * Given option "< features/existential_instantiation.feature"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-:11:E1:E1: :Exist [ , x ] :and { }\n-:12:D2:\n-:13:D3:\n-:14:P4:\n-:15:X5/E1,P4:E1: n"
