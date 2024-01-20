# 2∧3 = 8

* Imports: [KorektoMath](../imports/KorektoMath.md)
```korekto
< imports/KorektoMath.md
## Recall digits 2..8
7 + 1 : 8	#S45.KorektoMath/L1.KorektoMath Equivalent: 8
6 + 1 : 7	#S44.KorektoMath/L1.KorektoMath Equivalent: 7
5 + 1 : 6	#S43.KorektoMath/L1.KorektoMath Equivalent: 6
4 + 1 : 5	#S42.KorektoMath/L1.KorektoMath Equivalent: 5
3 + 1 : 4	#S41.KorektoMath/L1.KorektoMath Equivalent: 4
2 + 1 : 3	#S40.KorektoMath/L1.KorektoMath Equivalent: 3
1 + 1 : 2	#S39.KorektoMath/L1.KorektoMath Equivalent: 2
# Show that 4*2=8
7 + 1 = 8	#R1/M2.KorektoMath,S45.KorektoMath If equivalent, then equal
6 + 1 = 7	#R2/M2.KorektoMath,S44.KorektoMath If equivalent, then equal
6 + 1 + 1 = 8	#C3/I130.KorektoMath,R2,R1 a=b;b->a+
5 + 1 = 6	#R4/M2.KorektoMath,S43.KorektoMath If equivalent, then equal
5 + 1 + 1 + 1 = 8	#C5/I130.KorektoMath,R4,C3 a=b;b->a+
4 + 1 = 5	#R6/M2.KorektoMath,S42.KorektoMath If equivalent, then equal
4 + 1 + 1 + 1 + 1 = 8	#C7/I130.KorektoMath,R6,C5 a=b;b->a+
4 + (1 + 1) + (1 + 1) = 8	#R8/M88.KorektoMath,C7 +Group+Group+
1 + 1 = 2	#R9/M2.KorektoMath,S39.KorektoMath If equivalent, then equal
4 + 2 + 2 = 8	#C10/I125.KorektoMath,R9,R8 (a)=b;(a)->b,b
3 + 1 = 4	#R11/M2.KorektoMath,S41.KorektoMath If equivalent, then equal
2 + 1 = 3	#R140.KorektoMath/M2.KorektoMath,S40.KorektoMath If equivalent, then equal
2 + 1 + 1 = 4	#C12/I130.KorektoMath,R140.KorektoMath,R11 a=b;b->a+
2 + (1 + 1) = 4	#R13/M87.KorektoMath,C12 +Group+
2 + 2 = 4	#C14/I124.KorektoMath,R9,R13 (a)=b;(a)->b
4 + (2 + 2) = 8	#R15/M87.KorektoMath,C10 +Group+
4 + 4 = 8	#C16/I124.KorektoMath,C14,R15 (a)=b;(a)->b
# Show that 2*2=4
4 * 2 = 8	#R17/M48.KorektoMath,C16 Double
2 * 2 = 4	#R18/M48.KorektoMath,C14 Double
# Show that 2*2*2=8
(2 * 2) * 2 = 8	#C19/I126.KorektoMath,R18,R17 (a)=b;b->(a)
2 * 2 * 2 = 8	#R20/M79.KorektoMath,C19 ^(a*b)*->a*b*
# QED
2∧3 = 8	#R21/M52.KorektoMath,R20 Cube
```
