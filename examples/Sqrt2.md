# [Sqrt(2) is irrational! (Classic Proof)](https://www.youtube.com/watch?v=BhFf0nJ5VOg)
```korekto
< imports/Rational.md
< imports/Algebra.md
:QED=:Not[:Rat[:Sqrt[2]]]	#D1
# Need to be able to say, "Were jumping off a building here because we can fly!"
:ASSUMPTION=:Rat[:Sqrt[2]]	#P2
:Rat[:Sqrt[2]]	#R3/Bootstrap.M19,P2 By assumption
:Rat[:Sqrt[2]]=:Exist[:Int]{i,j|(:GCF[i,j]=1)&(:Sqrt[2]=i/j)}	#T4/Rational.A1 Rational number
:Exist[:Int]{i,j|(:GCF[i,j]=1)&(:Sqrt[2]=i/j)}	#C5/Bootstrap.I2,T4,R3 Equally true
((:Int[a])&(:Int[b]))&((:GCF[a,b]=1)&(:Sqrt[2]=a/b))	#X6/Bootstrap.E18,C5 Existential(2)
:Int[a]	#R7/Bootstrap.M13,X6 Independantly true
:Int[b]	#R8/Bootstrap.M14,X6 Independantly true
:GCF[a,b]=1	#R9/Bootstrap.M15,X6 Independantly true
:Sqrt[2]=a/b	#R10/Bootstrap.M16,X6 Independantly true
(:Sqrt[2])^2=(a/b)^2	#R11/Algebra.M7,R10 Raise both sides by same amount
(2)=(a/b)^2	#R12/Algebra.M2,R11 Sqrt[x]^2=x
(2)=(a^2)/(b^2)	#R13/Algebra.M3,R12 Power of ratio
(a^2)=(2)(b^2)	#R14/Algebra.M4,R13 Rearrangement
a^2=2(b^2)	#R15/Bootstrap.M24,R14 Unmark two
:Int[b^2]	#R16/Integer.M4,R8 Integers closed under multiplication
:Even[2(b^2)]	#R17/Integer.M5,R16 Even numbers have a factor of two
:Even[a^2]	#C18/Bootstrap.I7,R15,R17 Substitution
:Even[a]	#R19/Integer.M2,C18 Integer power is even iff number is even
:Even[a]=:Exist[:Int]{i|a=2i}	#T20/Integer.A1 Definition of Even
:Exist[:Int]{i|a=2i}	#C21/Bootstrap.I2,T20,R19 Equally true
(:Int[c])&(a=2c)	#X22/Bootstrap.E17,C21 Existential(1)
:Int[c]	#R23/Bootstrap.M12,X22 Independantly true
a=2c	#R24/Bootstrap.M11,X22 Independantly true
(2c)^2=2(b^2)	#C25/Bootstrap.I10,R24,R15 Substitution
2(b^2)=(2c)^2	#R26/Bootstrap.M1,C25 Commutative
2(b^2)=4(c^2)	#R27/Algebra.M5,R26 (2x)^2=4(x^2)
b^2=2(c^2)	#R28/Algebra.M6,R27 Divide both sides by two
:Int[c^2]	#R29/Integer.M4,R23 Integers closed under multiplication
:Even[2(c^2)]	#R30/Integer.M5,R29 Even numbers have a factor of two
:Even[b^2]	#C31/Bootstrap.I7,R28,R30 Substitution
:Even[b]	#R32/Integer.M2,C31 Integer power is even iff number is even
:Even[a]	#R19/Integer.M2,C18 Integer power of even number is even
:CF[a,b][2]	#C34/Integer.I6,R19,R32 Even numbers have a factor of two
:GCF[a,b]>=2	#R35/Integer.M7,C34 GCF is gte any CF
:GCF[a,b]>1	#R36/Integer.M8,R35 Two is more than one
:Not[:GCF[a,b]=1]	#R37/Integer.M9,R36 More than one is not one
:GCF[a,b]=1	#R9/Bootstrap.M15,X6 Independantly true
:CONTRADICTION	#C39/Bootstrap.I20,R9,R37 Implied contradiction
:ASSUMPTION=:Rat[:Sqrt[2]]	#P2
# And after being badly hurt, we admit our mistake.
:Not[:Rat[:Sqrt[2]]]	#C41/Bootstrap.I21,P2,C39 Negate the assumption
:QED=:Not[:Rat[:Sqrt[2]]]	#D1
:QED	#C43/Bootstrap.I3,D1,C41 Equally true
```
