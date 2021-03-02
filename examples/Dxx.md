# [Derivative of x^x](https://www.youtube.com/watch?v=l-iLg07zavc)
```korekto
< imports/Calculus.md
### Set up ###
:Real[x]	#S1/Calculus.L1 1Real
:Partial[:Dx]	#S2/Calculus.L2 1Partial
y=x^x	#S3/Logic.L3 1Let
:QED=:Dx[y]=x^x(:Ln[x]+1)	#S4/Logic.L3 1Let
### Derivation ###
:Ln[y]=:Ln[x^x]	#R5/Algebra.M2,S3 Operate both sides
:Ln[y]=x:Ln[x]	#R6/Algebra.M4,R5 Take out exponent
:Dx[:Ln[y]]=:Dx[x:Ln[x]]	#R7/Algebra.M2,R6 Operate both sides
:Dx[:Ln[y]]=:Dx[x]:Ln[x]+x:Dx[:Ln[x]]	#R8/Calculus.M3,R7 Product rule
:Dx[:Ln[y]]=1:Ln[x]+x:Dx[:Ln[x]]	#R9/Calculus.M4,R8 Dx[x] is one
:Dx[:Ln[y]]=1:Ln[x]+x(1/x)	#R10/Calculus.M7,R9
:Dx[:Ln[y]]=1:Ln[x]+1	#R11/Algebra.M10,R10
:Dx[y]/y=1:Ln[x]+1	#R12/Calculus.M8,R11
:Dx[y]=y(1:Ln[x]+1)	#R13/Algebra.M11,R12
:Dx[y]=x^x(1:Ln[x]+1)	#C14/Algebra.I12,S3,R13 Substitution
:Dx[y]=x^x(:Ln[x]+1)	#R15/Algebra.M13,C14
:QED=:Dx[y]=x^x(:Ln[x]+1)	#S4/Bootstrap.L1 This is what we wanted!
:QED	#C17/Bootstrap.I4,S4,R15 Equally true
```
