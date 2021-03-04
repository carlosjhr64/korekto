# Logic
```korekto
< imports/Syntax.md
### Logic ###
# Equality
A=B;aAb;aBb	#I1 Substitution: =
a=b;b=a	#M2 Switch sides
A=B;aBb;aAb	#I3 Substitution
a=b;c(a)d;c(b)d	#I4 Substitution: ( )
a=b;c(b)d;c(a)d	#I5 Substitution
a=b;c[a]d;c[b]d	#I6 Substitution: [ ]
a=b;c[b]d;c[a]d	#I7 Substitution
A=a;bAc;b(a)c	#I8 Substitution
a=b;a;b	#I9 Equally true
a=b;b;a	#I10 Equally true
# Let
A=a	#L11 1Let
A[B]=a	#L12 1Let
A[B,C]=a	#L13 1Let: ,
# Not
a':Not[a]	#A14 Not: ' :Not
# Greater than
A>B;:Not[A=B]	#M15 Greater than is not equal: >
# Less than
A<B;:Not[A=B]	#M16 : <
# And
A;B;A&B	#I17 Conjunction: &
A&B;A	#M18 Independantly true
A&B;B	#M19 Independantly true
A&(a);a	#M20 Independantly true
A&B&C;A	#M21 Independantly true
A&B&C;B	#M22 Independantly true
A&B&((c)&(d));c	#M23 Independantly true
A&B&((c)&(d));d	#M24 Independantly true
# Sets
A={aBb};A[B]	#M25 Element of: { }
# Exist
:Exist[A]{B|aBb};A[C]&(aCb)	#E26 1Exist: :Exist |
:Exist[A]{B,C|aBbCcBdCe};A[D]&A[E]&(aDbEcDdEe)	#E27 2Exist
# Proofing
a;:Not[a];:CONTRADICTION	#I28 Contradiction: :CONTRADICTION
:ASSUMPTION=a;a	#M29 By assumption: :ASSUMPTION
:ASSUMPTION=a;:CONTRADICTION;:Not[a]	#I30 Negate the assumption
```
