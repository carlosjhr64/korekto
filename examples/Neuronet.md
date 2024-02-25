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

* `{ᵣ ₛ ₜ ᵤ ᵥ}`

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
Scalar[𝑥]	#S1/L24.KorektoMath Scalar: 𝑥
# The labeled activation layer vector 𝒂
Vector[𝒂]	#S2/L25.KorektoMath Vector: 𝒂
# The labeled bias vector 𝒃
Vector[𝒃]	#S3/L25.KorektoMath Vector: 𝒃
# The multi-labeled weights matrix 𝑾
Tensor[𝑾]	#S4/L26.KorektoMath Tensor: 𝑾
# Labels
Contravariant{ʰ ⁱ ʲ ᵏ}	#S5/L4.KorektoMath Named set: Contravariant ʰ ʲ ᵏ
Covariant{ᵣ ₛ ₜ ᵤ}	#S6/L4.KorektoMath Named set: Covariant ᵣ ₜ ᵤ
# Next labels
ᵣ₊ = ₛ	#R7/M7.KorektoMath,S6 Next
ₛ₊ = ₜ	#R8/M7.KorektoMath,S6 Next
ₜ₊ = ᵤ	#R9/M7.KorektoMath,S6 Next
# Raised labels
ᵣ⭎ = ʰ	#C9/I11.KorektoMath,S5,S4 →1st
ₛ⭎ = ⁱ	#C10/I12.KorektoMath,S5,S4 →2nd
ₜ⭎ = ʲ	#C11/I13.KorektoMath,S5,S4 →3rd
ᵤ⭎ = ᵏ	#C12/I14.KorektoMath,S5,S4 →4th
# Natural Exponentiation and Logarythm
𝖊∧𝑥 : 𝖊ˣ	#S13/L1.KorektoMath ≝: ˣ
𝖊𝓵𝖊ˣ = 𝑥	#R14/M40.KorektoMath,S13 ∧→𝓵
# Exp and Log are inverses of eachother
𝖊𝓵(𝖊ˣ) = 𝑥	#R15/M98.KorektoMath,R14 a → (a)
𝖊𝓵(𝖊∧𝑥) = 𝑥	#C16/I218.KorektoMath,S13,R15 G=F,(F)→(G)
𝖊𝓵(𝖊∧(𝑥)) = 𝑥	#R17/M98.KorektoMath,C16 a → (a)
𝖊𝓵(𝖊∧(𝓍)) = 𝓍	#A18/R17 Inverses 𝓵∧
# Likewise:
𝖊∧(𝖊𝓵(𝓍)) = 𝓍	#A19 Inverses ∧𝓵
```
### Natural exponentiation function
```korekto
# In Ruby, the natural exponentiation function is:
#     Math.exp(x) == Math::E**x #=> true
# Here its:
⌉𝑥 = 𝖊∧𝑥	#T20/A91.KorektoMath Exp
# Prove ⌉0 = 𝖊∧0 = 1
⌉0 = 𝖊∧0	#T21/A91.KorektoMath Exp
⌉0 = 𝖊∧(0)	#R22/M98.KorektoMath,T21 a → (a)
𝑥 - 𝑥 = 0	#T23/A27.KorektoMath Zero
⌉0 = 𝖊∧(𝑥 - 𝑥)	#C24/I218.KorektoMath,T23,R22 G=F,(F)→(G)
⌉0 = 𝖊∧(𝑥 + -𝑥)	#R25/M226.KorektoMath,C24 a-b=a+-b
⌉0 = 𝖊∧𝑥*𝖊∧-𝑥	#R26/M229.KorektoMath,R25 a^(b+c)=a^b*a^c
⌉0 = (𝖊∧𝑥)*(𝖊∧-𝑥)	#R27/M162.KorektoMath,R26 a^b~c^d → (a^b)~(c^c)
# Then:
𝖊∧-𝑥 = 1 / 𝖊∧𝑥	#T28/A36.KorektoMath Reciprical
⌉0 = (𝖊∧𝑥)*(1 / 𝖊∧𝑥)	#C29/I217.KorektoMath,T28,R27 G=F,(G)→(F)
⌉0 = (𝖊∧𝑥)*(1 / (𝖊∧𝑥))	#R30/M142.KorektoMath,C29 _g)→_(g))
⌉0 = ((𝖊∧𝑥) / (𝖊∧𝑥))	#R31/M191.KorektoMath,R30 x*(1/y) → (x/y)
⌉0 = 1	#R32/M171.KorektoMath,R31 (a/a)→1
# Prove ⌉𝑥⌉-𝑥 = 1
⌉𝑥⌉-𝑥 = ⌉𝑥⌉-𝑥	#T33/A166.KorektoMath Reflection
⌉𝑥⌉-𝑥 = ⌉𝑥*⌉-𝑥	#R34/M163.KorektoMath,T33 Explicit*
⌉𝑥⌉-𝑥 = (⌉𝑥)*(⌉-𝑥)	#R35/M100.KorektoMath,R34 a~b → (a)~(b)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(⌉-𝑥)	#C36/I217.KorektoMath,T20,R35 G=F,(G)→(F)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(⌉(-𝑥))	#R37/M98.KorektoMath,C36 a → (a)
⌉(-𝑥) = 𝖊∧(-𝑥)	#T38/A91.KorektoMath Exp
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(𝖊∧(-𝑥))	#C39/I217.KorektoMath,T38,R37 G=F,(G)→(F)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(𝖊∧-𝑥)	#R40/M99.KorektoMath,C39 (a) → a
⌉𝑥⌉-𝑥 = ⌉0	#C41/I169.KorektoMath,R40,R27 a=b;c=b;a=c
⌉𝑥⌉-𝑥 = 1	#C42/I167.KorektoMath,C41,R32 a=b;b=c;a=c
# Abstract
⌉𝓍⌉-𝓍 = 1	#A43/C42 ⌉𝑥⌉-𝑥=1
⌉-𝓍⌉𝓍 = 1	#A44 ⌉-𝑥⌉𝑥=1
```
### Natural logarithm function
```korekto
# In Ruby, the natural log funtion is:
#     y = Math.exp(x)
#     Math.log(y) == x #=> true
# Here its:
⌊𝑥 = 𝖊𝓵𝑥	#T45/A92.KorektoMath Log
# So we can contract the inverse relation
𝖊𝓵(𝖊∧(𝑥)) = 𝑥	#R17/M98.KorektoMath,C16 a → (a)
⌊(𝖊∧(𝑥)) = 𝖊𝓵(𝖊∧(𝑥))	#T46/A92.KorektoMath Log
⌊(𝖊∧(𝑥)) = 𝑥	#C47/I167.KorektoMath,T46,R17 a=b;b=c;a=c
⌉(𝑥) = 𝖊∧(𝑥)	#T48/A91.KorektoMath Exp
⌊(⌉(𝑥)) = 𝑥	#C49/I218.KorektoMath,T48,C47 G=F,(F)→(G)
⌊(⌉𝑥) = 𝑥	#R50/M99.KorektoMath,C49 (a) → a
⌊⌉𝑥 = 𝑥	#R51/M99.KorektoMath,R50 (a) → a
⌊⌉𝓍 = 𝓍	#A52/R51 ⌊⌉=1
# Likewise
⌉⌊𝓍 = 𝓍	#A53 ⌉⌊=1
# If 𝖊∧0 = 1, then 𝖊𝓵1 = 0 by definition of 𝓵
⌊1 = 𝖊𝓵1	#T54/A92.KorektoMath Log
𝖊∧0 = 1	#T55/A35.KorektoMath x∧0=1
𝖊𝓵1 = 0	#R56/M40.KorektoMath,T55 ∧→𝓵
⌊1 = 0	#C57/I208.KorektoMath,R56,T54 g=f,_g$→_f$
```
### Squash
```korekto
# The squash function in Ruby is:
#     1 / (1 + Math.exp(-𝑥))
# Here its:
⌈𝑥 = 1 / 1+⌉-𝑥	#T58/A235.KorektoMath Squash
⌈𝑥 = 1 / (1 + ⌉-𝑥)	#R59/M107.KorektoMath,T58 _a+b$ → ♭(a♭+♭b)$
# Alternate
⌈𝑥 = ⌉𝑥*1 / ⌉𝑥*(1 + ⌉-𝑥)	#R60/M186.KorektoMath,R59 _x*a_/_x*b$
⌈𝑥 = ⌉𝑥 / ⌉𝑥*(1 + ⌉-𝑥)	#R61/M173.KorektoMath,R60 *1_
⌈𝑥 = ⌉𝑥 / (⌉𝑥*1 + ⌉𝑥*⌉-𝑥)	#R62/M197.KorektoMath,R61 (x*a♭±♭x*b)
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + ⌉𝑥*⌉-𝑥)	#R63/M173.KorektoMath,R62 *1_
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + ⌉𝑥⌉-𝑥)	#R64/M164.KorektoMath,R63 Implied*
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + 1)	#C65/I203.KorektoMath,C42,R64 g=a,_g)→_a)
⌈𝑥 = ⌉𝑥 / (1 + ⌉𝑥)	#R66/M230.KorektoMath,C65 (a+b)→(b+a)
⌈𝑥 = ⌉𝑥 / 1+⌉𝑥	#R67/M106.KorektoMath,R66 ♭(a♭+♭b)$ → _a+b$
⌈𝓍 = ⌉𝓍 / 1+⌉𝓍	#A68/R67 Alternate Squash
# Equivalence 1-⌈𝑥 = ⌈-𝑥
1-⌈𝑥 = 1-⌈𝑥	#T69/A166.KorektoMath Reflection
1-⌈𝑥 = 1 - ⌈𝑥	#R70/M156.KorektoMath,T69 +_g+f$ → +_g_+_f$
1-⌈𝑥 = 1 - (⌉𝑥 / 1+⌉𝑥)	#C71/I212.KorektoMath,R67,R70 a=G,a→(G)
1-⌈𝑥 = (1+⌉𝑥-⌉𝑥 / 1+⌉𝑥)	#R72/M193.KorektoMath,C71 _1±(a_/_g) → (g±a / g)
1-⌈𝑥 = 1+⌉𝑥-⌉𝑥 / 1+⌉𝑥	#R73/M148.KorektoMath,R72 +_(G)$ → +_G$
1-⌈𝑥 = 1 / 1+⌉𝑥	#R74/M180.KorektoMath,R73 +a-a_
# Cosider ⌈-𝑥
⌈-𝑥 = ⌈-𝑥	#T75/A166.KorektoMath Reflection
⌈-𝑥 = 1 / 1+⌉--𝑥	#T76/A235.KorektoMath Squash
⌈-𝑥 = 1 / 1+⌉𝑥	#R77/M231.KorektoMath,T76 --a→a
# Then:
1-⌈𝑥 = ⌈-𝑥	#C78/I170.KorektoMath,R77,R74 a=b;c=b;c=a
1-⌈𝓍 = ⌈-𝓍	#A79/C78 1-⌈𝑥=⌈-𝑥
⌈-𝑥 = 1-⌈𝑥	#R80/M165.KorektoMath,C78 Symmetry
⌈-𝓍 = 1-⌈𝓍	#A81/R80 ⌈-𝑥=1-⌈𝑥
# Corrolary: ⌈𝑥+⌈-𝑥 = 1
⌈𝑥+⌈-𝑥 = ⌈𝑥+⌈-𝑥	#T82/A166.KorektoMath Reflection
⌈𝑥+⌈-𝑥 = ⌈𝑥 + ⌈-𝑥	#R83/M156.KorektoMath,T82 +_g+f$ → +_g_+_f$
⌈𝑥+⌈-𝑥 = ⌈𝑥 + 1-⌈𝑥	#C84/I208.KorektoMath,R80,R83 g=f,_g$→_f$
⌈𝑥+⌈-𝑥 = ⌈𝑥 + 1 - ⌈𝑥	#R85/M156.KorektoMath,C84 +_g+f$ → +_g_+_f$
⌈𝑥+⌈-𝑥 = (⌈𝑥 + 1) - ⌈𝑥	#R86/M145.KorektoMath,R85 +_G_+ → +_(G)_+
⌈𝑥+⌈-𝑥 = (1 + ⌈𝑥) - ⌈𝑥	#R87/M230.KorektoMath,R86 (a+b)→(b+a)
⌈𝑥+⌈-𝑥 = 1 + ⌈𝑥 - ⌈𝑥	#R88/M144.KorektoMath,R87 +_(G)_+ → +_G_+
⌈𝑥+⌈-𝑥 = 1	#R89/M178.KorektoMath,R88 +a-a$ → $
# Derivative:
# Label 𝑥
ₓ → 𝑥	#S82.KorektoMath/L74.KorektoMath Map: ₓ
# ₓ → 𝑥;𝓓ₓ𝓐(𝑥) = ...
𝓓ₓ⌈𝑥 = 𝓓ₓ⌈𝑥	#T90/A166.KorektoMath Reflection
𝓓ₓ⌈𝑥 = 𝓓ₓ(⌈𝑥)	#R91/M98.KorektoMath,T90 a → (a)
𝓓ₓ⌈𝑥 = 𝓓ₓ(1 / 1+⌉-𝑥)	#C92/I217.KorektoMath,T58,R91 G=F,(G)→(F)
𝓓ₓ(1 / 1+⌉-𝑥) = -𝓓ₓ⌉-𝑥 / (1+⌉-𝑥)²	#T93/A243.KorektoMath From quotient rule
𝓓ₓ⌈𝑥 = -𝓓ₓ⌉-𝑥 / (1+⌉-𝑥)²	#C94/I221.KorektoMath,T93,C92 G=F, +_G$ → +_F$
# Consider 𝓓ₓ⌉-𝑥
𝓓ₓ⌉-𝑥 = 𝓓ₓ⌉-𝑥	#T95/A166.KorektoMath Reflection
𝓓ₓ⌉-𝑥 = 𝓓ₓ(⌉-𝑥)	#R96/M98.KorektoMath,T95 a → (a)
⌉-𝑥 = 𝖊∧-𝑥	#T97/A91.KorektoMath Exp
𝓓ₓ⌉-𝑥 = 𝓓ₓ(𝖊∧-𝑥)	#C98/I217.KorektoMath,T97,R96 G=F,(G)→(F)
𝓓ₓ(𝖊∧-𝑥) = 𝓓ₓ(-𝑥)𝖊∧-𝑥	#T99/A245.KorektoMath D(e^x)=D(x)e^x
𝓓ₓ⌉-𝑥 = 𝓓ₓ(-𝑥)𝖊∧-𝑥	#C100/I208.KorektoMath,T99,C98 g=f,_g$→_f$
𝓓ₓ⌉-𝑥 = 𝓓ₓ(-𝑥)*𝖊∧-𝑥	#R101/M163.KorektoMath,C100 Explicit*
𝓓ₓ(-𝑥) = -1	#R102/M248.KorektoMath,S82.KorektoMath 𝓓ₓ-𝑥=-1
𝓓ₓ⌉-𝑥 = -1*𝖊∧-𝑥	#C103/I199.KorektoMath,R102,R101 a=b,a→b
𝓓ₓ⌉-𝑥 = -𝖊∧-𝑥	#R104/M174.KorektoMath,C103 _1*
𝓓ₓ⌉-𝑥 = -(𝖊∧-𝑥)	#R105/M160.KorektoMath,R104 a^b → (a^b)
-𝓓ₓ⌉-𝑥 = (𝖊∧-𝑥)	#R106/M232.KorektoMath,R105 a=-b;-a=-b
# Substituting
𝓓ₓ⌈𝑥 = (𝖊∧-𝑥) / (1+⌉-𝑥)²	#C107/I199.KorektoMath,R106,C94 a=b,a→b
𝓓ₓ⌈𝑥 = 𝖊∧-𝑥 / (1+⌉-𝑥)²	#R108/M136.KorektoMath,C107 ♭(g)♭ → _g_
𝓓ₓ⌈𝑥 = ⌉-𝑥 / (1+⌉-𝑥)²	#C109/I207.KorektoMath,T97,R108 g=f,_f_→_g_
𝓓ₓ⌈𝑥 = ⌉-𝑥/(1+⌉-𝑥)²	#R110/M113.KorektoMath,C109 _a_*_b$ → _a*b$
𝓓ₓ⌈𝑥 = ⌉-𝑥/(1+⌉-𝑥) 1/(1+⌉-𝑥)	#R111/M194.KorektoMath,R110 _a/b²$→_a/b_1/b$
⌈𝑥 = 1 / (1+⌉-𝑥)	#R112/M104.KorektoMath,R59 (a_+_b) → (a+b)
⌈𝑥 = 1/(1+⌉-𝑥)	#R113/M113.KorektoMath,R112 _a_*_b$ → _a*b$
𝓓ₓ⌈𝑥 = ⌉-𝑥/(1+⌉-𝑥) ⌈𝑥	#C114/I209.KorektoMath,R113,R111 g=f,_f$→_g$
⌈-𝑥 = ⌉-𝑥 / 1+⌉-𝑥	#T115/A68 Alternate Squash
⌈-𝑥 = ⌉-𝑥 / (1+⌉-𝑥)	#R116/M107.KorektoMath,T115 _a+b$ → ♭(a♭+♭b)$
⌈-𝑥 = ⌉-𝑥/(1+⌉-𝑥)	#R117/M113.KorektoMath,R116 _a_*_b$ → _a*b$
𝓓ₓ⌈𝑥 = ⌈-𝑥 ⌈𝑥	#C118/I207.KorektoMath,R117,C114 g=f,_f_→_g_
𝓓ₓ⌈𝑥 = 1-⌈𝑥 ⌈𝑥	#C119/I206.KorektoMath,R80,C118 g=f,_g_→_f_
𝓓ₓ⌈𝑥 = (1-⌈𝑥) ⌈𝑥	#R120/M110.KorektoMath,C119 _a+b_ → ♭(a♭+♭b)♭
𝓓ₓ⌈𝑥 = (1-⌈𝑥)*⌈𝑥	#R121/M163.KorektoMath,R120 Explicit*
𝓑⌈𝑥 = (1-⌈𝑥)*⌈𝑥	#T122/A237.KorektoMath Binary balance
𝓓ₓ⌈𝑥 = 𝓑⌈𝑥	#C123/I170.KorektoMath,T122,R121 a=b;c=b;c=a
```
### Unsquash
```korekto
# The unsquash function in Ruby is:
#   Math.log(𝑥 / (1 - 𝑥))
# Here  its:
⌋𝑥 = ⌊ 𝑥/(1-𝑥)	#T124/A236.KorektoMath Unsquash
# Show that unsquash is the inverse of squash(⌋⌈=1):
⌋⌈𝑥 = ⌋⌈𝑥	#T125/A166.KorektoMath Reflection
⌋⌈𝑥 = ⌊ ⌈𝑥/(1-⌈𝑥)	#T126/A236.KorektoMath Unsquash
⌊ ⌈𝑥/(1-⌈𝑥) = ⌊⌈𝑥 - ⌊(1-⌈𝑥)	#T127/A234.KorektoMath ⌊(a/b)=⌊a-⌊b
⌋⌈𝑥 = ⌊⌈𝑥 - ⌊(1-⌈𝑥)	#C128/I221.KorektoMath,T127,T126 G=F, +_G$ → +_F$
⌋⌈𝑥 = ⌊(⌈𝑥) - ⌊(1-⌈𝑥)	#R129/M98.KorektoMath,C128 a → (a)
⌈𝑥 = ⌉𝑥 / 1+⌉𝑥	#R67/M106.KorektoMath,R66 ♭(a♭+♭b)$ → _a+b$
⌋⌈𝑥 = ⌊(⌉𝑥 / 1+⌉𝑥) - ⌊(1-⌈𝑥)	#C130/I217.KorektoMath,R67,R129 G=F,(G)→(F)
⌋⌈𝑥 = ⌊ ⌉𝑥/(1+⌉𝑥) - ⌊(1-⌈𝑥)	#R131/M124.KorektoMath,C130 ♭(a_*_g)♭ → _a*(g)_
⌊ ⌉𝑥/(1+⌉𝑥) = ⌊⌉𝑥 - ⌊(1+⌉𝑥)	#T132/A234.KorektoMath ⌊(a/b)=⌊a-⌊b
⌊⌉𝑥 = 𝑥	#R51/M99.KorektoMath,R50 (a) → a
⌊ ⌉𝑥/(1+⌉𝑥) = 𝑥 - ⌊(1+⌉𝑥)	#C133/I199.KorektoMath,R51,T132 a=b,a→b
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊(1-⌈𝑥)	#C134/I223.KorektoMath,C133,R131 G=F, +_G_+ → +_F_+
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1-⌈𝑥	#R135/M106.KorektoMath,C134 ♭(a♭+♭b)$ → _a+b$
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1-(⌈𝑥)	#R136/M98.KorektoMath,R135 a → (a)
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1-(⌉𝑥 / 1+⌉𝑥)	#C137/I217.KorektoMath,R67,R136 G=F,(G)→(F)
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ (1+⌉𝑥-⌉𝑥 / 1+⌉𝑥)	#R138/M193.KorektoMath,C137 _1±(a_/_g) → (g±a / g)
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ (1 / 1+⌉𝑥)	#R139/M180.KorektoMath,R138 +a-a_
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1/(1+⌉𝑥)	#R140/M126.KorektoMath,R139 ♭(a_*_g)$ → _a*(g)$
⌊ 1/(1+⌉𝑥) = ⌊1 - ⌊(1+⌉𝑥)	#T141/A234.KorektoMath ⌊(a/b)=⌊a-⌊b
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊1 - ⌊(1+⌉𝑥)	#C142/I221.KorektoMath,T141,R140 G=F, +_G$ → +_F$
⌊1 = 0	#C57/I208.KorektoMath,R56,T54 a=b,_a$→_b$
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - 0 - ⌊(1+⌉𝑥)	#C143/I199.KorektoMath,C57,C142 a=b,a→b
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) + ⌊(1+⌉𝑥)	#R144/M184.KorektoMath,C143 ±0± → +
⌋⌈𝑥 = 𝑥	#R145/M179.KorektoMath,R144 -a+a$ → $
⌋⌈𝓍 = 𝓍	#A146/R145 Inverse
# Likewise:
⌈⌋𝓍 = 𝓍	#A147 Inverse
```
### Activation and value of a neuron
```korekto
# The activation of the h-th Neuron(in level h connecting to level i):
ₛ₊ = ₜ;𝒂ₛ = ⌈ 𝒃ₛ+∑ₜ(𝑪ₛₜ𝒂ₜ)	#M148 Activation
ᵣ₊ = ₛ	#R6/M7.KorektoMath,S5 Next
𝒂ᵣ = ⌈ 𝒃ᵣ+∑ₛ(𝑾ᵣₛ𝒂ₛ)	#R149/M148,R6 Activation
ₛ⭎ = ⁱ	#C10/I12.KorektoMath,S5,S4 →2nd
∑ₛ(𝑾ᵣₛ𝒂ₛ) = 𝑾ᵣⁱ𝒂ₛ	#R150/M249.KorektoMath,C10 Einstein notation
𝒂ᵣ = ⌈ 𝒃ᵣ+(𝑾ᵣⁱ𝒂ₛ)	#C151/I212.KorektoMath,R150,R149 a=G,a→(G)
𝒂ᵣ = ⌈ 𝒃ᵣ+𝑾ᵣⁱ𝒂ₛ	#R152/M132.KorektoMath,C151 *(ab)$ → *ab$
# The above is correct. Now, how to cleanly loose the labels?
𝒂 = ⌈ 𝒃+𝑾𝒂₊	#H153 hide labels
# The value of the h-th Neuron is the unsquashed activation:
⌋𝒂 = ⌋⌈ 𝒃+𝑾𝒂₊	#R154/M233.KorektoMath,H153 x_=_G_g;Fx_=_FG_g
⌋⌈(𝒃+𝑾𝒂₊) = (𝒃+𝑾𝒂₊)	#T155/A146 Inverse
⌋⌈(𝒃+𝑾𝒂₊) = 𝒃+𝑾𝒂₊	#R156/M138.KorektoMath,T155 ♭(g)$ → _g$
⌋⌈ 𝒃+𝑾𝒂₊ = 𝒃+𝑾𝒂₊	#R157/M136.KorektoMath,R156 ♭(g)♭ → _g_
⌋𝒂 = 𝒃+𝑾𝒂₊	#C158/I221.KorektoMath,R157,R154 G=F, +_G$ → +_F$
# Neuron's value
𝒗 : ⌋𝒂	#S159/L1.KorektoMath ≝: 𝒗
# Shrunk 𝒗
ᵣ⭎ = ʰ	#C9/I11.KorektoMath,S5,S4 →1st
ₛ⭎ = ⁱ	#C10/I12.KorektoMath,S5,S4 →2nd
𝒗 = 𝒃+𝑾𝒂₊	#C160/I167.KorektoMath,S159,C158 a=b;b=c;a=c
# Explicit 𝒗
𝒗ᵣ = 𝒃ᵣ+𝑾ʰⁱ𝒂ₛ	#H161
! stop!
```
### Mirroring
```korekto
# The bias and weight of a neuron that roughly mirrors the value of another:
𝕧 := {-1, 0, 1}
𝕒 := ⌈(𝖇 + (𝖜 * 𝕒)) = ⌈ 𝖇+𝖜*𝕒
𝕧 := ⌋(𝕒) = ⌋𝕒
# Notice that:
𝕒 = ⌈(𝕧) = {⌈(-1), ⌈(0), ⌈(1)}
⌈(0) = ⌈0 = ½
# Find the bias and weight:
𝕧 = ⌋⌈(𝖇 + (𝖜 * 𝕒))
  = ⌋⌈𝖇+𝖜𝕒
  = ⌋⌈ 𝖇+𝖜⌈𝕧
  = 𝖇+𝖜⌈𝕧
