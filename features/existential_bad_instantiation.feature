@existential_bad_instantiation
Feature: Existential bad_instantiation

```korekto
! V /\w/
! V {X a b}
! P /.+/
! P {s t u}
! :nl /\n/
! :nl {;}
:Exist[X,sxtyu];:and[X{a},X{b},satbu]	#E1 E1: :Exist [ , x y ] :and { }
f(x)=x*x	#D2
N{0,1,2,3,...}	#D3
:Exist[N,f(x,y)=0]	#P4
:and[N{n},N{m},f(n,m)=0]	#X1/E1,P4 E1
```

  Background:
    * Given command "korekto --trace"

  Scenario: Existential 1 Instantiation
    * Given option "< features/existential_bad_instantiation.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:11:E1:E1: :Exist [ , x y ] :and { }\n-:12:D2:\n-:13:D3:\n-:14:P4:\n-:15:!:expected 1 undefined: n m"
