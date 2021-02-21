# [Sqrt(2) is irrational! (Classic Proof)](https://www.youtube.com/watch?v=BhFf0nJ5VOg)
```korekto
< examples/imports/Rational.md
< examples/imports/Algebra.md
:QED=:Not[:Rat[:Sqrt[2]]]	#D1
# Need to be able to say, "Were jumping off a building here because we can fly!"
:ASSUMPTION=:Rat[:Sqrt[2]]	#P2
:Rat[:Sqrt[2]]	#R3/M19.Bootstrap,P2 By assumption
:Rat[:Sqrt[2]]=:Exist[:Int]{i,j|(:GCF[i,j]=1)&(:Sqrt[2]=i/j)}	#T4/A1.Rational Rational number definition
:Exist[:Int]{i,j|(:GCF[i,j]=1)&(:Sqrt[2]=i/j)}	#C5/I2.Bootstrap,T4,R3 Equally true
((:Int[a])&(:Int[b]))&((:GCF[a,b]=1)&(:Sqrt[2]=a/b))	#X6/E18.Bootstrap,C5 EI pair
:Int[a]	#R7/M13.Bootstrap,X6 Independantly true
:Int[b]	#R8/M14.Bootstrap,X6 Independantly true
:GCF[a,b]=1	#R9/M15.Bootstrap,X6 Independantly true
:Sqrt[2]=a/b	#R10/M16.Bootstrap,X6 Independantly true
(:Sqrt[2])^2=(a/b)^2	#R11/M7.Algebra,R10 Equal postfix
(2)=(a/b)^2	#R12/M2.Algebra,R11
(2)=(a^2)/(b^2)	#R13/M3.Algebra,R12
(a^2)=(2)(b^2)	#R14/M4.Algebra,R13
a^2=2(b^2)	#R15/M24.Bootstrap,R14 Unmark raised logogram
:Int[b^2]	#R16/M3.Integer,R8
:Even[2(b^2)]	#R17/M4.Integer,R16
:Even[a^2]	#C18/I7.Bootstrap,R15,R17 Substitution
:Even[a]	#R19/M2.Integer,C18
:Even[a]=:Exist[:Int]{i|a=2i}	#T20/A1.Integer
:Exist[:Int]{i|a=2i}	#C21/I2.Bootstrap,T20,R19 Equally true
(:Int[c])&(a=2c)	#X22/E17.Bootstrap,C21 EI
:Int[c]	#R23/M12.Bootstrap,X22 Independantly true
a=2c	#R24/M11.Bootstrap,X22 Independantly true
(2c)^2=2(b^2)	#C25/I10.Bootstrap,R24,R15 Substitution
2(b^2)=(2c)^2	#R26/M1.Bootstrap,C25
2(b^2)=4(c^2)	#R27/M5.Algebra,R26
b^2=2(c^2)	#R28/M6.Algebra,R27
:Int[c^2]	#R29/M3.Integer,R23
:Even[2(c^2)]	#R30/M4.Integer,R29
:Even[b^2]	#C31/I7.Bootstrap,R28,R30 Substitution
:Even[b]	#R32/M2.Integer,C31
:Even[a]	#R19/M2.Integer,C18
:CF[a,b][2]	#C34/I5.Integer,R19,R32
:GCF[a,b]>=2	#R35/M6.Integer,C34
:GCF[a,b]>1	#R36/M7.Integer,R35
:Not[:GCF[a,b]=1]	#R37/M8.Integer,R36
:GCF[a,b]=1	#R9/M15.Bootstrap,X6 Independantly true
:CONTRADICTION	#C39/I20.Bootstrap,R9,R37 Implied contradiction
:ASSUMPTION=:Rat[:Sqrt[2]]	#P2
# And after being badly hurt, we admit our mistake.
:Not[:Rat[:Sqrt[2]]]	#C41/I21.Bootstrap,C39,P2 Negate the assumption
:QED=:Not[:Rat[:Sqrt[2]]]	#D1
:QED	#C43/I3.Bootstrap,D1,C41 Equally true
```
