# Integer
```korekto
< examples/imports/Bootstrap.md
:Even[A]=:Exist[:Int]{i|A=2i}	#A1 Definition of Even
:Even[A^I];Even[A]	#M2 Integer power is even iff number is even
:Even[A];Even[A^I]	#M3 Integer power is even iff number is even
:Int[A];:Int[A^2]	#M4 Integers closed under multiplication
:Int[a];:Even[2(a)]	#M5 Even numbers have a factor of two
:Even[A];:Even[B];:CF[A,B][2]	#I6 Even numbers have a factor of two
:CF[A,B][I];:GCF[A,B]>=I	#M7 GCF is gte any CF
a>=2;a>1	#M8 Two is more than one
:GCF[A,B]>1;:Not[:GCF[A,B]=1]	#M9 More than one is not one
```
