@existential_bad_instantiation
Feature: existential_bad_instantiation

```korekto
! V /\w/
! V {X a b}
! P /.+/
! P {s t u}
! :nl /\n/
! :nl {;}
:Exist[X,sxtyu];:and[X{a},X{b},satbu]	#E11 E1
f(x)=x*x	#D12
N{0,1,2,3,...}	#D13
:Exist[N,f(x,y)=0]	#P14
:and[N{n},N{m},f(n,m)=0]	#X15/E11,P14 E1
```

  Background:
    * Given command "korekto"

  Scenario: Existential 1 Instantiation
    * Given option "< features/existential_bad_instantiation.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:11:E11:E1\n-:12:D12:\n-:13:D13:\n-:14:P14:\n-:15:!:expected 1 instantiations, got: n m"
