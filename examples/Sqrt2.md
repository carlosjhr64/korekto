# [Sqrt(2) is irrational! (Classic Proof)](https://www.youtube.com/watch?v=BhFf0nJ5VOg)
```korekto
< imports/Algebra.md
:QED=:Not[:Rat[:Sqrt[2]]]	#S1/Logic.L11 1Let
# Need to be able to say, "Were jumping off a building here because we can fly!"
:ASSUMPTION=:Rat[:Sqrt[2]]	#P2
:Rat[:Sqrt[2]]	#R3/Logic.M29,P2 By assumption
:Rat[:Sqrt[2]]=:Exist[:Int]{i,j|(:GCF[i,j]=1)&(:Sqrt[2]=i/j)}	#T4/Rational.A2 Rational numbers
:Exist[:Int]{i,j|(:GCF[i,j]=1)&(:Sqrt[2]=i/j)}	#C5/Logic.I9,T4,R3 Equally true
:Int[a]&:Int[b]&((:GCF[a,b]=1)&(:Sqrt[2]=a/b))	#X6/Logic.E27,C5 2Exist
:Int[a]	#R7/Logic.M21,X6 Independantly true
:Int[b]	#R8/Logic.M22,X6 Independantly true
:GCF[a,b]=1	#R9/Logic.M23,X6 Independantly true
:Sqrt[2]=a/b	#R10/Logic.M24,X6 Independantly true
(:Sqrt[2])^2=(a/b)^2	#R11/Algebra.M6,R10 Raise both sides
2=(a/b)^2	#R12/Algebra.M4,R11 Sqrt[x]^2=x
2=a^2/b^2	#R13/Algebra.M5,R12 Power of ratio
a^2=2b^2	#R14/Algebra.M7,R13 Rearrangement
:Int[b^2]	#R15/Algebra.M10,R8 Int[Int^Int]
:Even[2b^2]	#R16/Integer.M4,R15 Integer with factor of two is even
:Even[a^2]	#C17/Logic.I7,R14,R16 Substitution
:Even[a]	#R18/Algebra.M11,C17 Even[Even^Int]
:Even[a]=:Exist[:Int]{i|a=2i}	#T19/Integer.A2 Even has factor two
:Exist[:Int]{i|a=2i}	#C20/Logic.I9,T19,R18 Equally true
:Int[c]&(a=2c)	#X21/Logic.E26,C20 1Exist
:Int[c]	#R22/Logic.M18,X21 Independantly true
a=2c	#R23/Logic.M20,X21 Independantly true
(2c)^2=2b^2	#C24/Logic.I8,R23,R14 Substitution
2b^2=(2c)^2	#R25/Logic.M2,C24 Switch sides
2b^2=4c^2	#R26/Algebra.M8,R25 (2x)^2=4x^2
b^2=2c^2	#R27/Algebra.M9,R26 Wut
:Int[c^2]	#R28/Algebra.M10,R22 Int[Int^Int]
:Even[2c^2]	#R29/Integer.M4,R28 Integer with factor of two is even
:Even[b^2]	#C30/Logic.I7,R27,R29 Substitution
:Even[b]	#R31/Algebra.M11,C30 Even[Even^Int]
:Even[a]	#R18/Algebra.M11,C17 Integer power of even number is even
:CF[a,b][2]	#C33/Integer.I3,R18,R31 Even numbers have common factor two
:GCF[a,b]>=2	#R34/Natural.M16,C33 CGF gte any CF
:GCF[a,b]>1	#R35/Natural.M13,R34 Two is greater than one
:Not[:GCF[a,b]=1]	#R36/Logic.M15,R35 Greater than is not equal
:GCF[a,b]=1	#R9/Logic.M23,X6 Independantly true
:CONTRADICTION	#C38/Logic.I28,R9,R36 Contradiction
:ASSUMPTION=:Rat[:Sqrt[2]]	#P2
# And after being badly hurt, we admit our mistake.
:Not[:Rat[:Sqrt[2]]]	#C40/Logic.I30,P2,C38 Negate the assumption
:QED=:Not[:Rat[:Sqrt[2]]]	#S1/Logic.L11 Remember this?
:QED	#C42/Logic.I3,S1,C40 Substitution
```
