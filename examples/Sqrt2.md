# Sqrt(2) is irrational! (Classic Proof)

If you have trouble reading the proof below,
I recommend viewing blackpenredpen's YouTube video [Sqrt(2) is irrational! (Classic Proof)](https://www.youtube.com/watch?v=BhFf0nJ5VOg).
You'll find the patterns validating statements in this proof down this rabbit hole:
[Algebra](../imports/Algebra.md).
```korekto
< imports/Algebra.md
:QED=:Not[:Rat[:Sqrt[2]]]	#S1/L11.Logic 1Let: :QED
# Need to be able to say, "Were jumping off a building here because we can fly!"
:ASSUMPTION=:Rat[:Sqrt[2]]	#P2
:Rat[:Sqrt[2]]	#R3/M29.Logic,P2 By assumption
:Rat[:Sqrt[2]]=:Exist[:Int]{i,j|(:GCF[i,j]=1)&(:Sqrt[2]=i/j)}	#T4/A2.Rational Rational numbers
:Exist[:Int]{i,j|(:GCF[i,j]=1)&(:Sqrt[2]=i/j)}	#C5/I9.Logic,T4,R3 Equally true
:Int[a]&:Int[b]&((:GCF[a,b]=1)&(:Sqrt[2]=a/b))	#X6/E27.Logic,C5 2Exist: a b
:Int[a]	#R7/M21.Logic,X6 Independantly true
:Int[b]	#R8/M22.Logic,X6 Independantly true
:GCF[a,b]=1	#R9/M23.Logic,X6 Independantly true
:Sqrt[2]=a/b	#R10/M24.Logic,X6 Independantly true
(:Sqrt[2])^2=(a/b)^2	#R11/M6.Algebra,R10 Raise both sides
2=(a/b)^2	#R12/M4.Algebra,R11 Sqrt[x]^2=x
2=a^2/b^2	#R13/M5.Algebra,R12 Power of ratio
a^2=2b^2	#R14/M7.Algebra,R13 Rearrangement
:Int[b^2]	#R15/M10.Algebra,R8 Int[Int^Int]
:Even[2b^2]	#R16/M4.Integer,R15 Integer with factor of two is even
:Even[a^2]	#C17/I7.Logic,R14,R16 Substitution
:Even[a]	#R18/M11.Algebra,C17 Even[Even^Int]
:Even[a]=:Exist[:Int]{i|a=2i}	#T19/A2.Integer Even has factor two
:Exist[:Int]{i|a=2i}	#C20/I9.Logic,T19,R18 Equally true
:Int[c]&(a=2c)	#X21/E26.Logic,C20 1Exist: c
:Int[c]	#R22/M18.Logic,X21 Independantly true
a=2c	#R23/M20.Logic,X21 Independantly true
(2c)^2=2b^2	#C24/I8.Logic,R23,R14 Substitution
2b^2=(2c)^2	#R25/M2.Logic,C24 Switch sides
2b^2=4c^2	#R26/M8.Algebra,R25 (2x)^2=4x^2
b^2=2c^2	#R27/M9.Algebra,R26 Wut
:Int[c^2]	#R28/M10.Algebra,R22 Int[Int^Int]
:Even[2c^2]	#R29/M4.Integer,R28 Integer with factor of two is even
:Even[b^2]	#C30/I7.Logic,R27,R29 Substitution
:Even[b]	#R31/M11.Algebra,C30 Even[Even^Int]
:Even[a]	#R18/M11.Algebra,C17 Integer power of even number is even
:CF[a,b][2]	#C32/I3.Integer,R18,R31 Even numbers have common factor two
:GCF[a,b]>=2	#R33/M16.Natural,C32 CGF gte any CF
:GCF[a,b]>1	#R34/M13.Natural,R33 Two is greater than one
:Not[:GCF[a,b]=1]	#R35/M15.Logic,R34 Greater than is not equal
:GCF[a,b]=1	#R9/M23.Logic,X6 Independantly true
:CONTRADICTION	#C36/I28.Logic,R9,R35 Contradiction
:ASSUMPTION=:Rat[:Sqrt[2]]	#P2
# And after being badly hurt, we admit our mistake.
:Not[:Rat[:Sqrt[2]]]	#C37/I30.Logic,P2,C36 Negate the assumption
:QED=:Not[:Rat[:Sqrt[2]]]	#S1/L11.Logic Remember this?
:QED	#C38/I3.Logic,S1,C37 Substitution
```
