# 2∧3 = 8

* Imports: [KorektoMath](../imports/KorektoMath.md)
```korekto
< imports/KorektoMath.md
## Recall digits 2..8
7 + 1 : 8	#S54.KorektoMath/L1.KorektoMath Equivalent: 8
6 + 1 : 7	#S53.KorektoMath/L1.KorektoMath Equivalent: 7
5 + 1 : 6	#S52.KorektoMath/L1.KorektoMath Equivalent: 6
4 + 1 : 5	#S51.KorektoMath/L1.KorektoMath Equivalent: 5
3 + 1 : 4	#S50.KorektoMath/L1.KorektoMath Equivalent: 4
2 + 1 : 3	#S49.KorektoMath/L1.KorektoMath Equivalent: 3
1 + 1 : 2	#S48.KorektoMath/L1.KorektoMath Equivalent: 2
# Show that 4*2=8
7 + 1 = 8	#R1/M2.KorektoMath,S54.KorektoMath ≝→=
6 + 1 + 1 = 8	#C2/I250.KorektoMath,S53.KorektoMath,R1 G=F, ^F_± → ^G_±
5 + 1 + 1 + 1 = 8	#C3/I250.KorektoMath,S52.KorektoMath,C2 G=F, ^F_± → ^G_±
4 + 1 + 1 + 1 + 1 = 8	#C4/I250.KorektoMath,S51.KorektoMath,C3 G=F, ^F_± → ^G_±
4 + (1 + 1) + (1 + 1) = 8	#R5/M161.KorektoMath,C4 →+_(G)_+_(F)_±
4 + 2 + 2 = 8	#C6/I244.KorektoMath,S48.KorektoMath,R5 G=a,(G)→a~a
3 + 1 = 4	#R7/M2.KorektoMath,S50.KorektoMath ≝→=
2 + 1 + 1 = 4	#C8/I250.KorektoMath,S49.KorektoMath,R7 G=F, ^F_± → ^G_±
2 + (1 + 1) = 4	#R9/M160.KorektoMath,C8 +_G_± → +_(G)_±
2 + 2 = 4	#C10/I246.KorektoMath,S48.KorektoMath,R9 G=a,(G)→a
4 + (2 + 2) = 8	#R11/M160.KorektoMath,C6 +_G_± → +_(G)_±
4 + 4 = 8	#C12/I246.KorektoMath,C10,R11 G=a,(G)→a
# Show that 2*2=4
4 * 2 = 8	#R13/M60.KorektoMath,C12 Double
2 * 2 = 4	#R14/M60.KorektoMath,C10 Double
# Show that 2*2*2=8
(2 * 2) * 2 = 8	#C15/I243.KorektoMath,R14,R13 G=a,a→(G)
2 * 2 * 2 = 8	#R16/M134.KorektoMath,C15 +(a♭*♭b)+ → +a♭*♭b+
# QED
2∧3 = 8	#R17/M64.KorektoMath,R16 Cube
```
