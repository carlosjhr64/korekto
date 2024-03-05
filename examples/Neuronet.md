# Neuronet wiki

The following is a `Korekto` review of
[Neuronet wiki](https://github.com/carlosjhr64/neuronet/wiki).

## Review of the math

Please allow the terse notation as the algebra gets gnarly.
Operator precedence is as follows:

* Unary operators
* raise, root, log: `∧, ∨, 𝓵`
* multiplication, division: `*, /`
* addition, subtraction: `+, -`
* equality: `=`

But I add spacing to create groups:

* `𝑎 + 𝑏/𝑐 + 𝑑 = 𝑎 + (𝑏/𝑐) + 𝑑`
* `𝑎+𝑏 / 𝑐+𝑑 = (𝑎+𝑏) / (𝑐+𝑑)`

The above spacing rule reduces the amount of symbols needed to show structure
and makes the algebra less cluttered.

The product, `*`, may be implied:

* `𝑎*𝑏 = 𝑎 𝑏 = 𝑎𝑏`
* `(𝑎+𝑏)*(𝑐+𝑑) = 𝑎+𝑏 𝑐+𝑑`
* `𝑥² = 𝑥𝑥 = 𝑥*𝑥`

Definitions are set by `:` and consequent equivalences by `=`.

I may use "Einstein Notation".
And once indices are shown, they may be dropped:

* `∑ₙ(𝑾ₙ*𝒂ₙ) : 𝑾ⁿ𝒂ₙ : 𝑾𝒂`

Be aware of the above rules.

## Exponential, Logarithm, Squash(Sigmoid), and Unsquash(Logit)

Please allow the following terse notation for the following functions:

* Exponentiation: `⌉(𝑥) : Math.exp(𝑥)`
* Squash: `⌈(𝑥) : 1 / (1 + Math.exp(-𝑥))`
* Logarithm: `⌊(𝑥) : Math.log(𝑥)`
* Unsquash: `⌋(𝑥) : Math.log(𝑥 / (1 - 𝑥))`

Notice that `⌊` looks like an 'L' for logarithm.
Invert `⌊` and you get `⌉` for exponentiation.
Reflect `⌉` and you get `⌈` for squash.
Invert `⌈` and you get `⌋` for unsquash.

Squash and unsquash shrinks nicely as:

* Squash: `⌈𝑥 = 1 / 1+⌉-𝑥`
* Unsquash: `⌋𝑥 = ⌊ 𝑥/(1-𝑥)`

## Binary Balance function

Consider the following function:

* `𝓑(𝑥) : 𝑥 * (1 - 𝑥)`
  * `𝓑𝑥 = 𝑥(1-𝑥)`

I'll show that the derivative of the Squash function can be written as:

* `𝓓ₓ(⌈(𝑥)) = 𝓑(⌈(𝑥))`
  * `𝓓ₓ⌈𝑥 = 𝓑⌈𝑥`

There seems to be no consensus on what to call `𝓑`, so
my vote is "Binary Balance".

## Next level unary postfix operator, `₊` 

Consider values in collection `𝒂` at level "ᵣ" dependent on values in
the collection at level "ₛ":

* `𝒂ᵣ : ⌈(𝒃ᵣ + ∑ₛ(𝑾ᵣₛ * 𝒂ₛ))`

The index `ᵣ` enumerates values of `𝒂` in level "ᵣ", whereas `ₛ` enumerates
values of `𝒂` in level "ₛ".  The levels are labeled alphabetically:

* `{ᵣ ₛ ₜ ᵤ}` # Won't need more

I'll want to express the relation between levels without specifying the level.
Given the above, please allow:

* `𝒂 = ⌈ 𝒃+𝑾𝒂₊`

The next level operator `₊` shifts the (context)label to the next level.

* `𝒂ᵣ₊ : 𝒂ₛ`

## Korekto Math

The following is written in [Korekto](https://github.com/carlosjhr64/korekto)
code blocks. I will be importing [KorektoMath](../imports/KorektoMath.md).

### Introductions
```korekto
< imports/KorektoMath.md
? length < 50
# Euler's constant 𝖊 ~ 2.718⋯
𝖊 : ∑ₙ 1/𝑛!	#S96.KorektoMath/L1.KorektoMath ≝: 𝖊
# Scalar variable 𝑥 to help define functions
Scalar[𝑥]	#S1/L23.KorektoMath Scalar: 𝑥
# The labeled activation layer vector 𝒂
Vector[𝒂]	#S2/L24.KorektoMath Vector: 𝒂
# The labeled bias vector 𝒃
Vector[𝒃]	#S3/L24.KorektoMath Vector: 𝒃
# The multi-labeled weights matrix 𝑾
Tensor[𝑾]	#S4/L25.KorektoMath Tensor: 𝑾
# Level labels
ColumnVectors : {ᵣ ₛ ₜ ᵤ}	#S5/L1.KorektoMath ≝: ColumnVectors ᵣ ₛ ₜ ᵤ
RowVectors : {ʳ ˢ ᵗ ᵘ}	#S6/L1.KorektoMath ≝: RowVectors ʳ ˢ ᵗ ᵘ
# Next level labels
ᵣ₊ = ₛ	#R7/M6.KorektoMath,S5 Next
ₛ₊ = ₜ	#R8/M6.KorektoMath,S5 Next
ₜ₊ = ᵤ	#R9/M6.KorektoMath,S5 Next
# Raised labels
ᵣ → ʳ	#C10/I10.KorektoMath,S5,S6 1st
ₛ → ˢ	#C11/I11.KorektoMath,S5,S6 2nd
ₜ → ᵗ	#C12/I12.KorektoMath,S5,S6 3rd
ᵤ → ᵘ	#C13/I13.KorektoMath,S5,S6 4th
# Natural Exponentiation and Logarythm
𝖊∧𝑥 : 𝖊ˣ	#S14/L1.KorektoMath ≝: ˣ
𝖊𝓵𝖊ˣ = 𝑥	#R15/M43.KorektoMath,S14 ∧→𝓵
# Exp and Log are inverses of eachother
𝖊𝓵(𝖊ˣ) = 𝑥	#R16/M104.KorektoMath,R15 a → (a)
𝖊𝓵(𝖊∧𝑥) = 𝑥	#C17/I246.KorektoMath,S14,R16 G=F,(F)→(G)
𝖊𝓵(𝖊∧(𝑥)) = 𝑥	#R18/M104.KorektoMath,C17 a → (a)
𝖊𝓵(𝖊∧(𝓍)) = 𝓍	#A19/R18 Inverses 𝓵∧
# Likewise:
𝖊∧(𝖊𝓵(𝓍)) = 𝓍	#A20 Inverses ∧𝓵
```
### Natural exponentiation function
```korekto
# In Ruby, the natural exponentiation function is:
#     Math.exp(x) == Math::E**x #=> true
# Here its:
⌉𝑥 = 𝖊∧𝑥	#T21/A97.KorektoMath Exp
# Prove ⌉0 = 𝖊∧0 = 1
⌉0 = 𝖊∧0	#T22/A97.KorektoMath Exp
⌉0 = 𝖊∧(0)	#R23/M104.KorektoMath,T22 a → (a)
𝑥 - 𝑥 = 0	#T24/A29.KorektoMath Zero
⌉0 = 𝖊∧(𝑥 - 𝑥)	#C25/I246.KorektoMath,T24,R23 G=F,(F)→(G)
⌉0 = 𝖊∧(𝑥 + -𝑥)	#R26/M254.KorektoMath,C25 a-b=a+-b
⌉0 = 𝖊∧𝑥*𝖊∧-𝑥	#R27/M258.KorektoMath,R26 a^(b+c)=a^b*a^c
⌉0 = (𝖊∧𝑥)*(𝖊∧-𝑥)	#R28/M174.KorektoMath,R27 a^b~c^d → (a^b)~(c^c)
# Then:
𝖊∧-𝑥 = 1 / 𝖊∧𝑥	#T29/A39.KorektoMath Reciprical
⌉0 = (𝖊∧𝑥)*(1 / 𝖊∧𝑥)	#C30/I245.KorektoMath,T29,R28 G=F,(G)→(F)
⌉0 = (𝖊∧𝑥)*(1 / (𝖊∧𝑥))	#R31/M154.KorektoMath,C30 _g)→_(g))
⌉0 = ((𝖊∧𝑥) / (𝖊∧𝑥))	#R32/M209.KorektoMath,R31 x*(1_/_g) → (x_/_g)
⌉0 = 1	#R33/M183.KorektoMath,R32 (a/a)→1
# Prove ⌉𝑥⌉-𝑥 = 1
⌉𝑥⌉-𝑥 = ⌉𝑥⌉-𝑥	#T34/A178.KorektoMath Reflection
⌉𝑥⌉-𝑥 = ⌉𝑥*⌉-𝑥	#R35/M175.KorektoMath,T34 Explicit*
⌉𝑥⌉-𝑥 = (⌉𝑥)*(⌉-𝑥)	#R36/M106.KorektoMath,R35 a~b → (a)~(b)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(⌉-𝑥)	#C37/I245.KorektoMath,T21,R36 G=F,(G)→(F)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(⌉(-𝑥))	#R38/M104.KorektoMath,C37 a → (a)
⌉(-𝑥) = 𝖊∧(-𝑥)	#T39/A97.KorektoMath Exp
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(𝖊∧(-𝑥))	#C40/I245.KorektoMath,T39,R38 G=F,(G)→(F)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(𝖊∧-𝑥)	#R41/M105.KorektoMath,C40 (a) → a
⌉𝑥⌉-𝑥 = ⌉0	#C42/I181.KorektoMath,R41,R28 a=b;c=b;a=c
⌉𝑥⌉-𝑥 = 1	#C43/I179.KorektoMath,C42,R33 a=b;b=c;a=c
# Abstract
⌉𝓍⌉-𝓍 = 1	#A44/C43 ⌉𝑥⌉-𝑥=1
⌉-𝓍⌉𝓍 = 1	#A45 ⌉-𝑥⌉𝑥=1
```
### Natural logarithm function
```korekto
# In Ruby, the natural log funtion is:
#     y = Math.exp(x)
#     Math.log(y) == x #=> true
# Here its:
⌊𝑥 = 𝖊𝓵𝑥	#T46/A98.KorektoMath Log
# So we can contract the inverse relation
𝖊𝓵(𝖊∧(𝑥)) = 𝑥	#R18/M104.KorektoMath,C17 a → (a)
⌊(𝖊∧(𝑥)) = 𝖊𝓵(𝖊∧(𝑥))	#T47/A98.KorektoMath Log
⌊(𝖊∧(𝑥)) = 𝑥	#C48/I179.KorektoMath,T47,R18 a=b;b=c;a=c
⌉(𝑥) = 𝖊∧(𝑥)	#T49/A97.KorektoMath Exp
⌊(⌉(𝑥)) = 𝑥	#C50/I246.KorektoMath,T49,C48 G=F,(F)→(G)
⌊(⌉𝑥) = 𝑥	#R51/M105.KorektoMath,C50 (a) → a
⌊⌉𝑥 = 𝑥	#R52/M105.KorektoMath,R51 (a) → a
⌊⌉𝓍 = 𝓍	#A53/R52 ⌊⌉=1
# Likewise
⌉⌊𝓍 = 𝓍	#A54 ⌉⌊=1
# If 𝖊∧0 = 1, then 𝖊𝓵1 = 0 by definition of 𝓵
⌊1 = 𝖊𝓵1	#T55/A98.KorektoMath Log
𝖊∧0 = 1	#T56/A38.KorektoMath x∧0=1
𝖊𝓵1 = 0	#R57/M43.KorektoMath,T56 ∧→𝓵
⌊1 = 0	#C58/I236.KorektoMath,R57,T55 g=f,_g$→_f$
```
### Squash
```korekto
# The squash function in Ruby is:
#     1 / (1 + Math.exp(-𝑥))
# Here its:
⌈𝑥 = 1 / 1+⌉-𝑥	#T59/A272.KorektoMath Squash
⌈𝑥 = 1 / (1 + ⌉-𝑥)	#R60/M113.KorektoMath,T59 _a+b$ → ♭(a♭+♭b)$
# Alternate
⌈𝑥 = ⌉𝑥*1 / ⌉𝑥*(1 + ⌉-𝑥)	#R61/M203.KorektoMath,R60 _x*a_/_x*b$
⌈𝑥 = ⌉𝑥 / ⌉𝑥*(1 + ⌉-𝑥)	#R62/M185.KorektoMath,R61 *1_
⌈𝑥 = ⌉𝑥 / (⌉𝑥*1 + ⌉𝑥*⌉-𝑥)	#R63/M223.KorektoMath,R62 (x*a♭±♭x*b)
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + ⌉𝑥*⌉-𝑥)	#R64/M185.KorektoMath,R63 *1_
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + ⌉𝑥⌉-𝑥)	#R65/M176.KorektoMath,R64 Implied*
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + 1)	#C66/I231.KorektoMath,C43,R65 g=a,_g)→_a)
⌈𝑥 = ⌉𝑥 / (1 + ⌉𝑥)	#R67/M259.KorektoMath,C66 (a+b)→(b+a)
⌈𝑥 = ⌉𝑥 / 1+⌉𝑥	#R68/M112.KorektoMath,R67 ♭(a♭+♭b)$ → _a+b$
⌈𝓍 = ⌉𝓍 / 1+⌉𝓍	#A69/R68 Alternate Squash
# Equivalence 1-⌈𝑥 = ⌈-𝑥
1-⌈𝑥 = 1-⌈𝑥	#T70/A178.KorektoMath Reflection
1-⌈𝑥 = 1 - ⌈𝑥	#R71/M168.KorektoMath,T70 +_g+f$ → +_g_+_f$
1-⌈𝑥 = 1 - (⌉𝑥 / 1+⌉𝑥)	#C72/I240.KorektoMath,R68,R71 a=G,a→(G)
1-⌈𝑥 = (1+⌉𝑥-⌉𝑥 / 1+⌉𝑥)	#R73/M210.KorektoMath,C72 _1±(a_/_g) → (g±a / g)
1-⌈𝑥 = 1+⌉𝑥-⌉𝑥 / 1+⌉𝑥	#R74/M160.KorektoMath,R73 +_(G)$ → +_G$
1-⌈𝑥 = 1 / 1+⌉𝑥	#R75/M198.KorektoMath,R74 +a-a_
# Consider ⌈0
⌈0 = ⌈0	#T76/A178.KorektoMath Reflection
⌈0 = ⌉0 / 1+⌉0	#T77/A69 Alternate Squash
⌉0 = 𝖊∧0	#T22/A97.KorektoMath Exp
𝖊∧0 = 1	#T56/A38.KorektoMath x∧0=1
⌉0 = 1	#C78/I236.KorektoMath,T56,T22 g=f,_g$→_f$
⌈0 = 1 / 1+1	#C79/I228.KorektoMath,C78,T77 a=b,2*a→b
1 + 1 : 2	#S48.KorektoMath/L1.KorektoMath ≝: 2
1 + 1 = 2	#R80/M2.KorektoMath,S48.KorektoMath ≝→=
2 = 1 + 1	#R81/M177.KorektoMath,R80 Symmetry
2 = (1 + 1)	#R82/M161.KorektoMath,R81 +_G$ → +_(G)$
2 = (1+1)	#R83/M110.KorektoMath,R82 (a_+_b) → (a+b)
2 = 1+1	#R84/M112.KorektoMath,R83 ♭(a♭+♭b)$ → _a+b$
⌈0 = 1 / 2	#C85/I237.KorektoMath,R84,C79 g=f,_f$→_g$
⌈0 = 1/2	#R86/M119.KorektoMath,C85 _a_*_b$ → _a*b$
½ : 1/2	#S214.KorektoMath/L1.KorektoMath ≝: ½
⌈0 = ½	#C87/I182.KorektoMath,S214.KorektoMath,R86 a=b;c=b;c=a
# Consider ⌈1
⌈1 = ⌈1	#T88/A178.KorektoMath Reflection
⌈1 = ⌉1 / 1+⌉1	#T89/A69 Alternate Squash
⌉1 = 𝖊∧1	#T90/A97.KorektoMath Exp
𝖊∧1 = 𝖊	#T91/A37.KorektoMath x∧1=x
⌉1 = 𝖊	#C92/I236.KorektoMath,T91,T90 g=f,_g$→_f$
⌈1 = 𝖊 / 1+𝖊	#C93/I228.KorektoMath,C92,T89 a=b,2*a→b
# Consider ⌈-𝑥
⌈-𝑥 = ⌈-𝑥	#T94/A178.KorektoMath Reflection
⌈-𝑥 = 1 / 1+⌉--𝑥	#T95/A272.KorektoMath Squash
⌈-𝑥 = 1 / 1+⌉𝑥	#R96/M261.KorektoMath,T95 --a→a
# Then:
1-⌈𝑥 = ⌈-𝑥	#C97/I182.KorektoMath,R96,R75 a=b;c=b;c=a
1-⌈𝓍 = ⌈-𝓍	#A98/C97 1-⌈𝑥=⌈-𝑥
⌈-𝑥 = 1-⌈𝑥	#R99/M177.KorektoMath,C97 Symmetry
⌈-𝓍 = 1-⌈𝓍	#A100/R99 ⌈-𝑥=1-⌈𝑥
# Corrolary: ⌈𝑥+⌈-𝑥 = 1
⌈𝑥+⌈-𝑥 = ⌈𝑥+⌈-𝑥	#T101/A178.KorektoMath Reflection
⌈𝑥+⌈-𝑥 = ⌈𝑥 + ⌈-𝑥	#R102/M168.KorektoMath,T101 +_g+f$ → +_g_+_f$
⌈𝑥+⌈-𝑥 = ⌈𝑥 + 1-⌈𝑥	#C103/I236.KorektoMath,R99,R102 g=f,_g$→_f$
⌈𝑥+⌈-𝑥 = ⌈𝑥 + 1 - ⌈𝑥	#R104/M168.KorektoMath,C103 +_g+f$ → +_g_+_f$
⌈𝑥+⌈-𝑥 = (⌈𝑥 + 1) - ⌈𝑥	#R105/M157.KorektoMath,R104 +_G_+ → +_(G)_+
⌈𝑥+⌈-𝑥 = (1 + ⌈𝑥) - ⌈𝑥	#R106/M259.KorektoMath,R105 (a+b)→(b+a)
⌈𝑥+⌈-𝑥 = 1 + ⌈𝑥 - ⌈𝑥	#R107/M156.KorektoMath,R106 +_(G)_+ → +_G_+
⌈𝑥+⌈-𝑥 = 1	#R108/M195.KorektoMath,R107 +a-a$ → $
# Derivative:
# Label 𝑥
ₓ → 𝑥	#S109/L20.KorektoMath Replace: ₓ
# ₓ → 𝑥;𝓓ₓ𝓐(𝑥) = ...
𝓓ₓ⌈𝑥 = 𝓓ₓ⌈𝑥	#T110/A178.KorektoMath Reflection
𝓓ₓ⌈𝑥 = 𝓓ₓ(⌈𝑥)	#R111/M104.KorektoMath,T110 a → (a)
𝓓ₓ⌈𝑥 = 𝓓ₓ(1 / 1+⌉-𝑥)	#C112/I245.KorektoMath,T59,R111 G=F,(G)→(F)
𝓓ₓ(1 / 1+⌉-𝑥) = -𝓓ₓ⌉-𝑥 / (1+⌉-𝑥)²	#T113/A280.KorektoMath From quotient rule
𝓓ₓ⌈𝑥 = -𝓓ₓ⌉-𝑥 / (1+⌉-𝑥)²	#C114/I249.KorektoMath,T113,C112 G=F, +_G$ → +_F$
# Consider 𝓓ₓ⌉-𝑥
𝓓ₓ⌉-𝑥 = 𝓓ₓ⌉-𝑥	#T115/A178.KorektoMath Reflection
𝓓ₓ⌉-𝑥 = 𝓓ₓ(⌉-𝑥)	#R116/M104.KorektoMath,T115 a → (a)
⌉-𝑥 = 𝖊∧-𝑥	#T117/A97.KorektoMath Exp
𝓓ₓ⌉-𝑥 = 𝓓ₓ(𝖊∧-𝑥)	#C118/I245.KorektoMath,T117,R116 G=F,(G)→(F)
𝓓ₓ(𝖊∧-𝑥) = 𝓓ₓ(-𝑥)𝖊∧-𝑥	#T119/A282.KorektoMath D(e^x)=D(x)e^x
𝓓ₓ⌉-𝑥 = 𝓓ₓ(-𝑥)𝖊∧-𝑥	#C120/I236.KorektoMath,T119,C118 g=f,_g$→_f$
𝓓ₓ⌉-𝑥 = 𝓓ₓ(-𝑥)*𝖊∧-𝑥	#R121/M175.KorektoMath,C120 Explicit*
𝓓ₓ(-𝑥) = -1	#R122/M285.KorektoMath,S109 𝓓ₓ-𝑥=-1
𝓓ₓ⌉-𝑥 = -1*𝖊∧-𝑥	#C123/I227.KorektoMath,R122,R121 a=b,a→b
𝓓ₓ⌉-𝑥 = -1*(𝖊∧-𝑥)	#R124/M172.KorektoMath,C123 a^b → (a^b)
-𝓓ₓ⌉-𝑥 = (𝖊∧-𝑥)	#R125/M270.KorektoMath,R124 a=-1*b→-a=b
# Substituting
𝓓ₓ⌈𝑥 = (𝖊∧-𝑥) / (1+⌉-𝑥)²	#C126/I227.KorektoMath,R125,C114 a=b,a→b
𝓓ₓ⌈𝑥 = 𝖊∧-𝑥 / (1+⌉-𝑥)²	#R127/M148.KorektoMath,C126 ♭(g)♭ → _g_
𝓓ₓ⌈𝑥 = ⌉-𝑥 / (1+⌉-𝑥)²	#C128/I235.KorektoMath,T117,R127 g=f,_f_→_g_
𝓓ₓ⌈𝑥 = ⌉-𝑥/(1+⌉-𝑥)²	#R129/M119.KorektoMath,C128 _a_*_b$ → _a*b$
𝓓ₓ⌈𝑥 = ⌉-𝑥/(1+⌉-𝑥) 1/(1+⌉-𝑥)	#R130/M211.KorektoMath,R129 _a/b²$→_a/b_1/b$
⌈𝑥 = 1 / (1 + ⌉-𝑥)	#R60/M113.KorektoMath,T59 _a+b$ → ♭(a♭+♭b)$
⌈𝑥 = 1 / (1+⌉-𝑥)	#R131/M110.KorektoMath,R60 (a_+_b) → (a+b)
⌈𝑥 = 1/(1+⌉-𝑥)	#R132/M119.KorektoMath,R131 _a_*_b$ → _a*b$
𝓓ₓ⌈𝑥 = ⌉-𝑥/(1+⌉-𝑥) ⌈𝑥	#C133/I237.KorektoMath,R132,R130 g=f,_f$→_g$
⌈-𝑥 = ⌉-𝑥 / 1+⌉-𝑥	#T134/A69 Alternate Squash
⌈-𝑥 = ⌉-𝑥 / (1+⌉-𝑥)	#R135/M113.KorektoMath,T134 _a+b$ → ♭(a♭+♭b)$
⌈-𝑥 = ⌉-𝑥/(1+⌉-𝑥)	#R136/M119.KorektoMath,R135 _a_*_b$ → _a*b$
𝓓ₓ⌈𝑥 = ⌈-𝑥 ⌈𝑥	#C137/I235.KorektoMath,R136,C133 g=f,_f_→_g_
𝓓ₓ⌈𝑥 = 1-⌈𝑥 ⌈𝑥	#C138/I234.KorektoMath,R99,C137 g=f,_g_→_f_
𝓓ₓ⌈𝑥 = (1-⌈𝑥) ⌈𝑥	#R139/M116.KorektoMath,C138 _a+b_ → ♭(a♭+♭b)♭
𝓓ₓ⌈𝑥 = (1-⌈𝑥)*⌈𝑥	#R140/M175.KorektoMath,R139 Explicit*
𝓑⌈𝑥 = (1-⌈𝑥)*⌈𝑥	#T141/A274.KorektoMath Binary balance
𝓓ₓ⌈𝑥 = 𝓑⌈𝑥	#C142/I182.KorektoMath,T141,R140 a=b;c=b;c=a
```
### Unsquash
```korekto
# The unsquash function in Ruby is:
#   Math.log(𝑥 / (1 - 𝑥))
# Here  its:
⌋𝑥 = ⌊ 𝑥/(1-𝑥)	#T143/A273.KorektoMath Unsquash
# Show that unsquash is the inverse of squash(⌋⌈=1):
⌋⌈𝑥 = ⌋⌈𝑥	#T144/A178.KorektoMath Reflection
⌋⌈𝑥 = ⌊ ⌈𝑥/(1-⌈𝑥)	#T145/A273.KorektoMath Unsquash
⌊ ⌈𝑥/(1-⌈𝑥) = ⌊⌈𝑥 - ⌊(1-⌈𝑥)	#T146/A271.KorektoMath ⌊(a/b)=⌊a-⌊b
⌋⌈𝑥 = ⌊⌈𝑥 - ⌊(1-⌈𝑥)	#C147/I249.KorektoMath,T146,T145 G=F, +_G$ → +_F$
⌋⌈𝑥 = ⌊(⌈𝑥) - ⌊(1-⌈𝑥)	#R148/M104.KorektoMath,C147 a → (a)
⌈𝑥 = ⌉𝑥 / 1+⌉𝑥	#R68/M112.KorektoMath,R67 ♭(a♭+♭b)$ → _a+b$
⌋⌈𝑥 = ⌊(⌉𝑥 / 1+⌉𝑥) - ⌊(1-⌈𝑥)	#C149/I245.KorektoMath,R68,R148 G=F,(G)→(F)
⌋⌈𝑥 = ⌊ ⌉𝑥/(1+⌉𝑥) - ⌊(1-⌈𝑥)	#R150/M136.KorektoMath,C149 ♭(a_*_g)♭ → _a*(g)_
⌊ ⌉𝑥/(1+⌉𝑥) = ⌊⌉𝑥 - ⌊(1+⌉𝑥)	#T151/A271.KorektoMath ⌊(a/b)=⌊a-⌊b
⌊⌉𝑥 = 𝑥	#R52/M105.KorektoMath,R51 (a) → a
⌊ ⌉𝑥/(1+⌉𝑥) = 𝑥 - ⌊(1+⌉𝑥)	#C152/I227.KorektoMath,R52,T151 a=b,a→b
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊(1-⌈𝑥)	#C153/I251.KorektoMath,C152,R150 G=F, +_G_+ → +_F_+
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1-⌈𝑥	#R154/M112.KorektoMath,C153 ♭(a♭+♭b)$ → _a+b$
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1-(⌈𝑥)	#R155/M104.KorektoMath,R154 a → (a)
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1-(⌉𝑥 / 1+⌉𝑥)	#C156/I245.KorektoMath,R68,R155 G=F,(G)→(F)
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ (1+⌉𝑥-⌉𝑥 / 1+⌉𝑥)	#R157/M210.KorektoMath,C156 _1±(a_/_g) → (g±a / g)
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ (1 / 1+⌉𝑥)	#R158/M198.KorektoMath,R157 +a-a_
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1/(1+⌉𝑥)	#R159/M138.KorektoMath,R158 ♭(a_*_g)$ → _a*(g)$
⌊ 1/(1+⌉𝑥) = ⌊1 - ⌊(1+⌉𝑥)	#T160/A271.KorektoMath ⌊(a/b)=⌊a-⌊b
# TODO: Wrong!
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊1 - ⌊(1+⌉𝑥)	#C161/I249.KorektoMath,T160,R159 G=F, +_G$ → +_F$
⌊1 = 0	#C58/I236.KorektoMath,R57,T55 a=b,_a$→_b$
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - 0 - ⌊(1+⌉𝑥)	#C162/I227.KorektoMath,C58,C161 a=b,a→b
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) + ⌊(1+⌉𝑥)	#R163/M202.KorektoMath,C162 ±0± → +
⌋⌈𝑥 = 𝑥	#R164/M196.KorektoMath,R163 -a+a$ → $
⌋⌈𝓍 = 𝓍	#A165/R164 Inverse
# Likewise:
⌈⌋𝓍 = 𝓍	#A166 Inverse
```
### Activation and value of a neuron
```korekto
# The activation of the r-th Neuron(in level r connecting to level s): ᵢ ⱼ ˢ ʲ 
ᵢ₊ = ⱼ;𝒂ᵢ = ⌈ 𝒃ᵢ+∑ⱼ(𝑪ᵢⱼ𝒂ⱼ)	#M167 Activation
ᵣ₊ = ₛ	#R7/M6.KorektoMath,S5 Next
𝒂ᵣ = ⌈ 𝒃ᵣ+∑ₛ(𝑾ᵣₛ𝒂ₛ)	#R168/M167,R7 Activation
ₛ → ˢ	#C11/I11.KorektoMath,S5,S6 2nd
∑ₛ(𝑾ᵣₛ𝒂ₛ) = 𝑾ᵣˢ𝒂ₛ	#R169/M287.KorektoMath,C11 Einstein notation
𝒂ᵣ = ⌈ 𝒃ᵣ+(𝑾ᵣˢ𝒂ₛ)	#C170/I241.KorektoMath,R169,R168 a=G,a→(G)
𝒂ᵣ = ⌈ 𝒃ᵣ+𝑾ᵣˢ𝒂ₛ	#R171/M144.KorektoMath,C170 *(ab)$ → *ab$
# The above is correct. Now, how to cleanly loose the labels?
𝒂 = ⌈ 𝒃+𝑾𝒂₊	#H172 Hide labels
# The value of the h-th Neuron is the unsquashed activation:
⌋𝒂 = ⌋⌈ 𝒃+𝑾𝒂₊	#R173/M266.KorektoMath,H172 x_=_G_g;Fx_=_FG_g
⌋⌈(𝒃+𝑾𝒂₊) = (𝒃+𝑾𝒂₊)	#T174/A165 Inverse
⌋⌈(𝒃+𝑾𝒂₊) = 𝒃+𝑾𝒂₊	#R175/M150.KorektoMath,T174 ♭(g)$ → _g$
⌋⌈ 𝒃+𝑾𝒂₊ = 𝒃+𝑾𝒂₊	#R176/M148.KorektoMath,R175 ♭(g)♭ → _g_
⌋𝒂 = 𝒃+𝑾𝒂₊	#C177/I250.KorektoMath,R176,R173 G=F, +_G$ → +_F$
# Neuron's value
𝒗 : ⌋𝒂	#S178/L1.KorektoMath ≝: 𝒗
𝒗 = 𝒃+𝑾𝒂₊	#C179/I179.KorektoMath,S178,C177 a=b;b=c;a=c
# Explicit 𝒗
𝒗ᵣ = 𝒃ᵣ+𝑾ᵣˢ𝒂ₛ	#H180 Reveal labels
```
### Mirroring
```korekto
# The bias and weight of a neuron that roughly mirrors the value of another:
𝕧 : {-1 0 1}	#S181/L1.KorektoMath ≝: 𝕧
𝖇+𝖜*⌈𝕧 : 𝕧	#S182/L1.KorektoMath ≝: 𝖇 𝖜
𝕧[0]	#R183/M4.KorektoMath,S181 Membership
𝕧 = 𝖇+𝖜*⌈𝕧	#R184/M177.KorektoMath,S182 Symmetry
0 = 𝖇+𝖜*⌈0	#H185 Case 0∊𝕧
⌈0 = ½	#C87/I182.KorektoMath,S215.KorektoMath,R86 a=b;c=b;c=a
0 = 𝖇+𝖜*½	#C186/I228.KorektoMath,C87,H185 a=b,a→b
0 = 𝖇+½𝖜	#R187/M216.KorektoMath,C186 a*½→½a
-𝖇 = ½𝖜	#R188/M264.KorektoMath,R187 0=b+g→-b=g
𝖇 = -½𝖜	#R189/M268.KorektoMath,R188 -a=bc→a=-bc
-½𝖜 = 𝖇	#R190/M177.KorektoMath,R189 Symmetry
𝖜 = -2𝖇	#R191/M217.KorektoMath,R189 a=½b→b=2a
𝕧[1]	#R192/M4.KorektoMath,S181 Membership
𝕧 = 𝖇+𝖜*⌈𝕧	#R184/M177.KorektoMath,S182 ≝→=
1 = 𝖇+𝖜*⌈1	#H193 Case 1∊𝕧
1 = 𝖇 + 𝖜*⌈1	#R194/M168.KorektoMath,H193 +_g+f$ → +_g_+_f$
1 = -½𝖜 + 𝖜*⌈1	#C195/I236.KorektoMath,R190,R194 g=f,_f_→_g_
1 = -½𝖜 + 𝖜⌈1	#R196/M176.KorektoMath,C195 Implied*
1 = 𝖜⌈1 + -½𝖜	#R197/M261.KorektoMath,R196 _g_+_f$→_f_+_g$
1 = 𝖜⌈1 - ½𝖜	#R198/M257.KorektoMath,R197 _g_+_-f$→_g_-_f$
1 = 𝖜(⌈1 - ½)	#R199/M226.KorektoMath,R198 _ab_+Na$→_a(b+N)$
𝖜 = 1/(⌈1 - ½)	#R200/M269.KorektoMath,R199 1=ab→a=1/b
𝖜 = 1 / ⌈1-½	#R201/M124.KorektoMath,R200 _a/(b♭+♭c)$→_a_/_b+c$
𝖜 = -2 / 1-2⌈1	#R202/M219.KorektoMath,R201 _1_/_a-½$→_-2_/_1-2a
𝖇 = -½𝖜	#R189/M268.KorektoMath,R188 -a=bc→a=-bc
𝖇 = -½(-2 / 1-2⌈1)	#C203/I241.KorektoMath,R202,R189 a=G,a→(G)
𝖇 = (1 / 1-2⌈1)	#R204/M220.KorektoMath,C203 _½(2 / g)→_(1 / g)
𝖇 = 1 / 1-2⌈1	#R205/M160.KorektoMath,R204 +_(G)$ → +_G$
𝕧[-1]	#R206/M4.KorektoMath,S181 Membership
𝕧 = 𝖇+𝖜*⌈𝕧	#R184/M177.KorektoMath,S182 ≝→=
-1 = 𝖇+𝖜*⌈-1	#H207 Case -1∊𝕧
⌈-1 = 1-⌈1	#T208/A100 ⌈-𝑥=1-⌈𝑥
-1 = 𝖇+𝖜*(1-⌈1)	#C209/I241.KorektoMath,T208,H207 a=G,a→(G)
-1 = 𝖇 + 𝖜*(1-⌈1)	#R210/M168.KorektoMath,C209 +_g+f$ → +_g_+_f$
-1 = -½𝖜 + 𝖜*(1-⌈1)	#C211/I235.KorektoMath,R189,R210 g=f,_g_→_f_
-1 = -½𝖜 + 𝖜(1-⌈1)	#R212/M176.KorektoMath,C211 Implied*
-1 = 𝖜(-½ + (1-⌈1))	#R213/M227.KorektoMath,R212 _Na+ab$→_a(N+b)$
-1 = 𝖜(-½ + (1 - ⌈1))	#R214/M111.KorektoMath,R213 (a+b) → (a_+_b)
-1 = 𝖜(-½ + 1 - ⌈1)	#R215/M165.KorektoMath,R214 +_(G))~ → +_G)~
-1 = 𝖜(½ - ⌈1)	#R216/M221.KorektoMath,R215 (-½+1+g)→(½+g)
𝖜 = 1/(⌈1-½)	#R217/M270.KorektoMath,R216 -1=a(b-c)→a=1/(c-b)
𝖜 = 1 / ⌈1-½	#R201/M124.KorektoMath,R200 _a/(b♭+♭c)$→_a_/_b+c$
𝖜 = 2 / 2⌈1-1	#R218/M222.KorektoMath,R201 _1_/_a+½$→_2_/_2a_1
𝖇 = -½(2 / 2⌈1-1)	#C219/I241.KorektoMath,R218,R189 a=G,a→(G)
𝖇 = -1 / 2⌈1-1	#R220/M223.KorektoMath,C219 _½(2_/_g)$→_1_/_g
# TODO: Need mechanism to show that this is a confirmantion(and not a restatement).
𝖇 = 1 / 1-2⌈1	#R205/M160.KorektoMath,R204 +_(G)$ → +_G$
# Verify this works when value is negative one:
-1 = 𝖇 + 𝖜*⌈-1	#R221/M168.KorektoMath,H207 +_g+f$ → +_g_+_f$
-1 = -½𝖜 + 𝖜*⌈-1	#C222/I244.KorektoMath,T208,C211 a=G,(G)→a
-1 = 𝖜(-½ + ⌈-1)	#C223/I244.KorektoMath,T208,R213 a=G,(G)→a
-1 = 𝖜(-½ + (1-⌈1))	#R213/M227.KorektoMath,R212 _Na+ab$→_a(N+b)$
-1 = 𝖜(-½ + (1 - ⌈1))	#R214/M111.KorektoMath,R213 (a+b) → (a_+_b)
-1 = 𝖜(-½ + 1 - ⌈1)	#R215/M165.KorektoMath,R214 +_(G))~ → +_G)~
-1 = 𝖜(½ - ⌈1)	#R216/M221.KorektoMath,R215 (-½+1+g)→(½+g)
𝖜 = 1/(⌈1-½)	#R217/M270.KorektoMath,R216 -1=a(b-c)→a=1/(c-b)
# TODO: Again, restatement here should be confimation
𝖜 = 1 / ⌈1-½	#R201/M124.KorektoMath,R200 _a/(b♭+♭c)$→_a_/_b+c$
! stop!
```
### Propagation of errors level 1(Perceptron)
```korekto
# Value is the unsquashed activation:
𝒗ᵣ := ⌋(𝒂ᵣ)
𝒗 = ⌋𝒂
# Error in output value from errors in bias and weights:
𝒗ᵣ + 𝒆ᵣ := (𝒃ᵣ + 𝜺ᵣ) + ∑ₛ((𝑾ᵣₛ + 𝜺ₛ) * 𝒂ₛ)
𝒗+𝒆 = 𝒃+𝜺 + (𝑾+𝜺')𝒂'
𝒆 = 𝒃+𝜺 + (𝑾+𝜺')𝒂'- 𝒗
𝒆 = 𝒃 + 𝜺 + 𝑾𝒂' + 𝜺'𝒂' - 𝒗
𝒆 = 𝜺 + 𝜺'𝒂' + (𝒃 + 𝑾𝒂') - 𝒗
𝒆 = 𝜺 + 𝜺'𝒂' + (𝒗) - 𝒗
𝒆 = 𝜺 + 𝜺'𝒂'
𝒆ᵣ = 𝜺ᵣ + 𝜺ˢ𝒂ₛ
𝒆ᵣ = 𝜺ᵣ + ∑ₛ(𝜺ₛ * 𝒂ₛ)
# Assume equipartition of errors:
∀ₓ{ 𝜺ₓ = 𝜀 }
𝒆ᵣ = 𝜺ᵣ + ∑ₛ(𝜺ₛ * 𝒂ₛ)
   = 𝜀 + ∑ₛ(𝜀 * 𝒂ₛ)
   = 𝜀 + 𝜀∑𝒂ₛ
   = 𝜀(1 + ∑𝒂ₛ)
𝒆ᵣ = 𝜀 * (1 + ∑ₛ(𝒂ₛ))
# *** Equipartitioned error level one ***
# Solve for 𝜀:
𝜀 = 𝒆ᵣ / 1+∑𝒂ₛ
𝜀 = 𝒆ᵣ / (1 + ∑ₛ(𝒂ₛ))
# Mu
𝝁ᵣ := 1 + ∑ₛ(𝒂ₛ)
𝝁 = 1+∑𝒂'
𝜀 = 𝒆ᵣ / 𝝁ᵣ
𝜀 = 𝒆/𝝁
𝒆 = 𝜀𝝁
𝒆ᵣ = 𝜀 * 𝝁ᵣ
# As an estimate, set 𝒂~½ and the length of ∑ₛ at 𝑁:
𝜀 ~ 𝒆 / (1 + ½𝑁)
# Or very roughly:
𝜀 ~ 2𝒆/𝑁
# Activation error
𝒂ᵣ + 𝜹ᵣ = ⌈(𝒗ᵣ + 𝒆ᵣ)
𝒂+𝜹 = ⌈ 𝒗+𝒆
    ~ ⌈𝒗 + 𝒆𝓓𝒗⌈𝒗
    ~ ⌈𝒗 + 𝒆𝓑⌈𝒗
    ~ ⌈𝒗 + 𝒆𝓑𝒂
𝒂ᵣ + 𝜹ᵣ ~ 𝒂ᵣ + (𝒆ᵣ * 𝓑(𝒂ᵣ))
        ~ 𝒂ᵣ + (𝒆ᵣ * (1 - 𝒂ᵣ) * 𝒂ᵣ)
𝜹ᵣ ~ 𝒆ᵣ * (1 - 𝒂ᵣ) * 𝒂ᵣ
   ~ 𝒆ᵣ * 𝓑(𝒂ᵣ)
𝜹 ~ 𝒆𝓑𝒂
  ~ 𝒆(1-𝒂)𝒂
# Recall that 𝒆=𝜀𝝁:
𝜹 ~ 𝜀𝝁(1-𝒂)𝒂
  ~ 𝜀𝝁𝓑𝒂
𝜹ᵣ ~ 𝜀 * 𝝁ᵣ * 𝓑(𝒂ᵣ)
   ~ 𝜀 * 𝝁ᵣ * (1 - 𝒂ᵣ) * 𝒂ᵣ
```
### Vanishing small errors
```korekto
# Assume 𝜀²~0
𝜀² ~ 0
# Consider 𝜀𝜹
𝜀 * 𝜹ᵣ = 𝜀 * 𝜀 * 𝝁ᵣ * 𝓑(𝒂ᵣ)
       = 𝜀²𝝁𝓑𝒂
       ~ 0 * 𝝁𝓑𝒂
𝜀𝜹 ~ 0
𝜀 * 𝜹ᵣ ~ 0
```
### Propagation of errors level 2
```korekto
# Error in ouput value from errors in bias and weights and activation:
𝒗ᵣ + 𝒆ᵣ := (𝒃ᵣ + 𝜺ᵣ) + ∑ₛ((𝑾ᵣₛ + 𝜺ₛ) * (𝒂ₛ + 𝜹ₛ))
𝒗+𝒆 = 𝒃+𝜺 + (𝑾+𝜺')(𝒂'+𝜹')
    = 𝒃 + 𝜀 + 𝑾𝒂' + 𝑾𝜹' + 𝜺'𝒂' + 𝜺'𝜹'
    ~ 𝒃 + 𝜀 + 𝑾𝒂' + 𝑾𝜹' + 𝜺'𝒂' # 𝜀𝜹 vanishes
    ~ 𝒃 + 𝑾𝒂' + 𝑾𝜹' + 𝜀 + 𝜺'𝒂'
    ~ 𝒗 + 𝑾𝜹' + 𝜀 + 𝜺'𝒂'
𝒆 ~ 𝑾𝜹' + 𝜀 + 𝜺'𝒂'
𝒆 ~ 𝑾𝜹' + 𝜀(1+∑𝒂')
𝒆 ~ 𝑾𝜹' + 𝜀𝝁
𝒆 ~ 𝜀𝝁 + 𝑾𝜹' # Same as level one with an extra +𝑾𝜹'
# Recall 𝜹 ~ 𝒆𝓑𝒂:
𝒂+𝜹 = ⌈ 𝒗+𝒆
    ~ 𝒂 + 𝒆𝓑𝒂
𝜹 ~ 𝒆𝓑𝒂
# Substitute out 𝜹':
𝒆 ~ 𝜀𝝁 + 𝑾𝜹'
  ~ 𝜀𝝁 + 𝑾 𝒆'𝓑𝒂'
  ~ 𝜀𝝁 + 𝑾 𝓑𝒂'𝒆'
# Substitute out 𝒆':
𝒆 ~ 𝜀𝝁 + 𝑾 𝓑𝒂'𝒆'
  ~ 𝜀𝝁 + 𝑾 𝓑𝒂'(𝜀𝝁' + 𝑾'𝜹")
  ~ 𝜀𝝁 + 𝑾 𝓑𝒂'𝜀𝝁' + 𝑾 𝓑𝒂'𝑾'𝜹"
  ~ 𝜀𝝁 + 𝜀𝑾 𝓑𝒂'𝝁' + 𝑾 𝓑𝒂'𝑾'𝜹" # reorder
  ~ 𝜀(𝝁 + 𝑾 𝓑𝒂'𝝁') + 𝑾 𝓑𝒂'𝑾'𝜹"
# Introduce 𝜧 :
𝜧ᵣˢ𝝁ₛ := ∑ₛ 𝑾ᵣₛ𝓑𝒂ₛ𝝁ₛ
𝜧 𝝁' = 𝑾 𝓑𝒂'𝝁'
# Substitute in 𝜧 :
𝒆 ~ 𝜀(𝝁 + 𝑾 𝓑𝒂'𝝁') + 𝑾 𝓑𝒂'𝑾'𝜹"
  ~ 𝜀(𝝁 + 𝜧 𝝁') + 𝜧 𝑾'𝜹"
# *** Equipartitioned error level two ***
# For level two, 𝜹"=0
𝒆 ~ 𝜀(𝝁 + 𝜧 𝝁')
𝒆ᵣ ~ 𝜀 * (𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ)
# Solve for 𝜀:
𝜀 ~ 𝒆 / (𝝁 + 𝜧 𝝁')
𝜀ᵣ ~ 𝒆ᵣ / (𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ)
# Notice that:
0 < 𝒂 < 1
0 < 𝓑𝒂=(1-𝒂)𝒂 < 0.25 = ¼
# So there's an upper bound for 𝒆:
𝒆 ~ 𝜀(𝝁 + 𝜧 𝝁')
  ~ 𝜀(𝝁 + 𝑾 𝓑𝒂'𝝁')
|𝒆| < |𝜀(𝝁 + ¼𝑾 𝝁')|
# Assume 𝒂 is somewhat random about 0.5=½ in a level of size large 𝑁:
𝝁 = 1+∑𝒂'  ⇒  𝔪 ~ 1+½𝑁 ~ ½𝑁
|𝒆| <~ |𝜀(𝔪 + ¼𝔪 ∑𝑾)|
# Consider the case when weights are random plus or minus one.
# Let this be like a random walk of 𝑁 steps.
# Then ∑𝑾 ~ √𝑁:
|𝒆| <~ |𝜀(𝔪 + ¼𝔪 √𝑁)|
    <~ |𝜀(½𝑁 + ¼*½𝑁*√𝑁)|
    <~ 𝑁|𝜀(½ + ¼*½√𝑁)|
|𝒆| <~ 𝑁√(𝑁)|𝜀|/8
# If you don't believe the random walk and are pessimistic, you might prefer
# using 𝑁²:
𝒆 <~ 𝜀𝑁√𝑁/8 < 𝜀𝑁²/8
𝜀 ~> 8𝒆 / 𝑁√𝑁 > 8𝒆/𝑁²
```
### Explicit propagation of errors level 2
```korekto
𝒗ᵣ := 𝒃ᵣ + ∑ₛ(𝑾ᵣₛ * 𝒂ₛ)
𝒗ᵣ + 𝒆ᵣ := (𝒃ᵣ + 𝜺ᵣ) + ∑ₛ((𝑾ᵣₛ + 𝜺ₛ) * (𝒂ₛ + 𝜹ₛ))
𝒗ₛ + 𝒆ₛ := (𝒃ₛ + 𝜺ₛ) + ∑ₜ((𝑾ₛₜ + 𝜺ₜ) * (𝒂ₜ + 𝜹ₜ))
𝒂ₛ + 𝜹ₛ := ⌈(𝒗ₛ + 𝒆ₛ)
        = ⌈((𝒃ₛ + 𝜺ₛ) + ∑ₜ((𝑾ₛₜ + 𝜺ₜ) * (𝒂ₜ + 𝜹ₜ)))
        = ⌈(𝒃ₛ + 𝜺ₛ + ∑ₜ(𝑾ₛₜ*𝒂ₜ + 𝜺ₜ*𝒂ₜ + 𝑾ₛₜ*𝜹ₜ + 𝜺ₜ*𝜹ₜ))
        = ⌈(𝒃ₛ + 𝜺ₛ + 𝑾ₛʲ𝒂ₜ + 𝜺ʲ𝒂ₜ + 𝑾ₛʲ𝜹ₜ + 𝜺ʲ𝜹ₜ)
        = ⌈(𝒃ₛ + 𝜺ₛ + 𝑾ₛʲ𝒂ₜ + 𝜺ʲ𝒂ₜ + 𝑾ₛʲ𝜹ₜ) # 𝜺𝜹  vanishes
        = ⌈(𝒃ₛ + 𝑾ₛʲ𝒂ₜ + 𝜺ₛ + 𝜺ʲ𝒂ₜ + 𝑾ₛʲ𝜹ₜ)
        = ⌈(𝒃ₛ + 𝑾ₛʲ𝒂ₜ + 𝜀 + 𝜀∑𝒂ₜ + 𝑾ₛʲ𝜹ₜ) # All 𝜺 are the same 𝜀
        = ⌈(𝒃ₛ + 𝑾ₛʲ𝒂ₜ + 𝜀(1 + ∑𝒂ₜ) + 𝑾ₛʲ𝜹ₜ)
        = ⌈(𝒃ₛ + 𝑾ₛʲ𝒂ₜ + 𝜀𝝁ₛ + 𝑾ₛʲ𝜹ₜ) # 𝝁ₛ=1+∑𝒂ₜ as 𝝁=1+∑𝒂'
        ~ 𝒂ₛ + (𝜀𝝁ₛ + 𝑾ₛʲ𝜹ₜ) 𝓑𝒂ₛ
        ~ 𝒂ₛ + (𝜀𝝁ₛ + 𝑾ₛʲ𝜹ₜ)(1-𝒂ₛ)𝒂ₛ
𝒂ₛ + 𝜹ₛ ~ 𝒂ₛ + (𝜀𝝁ₛ + ∑ₜ(𝑾ₛₜ * 𝜹ₜ)) * (1 - 𝒂ₛ) * 𝒂ₛ
# Solve for 𝜹ₛ:
𝜹ₛ ~ (𝜀𝝁ₛ + ∑ₜ(𝑾ₛₜ * 𝜹ₜ)) * (1 - 𝒂ₛ) * 𝒂ₛ
𝜹ₛ ~ (𝜀𝝁ₛ+𝑾ₛʲ𝜹ₜ)(1-𝒂ₛ)𝒂ₛ
𝜹ₛ ~ 𝜀𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝑾ₛʲ𝜹ₜ(1-𝒂ₛ)𝒂ₛ
# Consider the case where the j-th level is error free input:
𝜹ₛ ~ 𝜀𝝁ₛ(1-𝒂ₛ)𝒂ₛ # 𝜹ₜ is zero
𝒗ᵣ + 𝒆ᵣ := (𝒃ᵣ + 𝜺ᵣ) + ∑ₛ((𝑾ᵣₛ + 𝜺ₛ) * (𝒂ₛ + 𝜹ₛ))
        ~ (𝒃ᵣ + 𝜺ᵣ) + ∑ₛ((𝑾ᵣₛ + 𝜺ₛ) * (𝒂ₛ + 𝜀𝝁ₛ(1-𝒂ₛ)𝒂ₛ))
        ~ 𝒃ᵣ + 𝜺ᵣ + 𝑾ᵣˢ(𝒂ₛ + 𝜀𝝁ₛ(1-𝒂ₛ)𝒂ₛ) + 𝜺ˢ(𝒂ₛ + 𝜀𝝁ₛ(1-𝒂ₛ)𝒂ₛ)
        ~ 𝒃ᵣ + 𝜺ᵣ + 𝑾ᵣˢ𝒂ₛ + 𝜀𝑾ᵣˢ𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝜺ˢ𝒂ₛ + 𝜺ˢ𝜀𝝁ₛ(1-𝒂ₛ)𝒂ₛ
        ~ 𝒃ᵣ + 𝜺ᵣ + 𝑾ᵣˢ𝒂ₛ + 𝜀𝑾ᵣˢ𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝜺ˢ𝒂ₛ # 𝜺ˢ𝜀 vanishes
        ~ 𝒃ᵣ + 𝑾ᵣˢ𝒂ₛ + 𝜀𝑾ᵣˢ𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝜺ᵣ + 𝜺ˢ𝒂ₛ # reordered terms
        ~ 𝒗ᵣ + 𝜀𝑾ᵣˢ𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝜺ᵣ + 𝜺ˢ𝒂ₛ
        ~ 𝒗ᵣ + 𝜀𝑾ᵣˢ𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝜀(1+∑𝒂ₛ)
        ~ 𝒗ᵣ + 𝜀(1+∑𝒂ₛ) + 𝜀𝑾ᵣˢ𝝁ₛ(1-𝒂ₛ)𝒂ₛ # reordered
        ~ 𝒗ᵣ + 𝜀𝝁ᵣ + 𝜀𝜧ᵣˢ𝝁ₛ # 𝜧 = 𝑾𝓑𝒂'
𝒗ᵣ + 𝒆ᵣ ~ 𝒗ᵣ + 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ)
𝒆ᵣ ~ 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ)
𝜀 ~ 𝒆ᵣ / (𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ)
𝜀 ~ 𝒆 / (𝝁 + 𝜧 𝝁') # OK!
```
### Explicit propagation of errors level 3
```korekto
# Given:
𝒂ᵣ := ⌈(𝒗ᵣ)
𝒂ᵣ + 𝜹ᵣ := ⌈(𝒗ᵣ + 𝒆ᵣ)
𝒗ᵣ := 𝒃ᵣ + ∑ₛ(𝑾ᵣₛ * 𝒂ₛ)
𝒗ᵣ + 𝒆ᵣ := (𝒃ᵣ + 𝜺ᵣ) + ∑ₛ((𝑾ᵣₛ + 𝜺ₛ) * (𝒂ₛ + 𝜹ₛ))
𝝁ᵣ := 1 + ∑ₛ(𝒂ₛ)
𝜧ᵣˢ𝝁ₛ := ∑ₛ(𝑾ᵣₛ * (1 - 𝒂ₛ) * 𝒂ₛ * 𝝁ₛ)
       = 𝑾ᵣˢ𝓑𝒂ₛ𝝁ₛ
# Assume:
∀ₓ{ 𝜺ₓ = 𝜀 }
𝜀² ~ 0
𝜀𝜹 ~ 0
# Recall:
𝓓𝑥(⌈(𝑥)) = ⌈(𝑥) * (1 - ⌈(𝑥))
         = 𝓑(⌈(𝑥))
⌈(𝑥 + 𝜀) ~ ⌈(𝑥) + 𝜀 * 𝓓𝑥(⌈(𝑥))
         ~ ⌈(𝑥) + 𝜀 * ⌈(𝑥) * (1 - ⌈(𝑥))
         ~ ⌈(𝑥) + 𝜀 * 𝓑(⌈(𝑥))
# Note that one may transpose indices for each level:
ᵣ⬌ₛ⬌ₜ⬌ᵤ
# Solve for level 3 𝜀.
## 𝜹ₛ:
𝒂ₛ + 𝜹ₛ := ⌈(𝒗ₛ + 𝒆ₛ)
        ~ ⌈𝒗ₛ + 𝒆ₛ * 𝓑⌈𝒗ₛ
        ~ 𝒂ₛ + 𝒆ₛ * 𝓑⌈𝒗ₛ
𝜹ₛ ~ 𝒆ₛ * 𝓑⌈𝒗ₛ
   ~ 𝒆ₛ * 𝓑𝒂ₛ
𝜹ₛ ~ 𝒆ₛ * (1-𝒂ₛ) * 𝒂ₛ
## Expand first level and solve for 𝒆ᵣ:
𝒗ᵣ + 𝒆ᵣ := (𝒃ᵣ + 𝜺ᵣ) + ∑ₛ((𝑾ᵣₛ + 𝜺ₛ) * (𝒂ₛ + 𝜹ₛ))
        = 𝒃ᵣ+𝜀 + (𝑾ᵣˢ+𝜺ˢ)(𝒂ₛ+𝜹ₛ)
        = 𝒃ᵣ+𝜀 + 𝑾ᵣˢ𝒂ₛ + 𝜺ˢ𝒂ₛ + 𝑾ᵣˢ𝜹ₛ + 𝜺ˢ𝜹ₛ
        ~ 𝒃ᵣ+𝜀 + 𝑾ᵣˢ𝒂ₛ + 𝜺ˢ𝒂ₛ + 𝑾ᵣˢ𝜹ₛ # 𝜺𝜹 vanishes
        ~ 𝒃ᵣ+𝑾ᵣˢ𝒂ₛ + 𝜀+𝜺ˢ𝒂ₛ + 𝑾ᵣˢ𝜹ₛ
        ~ 𝒗ᵣ + 𝜀+𝜺ˢ𝒂ₛ + 𝑾ᵣˢ𝜹ₛ
𝒆ᵣ ~ 𝜀+𝜺ˢ𝒂ₛ + 𝑾ᵣˢ𝜹ₛ
   ~ 𝜀(1+∑𝒂ₛ) + 𝑾ᵣˢ𝜹ₛ
   ~ 𝜀𝝁ᵣ + 𝑾ᵣˢ𝜹ₛ
## Substitute out 𝜹ₛ:
𝒆ᵣ ~ 𝜀𝝁ᵣ + 𝑾ᵣˢ𝜹ₛ # 𝒆=𝜀𝝁+𝑾𝜹'
   ~ 𝜀𝝁ᵣ + 𝑾ᵣˢ𝒆ₛ𝓑𝒂ₛ
   ~ 𝜀𝝁ᵣ + 𝑾ᵣˢ𝓑𝒂ₛ𝒆ₛ
## Substitute out 𝒆ₛ:
𝒆ᵣ ~ 𝜀𝝁ᵣ + 𝑾ᵣˢ𝓑𝒂ₛ𝒆ₛ
   ~ 𝜀𝝁ᵣ + 𝑾ᵣˢ𝓑𝒂ₛ(𝜀𝝁ₛ + 𝑾ₛʲ𝜹ₜ) # 𝒆~𝜀𝝁+𝑾𝜹'
   ~ 𝜀𝝁ᵣ + 𝑾ᵣˢ𝓑𝒂ₛ𝜀𝝁ₛ + 𝑾ᵣˢ𝓑𝒂ₛ𝑾ₛʲ𝜹ₜ
   ~ 𝜀𝝁ᵣ + 𝜀𝑾ᵣˢ𝓑𝒂ₛ𝝁ₛ + 𝑾ᵣˢ𝓑𝒂ₛ𝑾ₛʲ𝜹ₜ # reorder
   ~ 𝜀𝝁ᵣ + 𝜀𝜧ᵣˢ𝝁ₛ + 𝜧ᵣˢ𝑾ₛʲ𝜹ₜ # 𝜧 =𝑾𝓑𝒂'
𝒆ᵣ ~ 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ) + 𝜧ᵣˢ𝑾ₛʲ𝜹ₜ # Level 2 plus an additional term due to 𝜹ₜ
# Recall that in level 2, 𝜹ₜ was zero, but level three continues...
𝒆ᵣ ~ 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ) + 𝜧ᵣˢ𝑾ₛʲ𝜹ₜ
   ~ 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ) + 𝜧ᵣˢ𝑾ₛʲ𝓑𝒂ₜ𝒆ₜ # 𝜹~𝓑𝒂𝒆
   ~ 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ) + 𝜧ᵣˢ𝜧ₛʲ𝒆ₜ
   ~ 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ) + 𝜧ᵣˢ𝜧ₛʲ(𝜀𝝁ₜ+𝑾ₜᵏ𝜹ᵤ) # 𝒆~𝜀𝝁+𝑾𝜹'
   ~ 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ) + 𝜀𝜧ᵣˢ𝜧ₛʲ𝝁ₜ + 𝜧ᵣˢ𝜧ₛʲ𝑾ₜᵏ𝜹ᵤ
   ~ 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ + 𝜧ᵣˢ𝜧ₛʲ𝝁ₜ) + 𝜧ᵣˢ𝜧ₛʲ𝑾ₜᵏ𝜹ᵤ
# For level three, 𝜹ᵤ is zero:
𝒆ᵣ ~ 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ + 𝜧ᵣˢ𝜧ₛʲ𝝁ₜ)
```
### General propagation of errors
```korekto
# The above establishes a clear pattern:
𝒆ᵣ ~ 𝜀(𝝁ᵣ + 𝜧ᵣˢ𝝁ₛ + 𝜧ᵣˢ𝜧ₛʲ𝝁ₜ + 𝜧ᵣˢ𝜧ₛʲ𝜧ₜᵏ𝝁ᵤ + ...)
𝒆 ~ 𝜀(𝝁 + 𝜧 𝝁' + 𝜧 𝜧'𝝁" + 𝜧 𝜧'𝜧"𝝁"' + ...)
# Error bound estimate:
0 < 𝒂 < 1
0 < 𝓑𝒂=(1-𝒂)𝒂 < 0.25 = ¼
|𝓑𝒂| ~ ¼
|𝒂| ~ ½
|𝝁| ~ 1+∑|𝒂'|
    ~ 1+∑½
    ~ 1+½𝑁 := 𝔪
|∑𝑾| ~ √𝑁 # random walk
|𝜧| ~ |𝑾||𝓑𝒂|
    ~ ¼√𝑁
|𝒆| ~ |𝜀|(|𝝁| + |𝜧 𝝁'| + |𝜧 𝜧'𝝁"| + |𝜧 𝜧'𝜧"𝝁"'| + ...)
    ~ |𝜀|(𝔪 + |𝜧 |𝔪 + |𝜧 𝜧'|𝔪 + |𝜧 𝜧'𝜧"'|𝔪 + ...)
    ~ |𝜀|𝔪(1 + |𝜧| + |𝜧|² + |𝜧|³ + ...)
# Consider very large 𝑁 on each level in an 𝑛+2 layer network:
|𝒆| ~ |𝜀|½𝑁(¼√𝑁)ⁿ
# For a 3 layer network(input, middle, and output layers), 𝑛=1:
|𝒆| ~ |𝜀|𝔪(1 + |𝜧|)
    ~ |𝜀|𝑁√𝑁 / 8 # 𝑁>>1, large 𝑁
|𝜀| ~ 8|𝒆| / 𝑁√𝑁 # 𝑁>>1
```
### Legacy
```korekto
# In trying to find the recursion pattern, I came across several interesting
# expressions.  I define them all here, including the ones actually used above:
𝓑𝒂 := 𝒂(1-𝒂)
𝒂 := ⌈𝒗
𝒗 := 𝒃 + 𝑾 𝒂'
𝒂 = ⌈ 𝒃+𝑾𝒂'
𝒂+𝜹 := ⌈(𝒗+𝒆)
𝒗 = ⌋𝒂
𝒗+𝒆 := 𝒃+𝜺 + (𝑾+𝜺)(𝒂'+𝜹')
𝝁 := 1+∑𝒂'
𝜧 𝝁' := 𝑾 𝓑𝒂'𝝁'
# Legacy:
𝝀 := 𝓑𝒂 𝝁
𝜿 := 𝜧 𝝁' = 𝑾 𝓑𝒂'𝝁' = 𝑾 𝝀'
𝜾 := 𝜧 𝜿' = 𝜧 𝜧'𝝁"
```
