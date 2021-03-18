# Derivative of x^x

If you have trouble reading the proof below,
I recommend viewing blackpenredpen's YouTube video [derivative of x^x](https://www.youtube.com/watch?v=l-iLg07zavc).
You'll find the patterns validating statements in this proof down this rabbit hole:
[Calculus](../imports/Calculus.md).
For ideas on how to set things up down the rabbit hole,
I recommend Wildberger's YouTube channel [Insights into Mathematics](https://www.youtube.com/c/njwildberger/about).
```korekto
< imports/Calculus.md
### Set up ###
:Real[x]	#S1/L2.Real 1Real
:Partial[:Dx]	#S2/L1.Calculus 1Partial
y=x^x	#S3/L11.Logic 1Let
:QED=:Dx[y]=x^x(:Ln[x]+1)	#S4/L11.Logic 1Let
### Derivation ###
:Ln[y]=:Ln[x^x]	#R5/M2.Algebra,S3 Operate both sides
:Ln[y]=x:Ln[x]	#R6/M13.Algebra,R5 Take out exponent
:Dx[:Ln[y]]=:Dx[x:Ln[x]]	#R7/M2.Algebra,R6 Operate both sides
:Dx[:Ln[y]]=:Dx[x]:Ln[x]+x:Dx[:Ln[x]]	#R8/M2.Calculus,R7 Product rule
:Dx[:Ln[y]]=1:Ln[x]+x:Dx[:Ln[x]]	#R9/M3.Calculus,R8 Dx[x]=1
:Dx[:Ln[y]]=1:Ln[x]+x(1/x)	#R10/M7.Calculus,R9 Dx[Ln[x]]=1/x
:Dx[:Ln[y]]=1:Ln[x]+1	#R11/M14.Algebra,R10 x(1/x)=1
:Dx[y]/y=1:Ln[x]+1	#R12/M5.Calculus,R11 Dx[Ln[y]]=Dx[y]/y
:Dx[y]=y(1:Ln[x]+1)	#R13/M15.Algebra,R12 Rearangement
:Dx[y]=x^x(1:Ln[x]+1)	#C14/I8.Calculus,S3,R13 Substitution
:Dx[y]=x^x(:Ln[x]+1)	#R15/M9.Calculus,C14 Identity
:QED=:Dx[y]=x^x(:Ln[x]+1)	#S4/L11.Logic This is what we wanted!
:QED	#C17/I10.Logic,S4,R15 Equally true
```
