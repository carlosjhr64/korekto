# [Sqrt(2) is irrational! (Classic Proof)](https://www.youtube.com/watch?v=BhFf0nJ5VOg)
```korekto
< examples/imports/Rational.md
< examples/imports/Algebra.md
:QED=:Not[:Rat[:Sqrt[2]]]	#D5
# Need to be able to say, "Were jumping off a building here because we can fly!"
:ASSUMPTION=:Rat[:Sqrt[2]]	#P7
:Rat[:Sqrt[2]]	#R8/M45.Bootstrap,P7 By assumption
:Rat[:Sqrt[2]]=:Exist[:Int]{i,j|(:GCF[i,j]=1)&(:Sqrt[2]=i/j)}	#T9/A4.Rational Rational number definition
:Exist[:Int]{i,j|(:GCF[i,j]=1)&(:Sqrt[2]=i/j)}	#C10/I25.Bootstrap,T9,R8 Equally true
((:Int[a])&(:Int[b]))&((:GCF[a,b]=1)&(:Sqrt[2]=a/b))	#X11/E43.Bootstrap,C10 EI pair
:Int[a]	#R12/M37.Bootstrap,X11 Independantly true
:Int[b]	#R13/M38.Bootstrap,X11 Independantly true
:GCF[a,b]=1	#R14/M39.Bootstrap,X11 Independantly true
:Sqrt[2]=a/b	#R15/M40.Bootstrap,X11 Independantly true
(:Sqrt[2])^2=(a/b)^2	#R16/M10.Algebra,R15 Equal postfix
(2)=(a/b)^2	#R17/M5.Algebra,R16
(2)=(a^2)/(b^2)	#R18/M6.Algebra,R17
(a^2)=(2)(b^2)	#R19/M7.Algebra,R18
a^2=2(b^2)	#R20/M52.Bootstrap,R19 Unmark raised logogram
:Int[b^2]	#R21/M6.Integer,R13
:Even[2(b^2)]	#R22/M7.Integer,R21
:Even[a^2]	#C23/I30.Bootstrap,R20,R22 Substitution
:Even[a]	#R24/M5.Integer,C23
:Even[a]=:Exist[:Int]{i|a=2i}	#T25/A4.Integer
:Exist[:Int]{i|a=2i}	#C26/I25.Bootstrap,T25,R24 Equally true
(:Int[c])&(a=2c)	#X27/E42.Bootstrap,C26 EI
:Int[c]	#R28/M36.Bootstrap,X27 Independantly true
a=2c	#R29/M35.Bootstrap,X27 Independantly true
(2c)^2=2(b^2)	#C30/I33.Bootstrap,R29,R20 Substitution
2(b^2)=(2c)^2	#R31/M24.Bootstrap,C30
2(b^2)=4(c^2)	#R32/M8.Algebra,R31
b^2=2(c^2)	#R33/M9.Algebra,R32
:Int[c^2]	#R34/M6.Integer,R28
:Even[2(c^2)]	#R35/M7.Integer,R34
:Even[b^2]	#C36/I30.Bootstrap,R33,R35 Substitution
:Even[b]	#R37/M5.Integer,C36
:Even[a]	#R24/M5.Integer,C23
:CF[a,b][2]	#C39/I8.Integer,R24,R37
:GCF[a,b]>=2	#R40/M9.Integer,C39
:GCF[a,b]>1	#R41/M10.Integer,R40
:Not[:GCF[a,b]=1]	#R42/M11.Integer,R41
:GCF[a,b]=1	#R14/M39.Bootstrap,X11 Independantly true
:CONTRADICTION	#C44/I46.Bootstrap,R14,R42 Implied contradiction
:ASSUMPTION=:Rat[:Sqrt[2]]	#P7
# And after being badly hurt, we admit our mistake.
:Not[:Rat[:Sqrt[2]]]	#C47/I47.Bootstrap,C44,P7 Negate the assumption
:QED=:Not[:Rat[:Sqrt[2]]]	#D5
:QED	#C49/I26.Bootstrap,D5,C47 Equally true
```
