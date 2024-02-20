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

Consider values in collection `𝒂` at level "ₕ" dependent on values in
the collection at level "ᵢ":

* `𝒂ₕ : ⌈(𝒃ₕ + ∑ᵢ(𝑾ₕᵢ * 𝒂ᵢ))`

The index `ₕ` enumerates values of `𝒂` in level "ₕ", whereas `ᵢ` enumerates
values of `𝒂` in level "ᵢ".  The levels are labeled alphabetically:

* `{⋯ ₕ ᵢ ⱼ ₖ ⋯}`

I'll want to express the relation between levels without specifying the level.
Given the above, please allow:

* `𝒂 = ⌈(𝒃 + 𝑾 𝒂₊)`
* `𝒂 = ⌈ 𝒃+𝑾(𝒂₊)`
* `𝒂 = ⌈ 𝒃+𝑾𝒂₊`

The next level operator `₊` shifts the (context)label to the next level.

* `𝒂ₕ₊ : 𝒂ᵢ`

## Korekto Math

The following is written in [Korekto](https://github.com/carlosjhr64/korekto)
code blocks. I will be importing [KorektoMath](../imports/KorektoMath.md).

### Introductions
```korekto
< imports/KorektoMath.md
? length < 50
# Euler's constant 𝖊 ~ 2.718⋯
𝖊 : ∑ₙ 1/𝑛!	#S90.KorektoMath/L1.KorektoMath ≝: 𝖊
# Scalar variable 𝑥 to help define functions
Scalar[𝑥]	#S73.KorektoMath/L21.KorektoMath Scalar: 𝑥
# The labeled activation layer vector 𝒂
Vector[𝒂]	#S1/L22.KorektoMath Vector: 𝒂
# The labeled bias vector 𝒃
Vector[𝒃]	#S2/L22.KorektoMath Vector: 𝒃
# The multi-labeled weights matrix 𝑾
Tensor[𝑾]	#S3/L23.KorektoMath Tensor: 𝑾
# Labels
Contravariant{ʰ ⁱ ʲ ᵏ}	#S4/L4.KorektoMath Named set: Contravariant ʰ ⁱ ʲ ᵏ
Covariant{ₕ ᵢ ⱼ ₖ}	#S5/L4.KorektoMath Named set: Covariant ₕ ⱼ ₖ
# Next labels
ₕ₊ = ᵢ	#R6/M7.KorektoMath,S5 Next
ᵢ₊ = ⱼ	#R7/M7.KorektoMath,S5 Next
ⱼ₊ = ₖ	#R8/M7.KorektoMath,S5 Next
# Raised labels
ₕ⭎ = ʰ	#C9/I11.KorektoMath,S5,S4 →1st
ᵢ⭎ = ⁱ	#C10/I12.KorektoMath,S5,S4 →2nd
ⱼ⭎ = ʲ	#C11/I13.KorektoMath,S5,S4 →3rd
ₖ⭎ = ᵏ	#C12/I14.KorektoMath,S5,S4 →4th
# Natural Exponentiation and Logarythm
𝖊∧𝑥 : 𝖊ˣ	#S13/L1.KorektoMath ≝: ˣ
𝖊𝓵𝖊ˣ = 𝑥	#R14/M40.KorektoMath,S13 ∧→𝓵
# Exp and Log are inverses of eachother
𝖊𝓵(𝖊ˣ) = 𝑥	#R15/M98.KorektoMath,R14 a → (a)
𝖊𝓵(𝖊∧𝑥) = 𝑥	#C16/I215.KorektoMath,S13,R15 G=F,(F)→(G)
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
⌉0 = 𝖊∧(𝑥 - 𝑥)	#C24/I215.KorektoMath,T23,R22 G=F,(F)→(G)
⌉0 = 𝖊∧(𝑥 + -𝑥)	#R25/M223.KorektoMath,C24 a-b=a+-b
⌉0 = 𝖊∧𝑥*𝖊∧-𝑥	#R26/M226.KorektoMath,R25 a^(b+c)=a^b*a^c
⌉0 = (𝖊∧𝑥)*(𝖊∧-𝑥)	#R27/M162.KorektoMath,R26 a^b~c^d → (a^b)~(c^c)
# Then:
𝖊∧-𝑥 = 1 / 𝖊∧𝑥	#T28/A36.KorektoMath Reciprical
⌉0 = (𝖊∧𝑥)*(1 / 𝖊∧𝑥)	#C29/I214.KorektoMath,T28,R27 G=F,(G)→(F)
⌉0 = (𝖊∧𝑥)*(1 / (𝖊∧𝑥))	#R30/M142.KorektoMath,C29 _g)→_(g))
⌉0 = ((𝖊∧𝑥) / (𝖊∧𝑥))	#R31/M191.KorektoMath,R30 x*(1/y) → (x/y)
⌉0 = 1	#R32/M171.KorektoMath,R31 (a/a)→1
# Prove ⌉𝑥⌉-𝑥 = 1
⌉𝑥⌉-𝑥 = ⌉𝑥⌉-𝑥	#T33/A166.KorektoMath Reflection
⌉𝑥⌉-𝑥 = ⌉𝑥*⌉-𝑥	#R34/M163.KorektoMath,T33 Explicit*
⌉𝑥⌉-𝑥 = (⌉𝑥)*(⌉-𝑥)	#R35/M100.KorektoMath,R34 a~b → (a)~(b)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(⌉-𝑥)	#C36/I214.KorektoMath,T20,R35 G=F,(G)→(F)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(⌉(-𝑥))	#R37/M98.KorektoMath,C36 a → (a)
⌉(-𝑥) = 𝖊∧(-𝑥)	#T38/A91.KorektoMath Exp
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(𝖊∧(-𝑥))	#C39/I214.KorektoMath,T38,R37 G=F,(G)→(F)
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
⌊(⌉(𝑥)) = 𝑥	#C49/I215.KorektoMath,T48,C47 G=F,(F)→(G)
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
⌈𝑥 = 1 / 1+⌉-𝑥	#T58/A232.KorektoMath Squash
⌈𝑥 = 1 / (1 + ⌉-𝑥)	#R59/M107.KorektoMath,T58 _a+b$ → ♭(a♭+♭b)$
# Alternate
⌈𝑥 = ⌉𝑥*1 / ⌉𝑥*(1 + ⌉-𝑥)	#R60/M186.KorektoMath,R59 _x*a_/_x*b$
⌈𝑥 = ⌉𝑥 / ⌉𝑥*(1 + ⌉-𝑥)	#R61/M173.KorektoMath,R60 *1_
⌈𝑥 = ⌉𝑥 / (⌉𝑥*1 + ⌉𝑥*⌉-𝑥)	#R62/M197.KorektoMath,R61 (x*a♭±♭x*b)
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + ⌉𝑥*⌉-𝑥)	#R63/M173.KorektoMath,R62 *1_
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + ⌉𝑥⌉-𝑥)	#R64/M164.KorektoMath,R63 Implied*
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + 1)	#C65/I203.KorektoMath,C42,R64 g=a,_g)→_a)
⌈𝑥 = ⌉𝑥 / (1 + ⌉𝑥)	#R66/M227.KorektoMath,C65 (a+b)→(b+a)
⌈𝑥 = ⌉𝑥 / 1+⌉𝑥	#R67/M106.KorektoMath,R66 ♭(a♭+♭b)$ → _a+b$
⌈𝓍 = ⌉𝓍 / 1+⌉𝓍	#A68/R67 Alternate Squash
# Equivalence 1-⌈𝑥 = ⌈-𝑥
1-⌈𝑥 = 1-⌈𝑥	#T69/A166.KorektoMath Reflection
1-⌈𝑥 = 1 - ⌈𝑥	#R70/M156.KorektoMath,T69 +_g+f$ → +_g_+_f$
1-⌈𝑥 = 1 - (⌉𝑥 / 1+⌉𝑥)	#C71/I210.KorektoMath,R67,R70 a=G,a→(G)
1-⌈𝑥 = (1+⌉𝑥-⌉𝑥 / 1+⌉𝑥)	#R72/M193.KorektoMath,C71 _1±(a_/_g) → (g±a / g)
1-⌈𝑥 = 1+⌉𝑥-⌉𝑥 / 1+⌉𝑥	#R73/M148.KorektoMath,R72 +_(G)$ → +_G$
1-⌈𝑥 = 1 / 1+⌉𝑥	#R74/M180.KorektoMath,R73 +a-a_
# Cosider ⌈-𝑥
⌈-𝑥 = ⌈-𝑥	#T75/A166.KorektoMath Reflection
⌈-𝑥 = 1 / 1+⌉--𝑥	#T76/A232.KorektoMath Squash
⌈-𝑥 = 1 / 1+⌉𝑥	#R77/M228.KorektoMath,T76 --a→a
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
⌈𝑥+⌈-𝑥 = (1 + ⌈𝑥) - ⌈𝑥	#R87/M227.KorektoMath,R86 (a+b)→(b+a)
⌈𝑥+⌈-𝑥 = 1 + ⌈𝑥 - ⌈𝑥	#R88/M144.KorektoMath,R87 +_(G)_+ → +_G_+
⌈𝑥+⌈-𝑥 = 1	#R89/M178.KorektoMath,R88 +a-a$ → $
# Derivative:
# Label 𝑥
ₓ → 𝑥	#S82.KorektoMath/L74.KorektoMath Map: ₓ
# ₓ → 𝑥;𝓓ₓ𝓐(𝑥) = ...
𝓓ₓ⌈𝑥 = 𝓓ₓ⌈𝑥	#T90/A166.KorektoMath Reflection
𝓓ₓ⌈𝑥 = 𝓓ₓ(⌈𝑥)	#R91/M98.KorektoMath,T90 a → (a)
𝓓ₓ⌈𝑥 = 𝓓ₓ(1 / 1+⌉-𝑥)	#C92/I214.KorektoMath,T58,R91 G=F,(G)→(F)
𝓓ₓ(1 / 1+⌉-𝑥) = -𝓓ₓ⌉-𝑥 / (1+⌉-𝑥)²	#T93/A240.KorektoMath From quotient rule
𝓓ₓ⌈𝑥 = -𝓓ₓ⌉-𝑥 / (1+⌉-𝑥)²	#C94/I218.KorektoMath,T93,C92 G=F, +_G$ → +_F$
# Consider 𝓓ₓ⌉-𝑥
𝓓ₓ⌉-𝑥 = 𝓓ₓ⌉-𝑥	#T95/A166.KorektoMath Reflection
𝓓ₓ⌉-𝑥 = 𝓓ₓ(⌉-𝑥)	#R96/M98.KorektoMath,T95 a → (a)
⌉-𝑥 = 𝖊∧-𝑥	#T97/A91.KorektoMath Exp
𝓓ₓ⌉-𝑥 = 𝓓ₓ(𝖊∧-𝑥)	#C98/I214.KorektoMath,T97,R96 G=F,(G)→(F)
𝓓ₓ(𝖊∧-𝑥) = 𝓓ₓ(-𝑥)𝖊∧-𝑥	#T99/A243.KorektoMath D(e^x)=D(x)e^x
𝓓ₓ⌉-𝑥 = 𝓓ₓ(-𝑥)𝖊∧-𝑥	#C100/I208.KorektoMath,T99,C98 g=f,_g$→_f$
𝓓ₓ⌉-𝑥 = 𝓓ₓ(-𝑥)*𝖊∧-𝑥	#R101/M163.KorektoMath,C100 Explicit*
𝓓ₓ(-𝑥) = -1	#R102/M246.KorektoMath,S82.KorektoMath 𝓓ₓ-𝑥=-1
𝓓ₓ⌉-𝑥 = -1*𝖊∧-𝑥	#C103/I199.KorektoMath,R102,R101 a=b,a→b
𝓓ₓ⌉-𝑥 = -𝖊∧-𝑥	#R104/M174.KorektoMath,C103 _1*
𝓓ₓ⌉-𝑥 = -(𝖊∧-𝑥)	#R105/M160.KorektoMath,R104 a^b → (a^b)
-𝓓ₓ⌉-𝑥 = (𝖊∧-𝑥)	#R106/M229.KorektoMath,R105 a=-b;-a=-b
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
𝓑⌈𝑥 = (1-⌈𝑥)*⌈𝑥	#T122/A234.KorektoMath Binary balance
𝓓ₓ⌈𝑥 = 𝓑⌈𝑥	#C123/I170.KorektoMath,T122,R121 a=b;c=b;c=a
```
### Unsquash
```korekto
# The unsquash function in Ruby is:
#   Math.log(𝑥 / (1 - 𝑥))
# Here  its:
⌋𝑥 = ⌊ 𝑥/(1-𝑥)	#T124/A233.KorektoMath Unsquash
# Show that unsquash is the inverse of squash(⌋⌈=1):
⌋⌈𝑥 = ⌋⌈𝑥	#T125/A166.KorektoMath Reflection
⌋⌈𝑥 = ⌊ ⌈𝑥/(1-⌈𝑥)	#T126/A233.KorektoMath Unsquash
⌊ ⌈𝑥/(1-⌈𝑥) = ⌊⌈𝑥 - ⌊(1-⌈𝑥)	#T127/A231.KorektoMath ⌊(a/b)=⌊a-⌊b
⌋⌈𝑥 = ⌊⌈𝑥 - ⌊(1-⌈𝑥)	#C128/I218.KorektoMath,T127,T126 G=F, +_G$ → +_F$
⌋⌈𝑥 = ⌊(⌈𝑥) - ⌊(1-⌈𝑥)	#R129/M98.KorektoMath,C128 a → (a)
⌈𝑥 = ⌉𝑥 / 1+⌉𝑥	#R67/M106.KorektoMath,R66 ♭(a♭+♭b)$ → _a+b$
⌋⌈𝑥 = ⌊(⌉𝑥 / 1+⌉𝑥) - ⌊(1-⌈𝑥)	#C130/I214.KorektoMath,R67,R129 G=F,(G)→(F)
⌋⌈𝑥 = ⌊ ⌉𝑥/(1+⌉𝑥) - ⌊(1-⌈𝑥)	#R131/M124.KorektoMath,C130 ♭(a_*_g)♭ → _a*(g)_
⌊ ⌉𝑥/(1+⌉𝑥) = ⌊⌉𝑥 - ⌊(1+⌉𝑥)	#T132/A231.KorektoMath ⌊(a/b)=⌊a-⌊b
⌊⌉𝑥 = 𝑥	#R51/M99.KorektoMath,R50 (a) → a
⌊ ⌉𝑥/(1+⌉𝑥) = 𝑥 - ⌊(1+⌉𝑥)	#C133/I199.KorektoMath,R51,T132 a=b,a→b
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊(1-⌈𝑥)	#C134/I220.KorektoMath,C133,R131 G=F, +_G_+ → +_F_+
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1-⌈𝑥	#R135/M106.KorektoMath,C134 ♭(a♭+♭b)$ → _a+b$
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1-(⌈𝑥)	#R136/M98.KorektoMath,R135 a → (a)
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1-(⌉𝑥 / 1+⌉𝑥)	#C137/I214.KorektoMath,R67,R136 G=F,(G)→(F)
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ (1+⌉𝑥-⌉𝑥 / 1+⌉𝑥)	#R138/M193.KorektoMath,C137 _1±(a_/_g) → (g±a / g)
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ (1 / 1+⌉𝑥)	#R139/M180.KorektoMath,R138 +a-a_
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊ 1/(1+⌉𝑥)	#R140/M126.KorektoMath,R139 ♭(a_*_g)$ → _a*(g)$
⌊ 1/(1+⌉𝑥) = ⌊1 - ⌊(1+⌉𝑥)	#T141/A231.KorektoMath ⌊(a/b)=⌊a-⌊b
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊1 - ⌊(1+⌉𝑥)	#C142/I218.KorektoMath,T141,R140 G=F, +_G$ → +_F$
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
ᵢ₊ = ⱼ;𝒂ᵢ = ⌈ 𝒃ᵢ+∑ⱼ(𝑪ᵢⱼ𝒂ⱼ)	#M148 Activation
ₕ₊ = ᵢ	#R6/M7.KorektoMath,S5 Next
𝒂ₕ = ⌈ 𝒃ₕ+∑ᵢ(𝑾ₕᵢ𝒂ᵢ)	#R149/M148,R6 Activation
ᵢ⭎ = ⁱ	#C10/I12.KorektoMath,S5,S4 →2nd
∑ᵢ(𝑾ₕᵢ𝒂ᵢ) = 𝑾ₕⁱ𝒂ᵢ	#R150/M247.KorektoMath,C10 Einstein notation
𝒂ₕ = ⌈ 𝒃ₕ+(𝑾ₕⁱ𝒂ᵢ)	#C151/I210.KorektoMath,R150,R149 a=G,a→(G)
𝒂ₕ = ⌈ 𝒃ₕ+𝑾ₕⁱ𝒂ᵢ	#R152/M132.KorektoMath,C151 *(ab)$ → *ab$
# The above is correct. Now, how to cleanly loose the labels?
𝒂 = ⌈ 𝒃+𝑾𝒂₊	#H153 hide labels
# The value of the h-th Neuron is the unsquashed activation:
⌋𝒂 = ⌋⌈ 𝒃+𝑾𝒂₊	#R154/M230.KorektoMath,H153 x_=_G_g;Fx_=_FG_g
⌋⌈(𝒃+𝑾𝒂₊) = (𝒃+𝑾𝒂₊)	#T155/A146 Inverse
⌋⌈(𝒃+𝑾𝒂₊) = 𝒃+𝑾𝒂₊	#R156/M138.KorektoMath,T155 ♭(g)$ → _g$
⌋⌈ 𝒃+𝑾𝒂₊ = 𝒃+𝑾𝒂₊	#R157/M136.KorektoMath,R156 ♭(g)♭ → _g_
⌋𝒂 = 𝒃+𝑾𝒂₊	#C158/I218.KorektoMath,R157,R154 G=F, +_G$ → +_F$
# Neuron's value
𝒗 : ⌋𝒂	#S159/L1.KorektoMath ≝: 𝒗
# Shrunk 𝒗
ₕ⭎ = ʰ	#C9/I11.KorektoMath,S5,S4 →1st
ᵢ⭎ = ⁱ	#C10/I12.KorektoMath,S5,S4 →2nd
𝒗 = 𝒃+𝑾𝒂₊	#C160/I167.KorektoMath,S159,C158 a=b;b=c;a=c
# Explicit 𝒗
𝒗ₕ = 𝒃ₕ+𝑾ʰⁱ𝒂ᵢ	#H161
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
𝒗ₕ := ⌋(𝒂ₕ)
𝒗 = ⌋𝒂
# Error in output value from errors in bias and weights:
𝒗ₕ + 𝒆ₕ := (𝒃ₕ + 𝜺ₕ) + ∑ᵢ((𝑾ₕᵢ + 𝜺ᵢ) * 𝒂ᵢ)
𝒗+𝒆 = 𝒃+𝜺 + (𝑾+𝜺')𝒂'
𝒆 = 𝒃+𝜺 + (𝑾+𝜺')𝒂'- 𝒗
𝒆 = 𝒃 + 𝜺 + 𝑾𝒂' + 𝜺'𝒂' - 𝒗
𝒆 = 𝜺 + 𝜺'𝒂' + (𝒃 + 𝑾𝒂') - 𝒗
𝒆 = 𝜺 + 𝜺'𝒂' + (𝒗) - 𝒗
𝒆 = 𝜺 + 𝜺'𝒂'
𝒆ₕ = 𝜺ₕ + 𝜺ⁱ𝒂ᵢ
𝒆ₕ = 𝜺ₕ + ∑ᵢ(𝜺ᵢ * 𝒂ᵢ)
# Assume equipartition of errors:
∀ₓ{ 𝜺ₓ = 𝜀 }
𝒆ₕ = 𝜺ₕ + ∑ᵢ(𝜺ᵢ * 𝒂ᵢ)
   = 𝜀 + ∑ᵢ(𝜀 * 𝒂ᵢ)
   = 𝜀 + 𝜀∑𝒂ᵢ
   = 𝜀(1 + ∑𝒂ᵢ)
𝒆ₕ = 𝜀 * (1 + ∑ᵢ(𝒂ᵢ))
# *** Equipartitioned error level one ***
# Solve for 𝜀:
𝜀 = 𝒆ₕ / 1+∑𝒂ᵢ
𝜀 = 𝒆ₕ / (1 + ∑ᵢ(𝒂ᵢ))
# Mu
𝝁ₕ := 1 + ∑ᵢ(𝒂ᵢ)
𝝁 = 1+∑𝒂'
𝜀 = 𝒆ₕ / 𝝁ₕ
𝜀 = 𝒆/𝝁
𝒆 = 𝜀𝝁
𝒆ₕ = 𝜀 * 𝝁ₕ
# As an estimate, set 𝒂~½ and the length of ∑ᵢ at 𝑁:
𝜀 ~ 𝒆 / (1 + ½𝑁)
# Or very roughly:
𝜀 ~ 2𝒆/𝑁
# Activation error
𝒂ₕ + 𝜹ₕ = ⌈(𝒗ₕ + 𝒆ₕ)
𝒂+𝜹 = ⌈ 𝒗+𝒆
    ~ ⌈𝒗 + 𝒆𝓓𝒗⌈𝒗
    ~ ⌈𝒗 + 𝒆𝓑⌈𝒗
    ~ ⌈𝒗 + 𝒆𝓑𝒂
𝒂ₕ + 𝜹ₕ ~ 𝒂ₕ + (𝒆ₕ * 𝓑(𝒂ₕ))
        ~ 𝒂ₕ + (𝒆ₕ * (1 - 𝒂ₕ) * 𝒂ₕ)
𝜹ₕ ~ 𝒆ₕ * (1 - 𝒂ₕ) * 𝒂ₕ
   ~ 𝒆ₕ * 𝓑(𝒂ₕ)
𝜹 ~ 𝒆𝓑𝒂
  ~ 𝒆(1-𝒂)𝒂
# Recall that 𝒆=𝜀𝝁:
𝜹 ~ 𝜀𝝁(1-𝒂)𝒂
  ~ 𝜀𝝁𝓑𝒂
𝜹ₕ ~ 𝜀 * 𝝁ₕ * 𝓑(𝒂ₕ)
   ~ 𝜀 * 𝝁ₕ * (1 - 𝒂ₕ) * 𝒂ₕ
```
### Vanishing small errors
```korekto
# Assume 𝜀²~0
𝜀² ~ 0
# Consider 𝜀𝜹
𝜀 * 𝜹ₕ = 𝜀 * 𝜀 * 𝝁ₕ * 𝓑(𝒂ₕ)
       = 𝜀²𝝁𝓑𝒂
       ~ 0 * 𝝁𝓑𝒂
𝜀𝜹 ~ 0
𝜀 * 𝜹ₕ ~ 0
```
### Propagation of errors level 2
```korekto
# Error in ouput value from errors in bias and weights and activation:
𝒗ₕ + 𝒆ₕ := (𝒃ₕ + 𝜺ₕ) + ∑ᵢ((𝑾ₕᵢ + 𝜺ᵢ) * (𝒂ᵢ + 𝜹ᵢ))
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
𝜧ₕⁱ𝝁ᵢ := ∑ᵢ 𝑾ₕᵢ𝓑𝒂ᵢ𝝁ᵢ
𝜧 𝝁' = 𝑾 𝓑𝒂'𝝁'
# Substitute in 𝜧 :
𝒆 ~ 𝜀(𝝁 + 𝑾 𝓑𝒂'𝝁') + 𝑾 𝓑𝒂'𝑾'𝜹"
  ~ 𝜀(𝝁 + 𝜧 𝝁') + 𝜧 𝑾'𝜹"
# *** Equipartitioned error level two ***
# For level two, 𝜹"=0
𝒆 ~ 𝜀(𝝁 + 𝜧 𝝁')
𝒆ₕ ~ 𝜀 * (𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ)
# Solve for 𝜀:
𝜀 ~ 𝒆 / (𝝁 + 𝜧 𝝁')
𝜀ₕ ~ 𝒆ₕ / (𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ)
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
𝒗ₕ := 𝒃ₕ + ∑ᵢ(𝑾ₕᵢ * 𝒂ᵢ)
𝒗ₕ + 𝒆ₕ := (𝒃ₕ + 𝜺ₕ) + ∑ᵢ((𝑾ₕᵢ + 𝜺ᵢ) * (𝒂ᵢ + 𝜹ᵢ))
𝒗ᵢ + 𝒆ᵢ := (𝒃ᵢ + 𝜺ᵢ) + ∑ⱼ((𝑾ᵢⱼ + 𝜺ⱼ) * (𝒂ⱼ + 𝜹ⱼ))
𝒂ᵢ + 𝜹ᵢ := ⌈(𝒗ᵢ + 𝒆ᵢ)
        = ⌈((𝒃ᵢ + 𝜺ᵢ) + ∑ⱼ((𝑾ᵢⱼ + 𝜺ⱼ) * (𝒂ⱼ + 𝜹ⱼ)))
        = ⌈(𝒃ᵢ + 𝜺ᵢ + ∑ⱼ(𝑾ᵢⱼ*𝒂ⱼ + 𝜺ⱼ*𝒂ⱼ + 𝑾ᵢⱼ*𝜹ⱼ + 𝜺ⱼ*𝜹ⱼ))
        = ⌈(𝒃ᵢ + 𝜺ᵢ + 𝑾ᵢʲ𝒂ⱼ + 𝜺ʲ𝒂ⱼ + 𝑾ᵢʲ𝜹ⱼ + 𝜺ʲ𝜹ⱼ)
        = ⌈(𝒃ᵢ + 𝜺ᵢ + 𝑾ᵢʲ𝒂ⱼ + 𝜺ʲ𝒂ⱼ + 𝑾ᵢʲ𝜹ⱼ) # 𝜺𝜹  vanishes
        = ⌈(𝒃ᵢ + 𝑾ᵢʲ𝒂ⱼ + 𝜺ᵢ + 𝜺ʲ𝒂ⱼ + 𝑾ᵢʲ𝜹ⱼ)
        = ⌈(𝒃ᵢ + 𝑾ᵢʲ𝒂ⱼ + 𝜀 + 𝜀∑𝒂ⱼ + 𝑾ᵢʲ𝜹ⱼ) # All 𝜺 are the same 𝜀
        = ⌈(𝒃ᵢ + 𝑾ᵢʲ𝒂ⱼ + 𝜀(1 + ∑𝒂ⱼ) + 𝑾ᵢʲ𝜹ⱼ)
        = ⌈(𝒃ᵢ + 𝑾ᵢʲ𝒂ⱼ + 𝜀𝝁ᵢ + 𝑾ᵢʲ𝜹ⱼ) # 𝝁ᵢ=1+∑𝒂ⱼ as 𝝁=1+∑𝒂'
        ~ 𝒂ᵢ + (𝜀𝝁ᵢ + 𝑾ᵢʲ𝜹ⱼ) 𝓑𝒂ᵢ
        ~ 𝒂ᵢ + (𝜀𝝁ᵢ + 𝑾ᵢʲ𝜹ⱼ)(1-𝒂ᵢ)𝒂ᵢ
𝒂ᵢ + 𝜹ᵢ ~ 𝒂ᵢ + (𝜀𝝁ᵢ + ∑ⱼ(𝑾ᵢⱼ * 𝜹ⱼ)) * (1 - 𝒂ᵢ) * 𝒂ᵢ
# Solve for 𝜹ᵢ:
𝜹ᵢ ~ (𝜀𝝁ᵢ + ∑ⱼ(𝑾ᵢⱼ * 𝜹ⱼ)) * (1 - 𝒂ᵢ) * 𝒂ᵢ
𝜹ᵢ ~ (𝜀𝝁ᵢ+𝑾ᵢʲ𝜹ⱼ)(1-𝒂ᵢ)𝒂ᵢ
𝜹ᵢ ~ 𝜀𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ + 𝑾ᵢʲ𝜹ⱼ(1-𝒂ᵢ)𝒂ᵢ
# Consider the case where the j-th level is error free input:
𝜹ᵢ ~ 𝜀𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ # 𝜹ⱼ is zero
𝒗ₕ + 𝒆ₕ := (𝒃ₕ + 𝜺ₕ) + ∑ᵢ((𝑾ₕᵢ + 𝜺ᵢ) * (𝒂ᵢ + 𝜹ᵢ))
        ~ (𝒃ₕ + 𝜺ₕ) + ∑ᵢ((𝑾ₕᵢ + 𝜺ᵢ) * (𝒂ᵢ + 𝜀𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ))
        ~ 𝒃ₕ + 𝜺ₕ + 𝑾ₕⁱ(𝒂ᵢ + 𝜀𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ) + 𝜺ⁱ(𝒂ᵢ + 𝜀𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ)
        ~ 𝒃ₕ + 𝜺ₕ + 𝑾ₕⁱ𝒂ᵢ + 𝜀𝑾ₕⁱ𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ + 𝜺ⁱ𝒂ᵢ + 𝜺ⁱ𝜀𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ
        ~ 𝒃ₕ + 𝜺ₕ + 𝑾ₕⁱ𝒂ᵢ + 𝜀𝑾ₕⁱ𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ + 𝜺ⁱ𝒂ᵢ # 𝜺ⁱ𝜀 vanishes
        ~ 𝒃ₕ + 𝑾ₕⁱ𝒂ᵢ + 𝜀𝑾ₕⁱ𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ + 𝜺ₕ + 𝜺ⁱ𝒂ᵢ # reordered terms
        ~ 𝒗ₕ + 𝜀𝑾ₕⁱ𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ + 𝜺ₕ + 𝜺ⁱ𝒂ᵢ
        ~ 𝒗ₕ + 𝜀𝑾ₕⁱ𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ + 𝜀(1+∑𝒂ᵢ)
        ~ 𝒗ₕ + 𝜀(1+∑𝒂ᵢ) + 𝜀𝑾ₕⁱ𝝁ᵢ(1-𝒂ᵢ)𝒂ᵢ # reordered
        ~ 𝒗ₕ + 𝜀𝝁ₕ + 𝜀𝜧ₕⁱ𝝁ᵢ # 𝜧 = 𝑾𝓑𝒂'
𝒗ₕ + 𝒆ₕ ~ 𝒗ₕ + 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ)
𝒆ₕ ~ 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ)
𝜀 ~ 𝒆ₕ / (𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ)
𝜀 ~ 𝒆 / (𝝁 + 𝜧 𝝁') # OK!
```
### Explicit propagation of errors level 3
```korekto
# Given:
𝒂ₕ := ⌈(𝒗ₕ)
𝒂ₕ + 𝜹ₕ := ⌈(𝒗ₕ + 𝒆ₕ)
𝒗ₕ := 𝒃ₕ + ∑ᵢ(𝑾ₕᵢ * 𝒂ᵢ)
𝒗ₕ + 𝒆ₕ := (𝒃ₕ + 𝜺ₕ) + ∑ᵢ((𝑾ₕᵢ + 𝜺ᵢ) * (𝒂ᵢ + 𝜹ᵢ))
𝝁ₕ := 1 + ∑ᵢ(𝒂ᵢ)
𝜧ₕⁱ𝝁ᵢ := ∑ᵢ(𝑾ₕᵢ * (1 - 𝒂ᵢ) * 𝒂ᵢ * 𝝁ᵢ)
       = 𝑾ₕⁱ𝓑𝒂ᵢ𝝁ᵢ
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
ₕ⬌ᵢ⬌ⱼ⬌ₖ
# Solve for level 3 𝜀.
## 𝜹ᵢ:
𝒂ᵢ + 𝜹ᵢ := ⌈(𝒗ᵢ + 𝒆ᵢ)
        ~ ⌈𝒗ᵢ + 𝒆ᵢ * 𝓑⌈𝒗ᵢ
        ~ 𝒂ᵢ + 𝒆ᵢ * 𝓑⌈𝒗ᵢ
𝜹ᵢ ~ 𝒆ᵢ * 𝓑⌈𝒗ᵢ
   ~ 𝒆ᵢ * 𝓑𝒂ᵢ
𝜹ᵢ ~ 𝒆ᵢ * (1-𝒂ᵢ) * 𝒂ᵢ
## Expand first level and solve for 𝒆ₕ:
𝒗ₕ + 𝒆ₕ := (𝒃ₕ + 𝜺ₕ) + ∑ᵢ((𝑾ₕᵢ + 𝜺ᵢ) * (𝒂ᵢ + 𝜹ᵢ))
        = 𝒃ₕ+𝜀 + (𝑾ₕⁱ+𝜺ⁱ)(𝒂ᵢ+𝜹ᵢ)
        = 𝒃ₕ+𝜀 + 𝑾ₕⁱ𝒂ᵢ + 𝜺ⁱ𝒂ᵢ + 𝑾ₕⁱ𝜹ᵢ + 𝜺ⁱ𝜹ᵢ
        ~ 𝒃ₕ+𝜀 + 𝑾ₕⁱ𝒂ᵢ + 𝜺ⁱ𝒂ᵢ + 𝑾ₕⁱ𝜹ᵢ # 𝜺𝜹 vanishes
        ~ 𝒃ₕ+𝑾ₕⁱ𝒂ᵢ + 𝜀+𝜺ⁱ𝒂ᵢ + 𝑾ₕⁱ𝜹ᵢ
        ~ 𝒗ₕ + 𝜀+𝜺ⁱ𝒂ᵢ + 𝑾ₕⁱ𝜹ᵢ
𝒆ₕ ~ 𝜀+𝜺ⁱ𝒂ᵢ + 𝑾ₕⁱ𝜹ᵢ
   ~ 𝜀(1+∑𝒂ᵢ) + 𝑾ₕⁱ𝜹ᵢ
   ~ 𝜀𝝁ₕ + 𝑾ₕⁱ𝜹ᵢ
## Substitute out 𝜹ᵢ:
𝒆ₕ ~ 𝜀𝝁ₕ + 𝑾ₕⁱ𝜹ᵢ # 𝒆=𝜀𝝁+𝑾𝜹'
   ~ 𝜀𝝁ₕ + 𝑾ₕⁱ𝒆ᵢ𝓑𝒂ᵢ
   ~ 𝜀𝝁ₕ + 𝑾ₕⁱ𝓑𝒂ᵢ𝒆ᵢ
## Substitute out 𝒆ᵢ:
𝒆ₕ ~ 𝜀𝝁ₕ + 𝑾ₕⁱ𝓑𝒂ᵢ𝒆ᵢ
   ~ 𝜀𝝁ₕ + 𝑾ₕⁱ𝓑𝒂ᵢ(𝜀𝝁ᵢ + 𝑾ᵢʲ𝜹ⱼ) # 𝒆~𝜀𝝁+𝑾𝜹'
   ~ 𝜀𝝁ₕ + 𝑾ₕⁱ𝓑𝒂ᵢ𝜀𝝁ᵢ + 𝑾ₕⁱ𝓑𝒂ᵢ𝑾ᵢʲ𝜹ⱼ
   ~ 𝜀𝝁ₕ + 𝜀𝑾ₕⁱ𝓑𝒂ᵢ𝝁ᵢ + 𝑾ₕⁱ𝓑𝒂ᵢ𝑾ᵢʲ𝜹ⱼ # reorder
   ~ 𝜀𝝁ₕ + 𝜀𝜧ₕⁱ𝝁ᵢ + 𝜧ₕⁱ𝑾ᵢʲ𝜹ⱼ # 𝜧 =𝑾𝓑𝒂'
𝒆ₕ ~ 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ) + 𝜧ₕⁱ𝑾ᵢʲ𝜹ⱼ # Level 2 plus an additional term due to 𝜹ⱼ
# Recall that in level 2, 𝜹ⱼ was zero, but level three continues...
𝒆ₕ ~ 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ) + 𝜧ₕⁱ𝑾ᵢʲ𝜹ⱼ
   ~ 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ) + 𝜧ₕⁱ𝑾ᵢʲ𝓑𝒂ⱼ𝒆ⱼ # 𝜹~𝓑𝒂𝒆
   ~ 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ) + 𝜧ₕⁱ𝜧ᵢʲ𝒆ⱼ
   ~ 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ) + 𝜧ₕⁱ𝜧ᵢʲ(𝜀𝝁ⱼ+𝑾ⱼᵏ𝜹ₖ) # 𝒆~𝜀𝝁+𝑾𝜹'
   ~ 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ) + 𝜀𝜧ₕⁱ𝜧ᵢʲ𝝁ⱼ + 𝜧ₕⁱ𝜧ᵢʲ𝑾ⱼᵏ𝜹ₖ
   ~ 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ + 𝜧ₕⁱ𝜧ᵢʲ𝝁ⱼ) + 𝜧ₕⁱ𝜧ᵢʲ𝑾ⱼᵏ𝜹ₖ
# For level three, 𝜹ₖ is zero:
𝒆ₕ ~ 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ + 𝜧ₕⁱ𝜧ᵢʲ𝝁ⱼ)
```
### General propagation of errors
```korekto
# The above establishes a clear pattern:
𝒆ₕ ~ 𝜀(𝝁ₕ + 𝜧ₕⁱ𝝁ᵢ + 𝜧ₕⁱ𝜧ᵢʲ𝝁ⱼ + 𝜧ₕⁱ𝜧ᵢʲ𝜧ⱼᵏ𝝁ₖ + ...)
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