𝕧 = 𝖇 + (𝖜 * ⌈(𝕧))
# Set the value to zero:
0 = 𝖇 + 𝖜⌈(0)
0 = 𝖇+𝖜⌈0
𝖇 = -𝖜⌈0
𝖇 = -½𝖜
𝖜 = -2𝖇
# Set the value to one and substitute the bias:
1 = 𝖇 + 𝖜⌈(1)
1 = 𝖇+𝖜⌈1
1 = -½𝖜+𝖜⌈1
1 = 𝖜(⌈1 - ½)
𝖜 = 1 / (⌈1 - ½)
𝖇 = ½ / (½ - ⌈1)
# Verify this works when value is negative one:
-1 = 𝖇 + (𝖜 * ⌈(-1))
-1 = 𝖇 + 𝖜⌈-1
-1 = -½𝖜 + 𝖜⌈-1
-1 = -½𝖜 + 𝖜(1-⌈1)
-1 = -½𝖜 + 𝖜 - 𝖜⌈1
-1 = ½𝖜 - 𝖜⌈1
1 = 𝖜⌈1 - ½𝖜
1 = 𝖜(⌈1 - ½)
𝖜 = 1 / (⌈1 - ½)
𝖜 = 1 / (⌈(1) - ½) # OK
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
𝒆ᵣ = 𝜺ᵣ + 𝜺ⁱ𝒂ₛ
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
𝜧ᵣⁱ𝝁ₛ := ∑ₛ 𝑾ᵣₛ𝓑𝒂ₛ𝝁ₛ
𝜧 𝝁' = 𝑾 𝓑𝒂'𝝁'
# Substitute in 𝜧 :
𝒆 ~ 𝜀(𝝁 + 𝑾 𝓑𝒂'𝝁') + 𝑾 𝓑𝒂'𝑾'𝜹"
  ~ 𝜀(𝝁 + 𝜧 𝝁') + 𝜧 𝑾'𝜹"
# *** Equipartitioned error level two ***
# For level two, 𝜹"=0
𝒆 ~ 𝜀(𝝁 + 𝜧 𝝁')
𝒆ᵣ ~ 𝜀 * (𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ)
# Solve for 𝜀:
𝜀 ~ 𝒆 / (𝝁 + 𝜧 𝝁')
𝜀ᵣ ~ 𝒆ᵣ / (𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ)
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
        ~ 𝒃ᵣ + 𝜺ᵣ + 𝑾ᵣⁱ(𝒂ₛ + 𝜀𝝁ₛ(1-𝒂ₛ)𝒂ₛ) + 𝜺ⁱ(𝒂ₛ + 𝜀𝝁ₛ(1-𝒂ₛ)𝒂ₛ)
        ~ 𝒃ᵣ + 𝜺ᵣ + 𝑾ᵣⁱ𝒂ₛ + 𝜀𝑾ᵣⁱ𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝜺ⁱ𝒂ₛ + 𝜺ⁱ𝜀𝝁ₛ(1-𝒂ₛ)𝒂ₛ
        ~ 𝒃ᵣ + 𝜺ᵣ + 𝑾ᵣⁱ𝒂ₛ + 𝜀𝑾ᵣⁱ𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝜺ⁱ𝒂ₛ # 𝜺ⁱ𝜀 vanishes
        ~ 𝒃ᵣ + 𝑾ᵣⁱ𝒂ₛ + 𝜀𝑾ᵣⁱ𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝜺ᵣ + 𝜺ⁱ𝒂ₛ # reordered terms
        ~ 𝒗ᵣ + 𝜀𝑾ᵣⁱ𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝜺ᵣ + 𝜺ⁱ𝒂ₛ
        ~ 𝒗ᵣ + 𝜀𝑾ᵣⁱ𝝁ₛ(1-𝒂ₛ)𝒂ₛ + 𝜀(1+∑𝒂ₛ)
        ~ 𝒗ᵣ + 𝜀(1+∑𝒂ₛ) + 𝜀𝑾ᵣⁱ𝝁ₛ(1-𝒂ₛ)𝒂ₛ # reordered
        ~ 𝒗ᵣ + 𝜀𝝁ᵣ + 𝜀𝜧ᵣⁱ𝝁ₛ # 𝜧 = 𝑾𝓑𝒂'
𝒗ᵣ + 𝒆ᵣ ~ 𝒗ᵣ + 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ)
𝒆ᵣ ~ 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ)
𝜀 ~ 𝒆ᵣ / (𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ)
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
𝜧ᵣⁱ𝝁ₛ := ∑ₛ(𝑾ᵣₛ * (1 - 𝒂ₛ) * 𝒂ₛ * 𝝁ₛ)
       = 𝑾ᵣⁱ𝓑𝒂ₛ𝝁ₛ
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
        = 𝒃ᵣ+𝜀 + (𝑾ᵣⁱ+𝜺ⁱ)(𝒂ₛ+𝜹ₛ)
        = 𝒃ᵣ+𝜀 + 𝑾ᵣⁱ𝒂ₛ + 𝜺ⁱ𝒂ₛ + 𝑾ᵣⁱ𝜹ₛ + 𝜺ⁱ𝜹ₛ
        ~ 𝒃ᵣ+𝜀 + 𝑾ᵣⁱ𝒂ₛ + 𝜺ⁱ𝒂ₛ + 𝑾ᵣⁱ𝜹ₛ # 𝜺𝜹 vanishes
        ~ 𝒃ᵣ+𝑾ᵣⁱ𝒂ₛ + 𝜀+𝜺ⁱ𝒂ₛ + 𝑾ᵣⁱ𝜹ₛ
        ~ 𝒗ᵣ + 𝜀+𝜺ⁱ𝒂ₛ + 𝑾ᵣⁱ𝜹ₛ
𝒆ᵣ ~ 𝜀+𝜺ⁱ𝒂ₛ + 𝑾ᵣⁱ𝜹ₛ
   ~ 𝜀(1+∑𝒂ₛ) + 𝑾ᵣⁱ𝜹ₛ
   ~ 𝜀𝝁ᵣ + 𝑾ᵣⁱ𝜹ₛ
## Substitute out 𝜹ₛ:
𝒆ᵣ ~ 𝜀𝝁ᵣ + 𝑾ᵣⁱ𝜹ₛ # 𝒆=𝜀𝝁+𝑾𝜹'
   ~ 𝜀𝝁ᵣ + 𝑾ᵣⁱ𝒆ₛ𝓑𝒂ₛ
   ~ 𝜀𝝁ᵣ + 𝑾ᵣⁱ𝓑𝒂ₛ𝒆ₛ
## Substitute out 𝒆ₛ:
𝒆ᵣ ~ 𝜀𝝁ᵣ + 𝑾ᵣⁱ𝓑𝒂ₛ𝒆ₛ
   ~ 𝜀𝝁ᵣ + 𝑾ᵣⁱ𝓑𝒂ₛ(𝜀𝝁ₛ + 𝑾ₛʲ𝜹ₜ) # 𝒆~𝜀𝝁+𝑾𝜹'
   ~ 𝜀𝝁ᵣ + 𝑾ᵣⁱ𝓑𝒂ₛ𝜀𝝁ₛ + 𝑾ᵣⁱ𝓑𝒂ₛ𝑾ₛʲ𝜹ₜ
   ~ 𝜀𝝁ᵣ + 𝜀𝑾ᵣⁱ𝓑𝒂ₛ𝝁ₛ + 𝑾ᵣⁱ𝓑𝒂ₛ𝑾ₛʲ𝜹ₜ # reorder
   ~ 𝜀𝝁ᵣ + 𝜀𝜧ᵣⁱ𝝁ₛ + 𝜧ᵣⁱ𝑾ₛʲ𝜹ₜ # 𝜧 =𝑾𝓑𝒂'
𝒆ᵣ ~ 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ) + 𝜧ᵣⁱ𝑾ₛʲ𝜹ₜ # Level 2 plus an additional term due to 𝜹ₜ
# Recall that in level 2, 𝜹ₜ was zero, but level three continues...
𝒆ᵣ ~ 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ) + 𝜧ᵣⁱ𝑾ₛʲ𝜹ₜ
   ~ 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ) + 𝜧ᵣⁱ𝑾ₛʲ𝓑𝒂ₜ𝒆ₜ # 𝜹~𝓑𝒂𝒆
   ~ 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ) + 𝜧ᵣⁱ𝜧ₛʲ𝒆ₜ
   ~ 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ) + 𝜧ᵣⁱ𝜧ₛʲ(𝜀𝝁ₜ+𝑾ₜᵏ𝜹ᵤ) # 𝒆~𝜀𝝁+𝑾𝜹'
   ~ 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ) + 𝜀𝜧ᵣⁱ𝜧ₛʲ𝝁ₜ + 𝜧ᵣⁱ𝜧ₛʲ𝑾ₜᵏ𝜹ᵤ
   ~ 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ + 𝜧ᵣⁱ𝜧ₛʲ𝝁ₜ) + 𝜧ᵣⁱ𝜧ₛʲ𝑾ₜᵏ𝜹ᵤ
# For level three, 𝜹ᵤ is zero:
𝒆ᵣ ~ 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ + 𝜧ᵣⁱ𝜧ₛʲ𝝁ₜ)
```
### General propagation of errors
```korekto
# The above establishes a clear pattern:
𝒆ᵣ ~ 𝜀(𝝁ᵣ + 𝜧ᵣⁱ𝝁ₛ + 𝜧ᵣⁱ𝜧ₛʲ𝝁ₜ + 𝜧ᵣⁱ𝜧ₛʲ𝜧ₜᵏ𝝁ᵤ + ...)
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
