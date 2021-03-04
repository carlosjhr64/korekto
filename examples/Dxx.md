# [Derivative of x^x](https://www.youtube.com/watch?v=l-iLg07zavc)
```korekto
< imports/Calculus.md
### Set up ###
:Real[x]	#S1/Real.L2 1Real
:Partial[:Dx]	#S2/Calculus.L1 1Partial
y=x^x	#S3/Logic.L11 1Let
:QED=:Dx[y]=x^x(:Ln[x]+1)	#S4/Logic.L11 1Let
### Derivation ###
:Ln[y]=:Ln[x^x]	#R5/Algebra.M2,S3 Operate both sides
:Ln[y]=x:Ln[x]	#R6/Algebra.M13,R5 Take out exponent
:Dx[:Ln[y]]=:Dx[x:Ln[x]]	#R7/Algebra.M2,R6 Operate both sides
:Dx[:Ln[y]]=:Dx[x]:Ln[x]+x:Dx[:Ln[x]]	#R8/Calculus.M2,R7 Product rule
:Dx[:Ln[y]]=1:Ln[x]+x:Dx[:Ln[x]]	#R9/Calculus.M3,R8 Dx[x]=1
:Dx[:Ln[y]]=1:Ln[x]+x(1/x)	#R10/Calculus.M7,R9 Dx[Ln[x]]=1/x
:Dx[:Ln[y]]=1:Ln[x]+1	#R11/Algebra.M14,R10 x(1/x)=1
:Dx[y]/y=1:Ln[x]+1	#R12/Calculus.M5,R11 Dx[Ln[y]]=Dx[y]/y
:Dx[y]=y(1:Ln[x]+1)	#R13/Algebra.M15,R12 Rearangement
:Dx[y]=x^x(1:Ln[x]+1)	#C14/Calculus.I8,S3,R13 Substitution
:Dx[y]=x^x(:Ln[x]+1)	#R15/Calculus.M9,C14 Identity
:QED=:Dx[y]=x^x(:Ln[x]+1)	#S4/Logic.L11 This is what we wanted!
:QED	#C17/Logic.I10,S4,R15 Equally true
```
