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
7 + 1 = 8	#R1/M2.KorektoMath,S50.KorektoMath ≝→=
6 + 1 + 1 = 8	#C2/I185.KorektoMath,S49.KorektoMath,R1 a=b, ^b_+ → ^a_+
5 + 1 + 1 + 1 = 8	#C3/I185.KorektoMath,S48.KorektoMath,C2 a=b, ^b_+ → ^a_+
4 + 1 + 1 + 1 + 1 = 8	#C4/I185.KorektoMath,S47.KorektoMath,C3 a=b, ^b_+ → ^a_+
4 + (1 + 1) + (1 + 1) = 8	#R5/M132.KorektoMath,C4 →+_(a)_+_(b)_+
4 + 2 + 2 = 8	#C6/I180.KorektoMath,S44.KorektoMath,R5 (a)=b,(a)→b~b
3 + 1 = 4	#R7/M2.KorektoMath,S46.KorektoMath ≝→=
2 + 1 + 1 = 4	#C8/I185.KorektoMath,S45.KorektoMath,R7 a=b, ^b_+ → ^a_+
2 + (1 + 1) = 4	#R9/M131.KorektoMath,C8 +_a_+ → +_(a)_+
2 + 2 = 4	#C10/I179.KorektoMath,S44.KorektoMath,R9 (a)=b,(a)→b
4 + (2 + 2) = 8	#R11/M131.KorektoMath,C6 +_a_+ → +_(a)_+
4 + 4 = 8	#C12/I179.KorektoMath,C10,R11 (a)=b,(a)→b
# Show that 2*2=4
4 * 2 = 8	#R13/M53.KorektoMath,C12 Double
2 * 2 = 4	#R14/M53.KorektoMath,C10 Double
# Show that 2*2*2=8
(2 * 2) * 2 = 8	#C15/I181.KorektoMath,R14,R13 (a)=b;b→(a)
2 * 2 * 2 = 8	#R16/M118.KorektoMath,C15 ^(a♭*♭b)♭* → ^a♭*♭b♭*
# QED
2∧3 = 8	#R17/M57.KorektoMath,R16 Cube
```
