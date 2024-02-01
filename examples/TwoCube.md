# 2∧3 = 8

* Imports: [KorektoMath](../imports/KorektoMath.md)
```korekto
< imports/KorektoMath.md
## Recall digits 2..8
7 + 1 : 8	#S50.KorektoMath/L1.KorektoMath Equivalent: 8
6 + 1 : 7	#S49.KorektoMath/L1.KorektoMath Equivalent: 7
5 + 1 : 6	#S48.KorektoMath/L1.KorektoMath Equivalent: 6
4 + 1 : 5	#S47.KorektoMath/L1.KorektoMath Equivalent: 5
3 + 1 : 4	#S46.KorektoMath/L1.KorektoMath Equivalent: 4
2 + 1 : 3	#S45.KorektoMath/L1.KorektoMath Equivalent: 3
1 + 1 : 2	#S44.KorektoMath/L1.KorektoMath Equivalent: 2
# Show that 4*2=8
7 + 1 = 8	#R1/M2.KorektoMath,S50.KorektoMath If equivalent, then equal
6 + 1 = 7	#R2/M2.KorektoMath,S49.KorektoMath If equivalent, then equal
6 + 1 + 1 = 8	#C3/I182.KorektoMath,R2,R1 a=b;b->a+
5 + 1 = 6	#R4/M2.KorektoMath,S48.KorektoMath If equivalent, then equal
5 + 1 + 1 + 1 = 8	#C5/I182.KorektoMath,R4,C3 a=b;b->a+
4 + 1 = 5	#R6/M2.KorektoMath,S47.KorektoMath If equivalent, then equal
4 + 1 + 1 + 1 + 1 = 8	#C7/I182.KorektoMath,R6,C5 a=b;b->a+
4 + (1 + 1) + (1 + 1) = 8	#R8/M131.KorektoMath,C7 →+_(a)_+_(b)_+
1 + 1 = 2	#R9/M2.KorektoMath,S44.KorektoMath If equivalent, then equal
4 + 2 + 2 = 8	#C10/I177.KorektoMath,R9,R8 (a)=b;(a)->b,b
3 + 1 = 4	#R11/M2.KorektoMath,S46.KorektoMath If equivalent, then equal
2 + 1 = 3	#R12/M2.KorektoMath,S45.KorektoMath If equivalent, then equal
2 + 1 + 1 = 4	#C13/I182.KorektoMath,R12,R11 a=b;b->a+
2 + (1 + 1) = 4	#R14/M130.KorektoMath,C13 +_a_+→+_(a)_+
2 + 2 = 4	#C15/I176.KorektoMath,R9,R14 (a)=b;(a)->b
4 + (2 + 2) = 8	#R16/M130.KorektoMath,C10 +_a_+→+_(a)_+
4 + 4 = 8	#C17/I176.KorektoMath,C15,R16 (a)=b;(a)->b
# Show that 2*2=4
4 * 2 = 8	#R18/M53.KorektoMath,C17 Double
2 * 2 = 4	#R19/M53.KorektoMath,C15 Double
# Show that 2*2*2=8
(2 * 2) * 2 = 8	#C20/I178.KorektoMath,R19,R18 (a)=b;b->(a)
2 * 2 * 2 = 8	#R21/M117.KorektoMath,C20 ^(a♭*♭b)♭*→^a♭*♭b♭*
# QED
2∧3 = 8	#R22/M57.KorektoMath,R21 Cube
```
