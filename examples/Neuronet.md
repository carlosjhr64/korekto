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
# Types
## Euler's constant 𝖊 ~ 2.718⋯
𝖊 : ∑ₙ 1/𝑛!	#S86.KorektoMath/L1.KorektoMath ≝: 𝖊
## Scalar variable 𝑥 to help define functions
Scalar[𝑥]	#S1/L21.KorektoMath Scalar: 𝑥
## The labeled activation layer vector 𝒂
Vector[𝒂]	#S2/L22.KorektoMath Vector: 𝒂
## The labeled bias vector 𝒃
Vector[𝒃]	#S3/L22.KorektoMath Vector: 𝒃
## The multi-labeled weights matrix 𝑾
Tensor[𝑾]	#S4/L23.KorektoMath Tensor: 𝑾
## Labels
Contravariant{ʰ ⁱ ʲ ᵏ}	#S5/L4.KorektoMath Named set: Contravariant ʰ ⁱ ʲ ᵏ
Covariant{ₕ ᵢ ⱼ ₖ}	#S6/L4.KorektoMath Named set: Covariant ₕ ⱼ ₖ
## Next labels
ₕ₊ = ᵢ	#R7/M7.KorektoMath,S6 Next
ᵢ₊ = ⱼ	#R8/M7.KorektoMath,S6 Next
ⱼ₊ = ₖ	#R9/M7.KorektoMath,S6 Next
## Raised labels
ₕ⁺ = ʰ	#C10/I11.KorektoMath,S6,S5 →1st
ᵢ⁺ = ⁱ	#C11/I12.KorektoMath,S6,S5 →2nd
ⱼ⁺ = ʲ	#C12/I13.KorektoMath,S6,S5 →3rd
ₖ⁺ = ᵏ	#C13/I14.KorektoMath,S6,S5 →4th
# Functions
## Natural Exponentiation and Logarythm
### 𝖊ˣ
𝖊∧𝑥 : 𝖊ˣ	#S14/L1.KorektoMath ≝: ˣ
𝖊𝓵𝖊ˣ = 𝑥	#R15/M40.KorektoMath,S14 ∧→𝓵
### Exp and Log are inverses of eachother
𝖊𝓵(𝖊ˣ) = 𝑥	#R16/M94.KorektoMath,R15 a → (a)
𝖊𝓵(𝖊∧𝑥) = 𝑥	#C17/I192.KorektoMath,S14,R16 (a)=(b),(b)→(a)
𝖊𝓵(𝖊∧(𝑥)) = 𝑥	#R18/M94.KorektoMath,C17 a → (a)
𝖊𝓵(𝖊∧(𝓍)) = 𝓍	#A19/R18 Inverses 𝓵∧
# Likewise:
𝖊∧(𝖊𝓵(𝓍)) = 𝓍	#A20 Inverses ∧𝓵
```
### Natural exponentiation function
```korekto
# In Ruby, the natural exponentiation function is:
#     Math.exp(x) == Math::E**x #=> true
# Here its:
⌉𝑥 = 𝖊∧𝑥	#T21/A87.KorektoMath Exp
# Prove ⌉0 = 𝖊∧0 = 1
⌉0 = 𝖊∧0	#T22/A87.KorektoMath Exp
⌉0 = 𝖊∧(0)	#R23/M94.KorektoMath,T22 a → (a)
𝑥 - 𝑥 = 0	#T24/A27.KorektoMath Zero
⌉0 = 𝖊∧(𝑥 - 𝑥)	#C25/I192.KorektoMath,T24,R23 (a)=(b),(b)→(a)
⌉0 = 𝖊∧(𝑥 + -𝑥)	#R26/M198.KorektoMath,C25 a-b=a+-b
⌉0 = 𝖊∧𝑥*𝖊∧-𝑥	#R27/M201.KorektoMath,R26 a^(b+c)=a^b*a^c
⌉0 = (𝖊∧𝑥)*(𝖊∧-𝑥)	#R28/M146.KorektoMath,R27 a^b~c^d → (a^b)~(c^c)
# Then:
𝖊∧-𝑥 = 1 / 𝖊∧𝑥	#T29/A36.KorektoMath Reciprical
⌉0 = (𝖊∧𝑥)*(1 / 𝖊∧𝑥)	#C30/I191.KorektoMath,T29,R28 (a)=(b),(a)→(b)
⌉0 = (𝖊∧𝑥)*(1 / (𝖊∧𝑥))	#R31/M126.KorektoMath,C30 _a)→_(a))
⌉0 = ((𝖊∧𝑥) / (𝖊∧𝑥))	#R32/M172.KorektoMath,R31 x*(1/y) → (x/y)
⌉0 = (1)	#R33/M155.KorektoMath,R32 (a/a)→(1)
⌉0 = 1	#R34/M95.KorektoMath,R33 (a) → a
# Prove ⌉𝑥⌉-𝑥 = 1
⌉𝑥⌉-𝑥 = ⌉𝑥⌉-𝑥	#T35/A150.KorektoMath Reflection
⌉𝑥⌉-𝑥 = ⌉𝑥*⌉-𝑥	#R36/M147.KorektoMath,T35 Explicit*
⌉𝑥⌉-𝑥 = (⌉𝑥)*(⌉-𝑥)	#R37/M96.KorektoMath,R36 a~b → (a)~(b)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(⌉-𝑥)	#C38/I191.KorektoMath,T21,R37 (a)=(b),(a)→(b)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(⌉(-𝑥))	#R39/M94.KorektoMath,C38 a → (a)
⌉(-𝑥) = 𝖊∧(-𝑥)	#T40/A87.KorektoMath Exp
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(𝖊∧(-𝑥))	#C41/I191.KorektoMath,T40,R39 (a)=(b),(a)→(b)
⌉𝑥⌉-𝑥 = (𝖊∧𝑥)*(𝖊∧-𝑥)	#R42/M95.KorektoMath,C41 (a) → a
⌉𝑥⌉-𝑥 = ⌉0	#C43/I153.KorektoMath,R42,R28 a=b;c=b;a=c
⌉𝑥⌉-𝑥 = 1	#C44/I151.KorektoMath,C43,R34 a=b;b=c;a=c
# Abstract
⌉𝓍⌉-𝓍 = 1	#A45/C44 ⌉𝑥⌉-𝑥=1
⌉-𝓍⌉𝓍 = 1	#A46 ⌉-𝑥⌉𝑥=1
```
### Natural logarithm function
```korekto
# In Ruby, the natural log funtion is:
#     y = Math.exp(x)
#     Math.log(y) == x #=> true
# Here its:
⌊𝑥 = 𝖊𝓵𝑥	#T47/A88.KorektoMath Log
# So we can contract the inverse relation
𝖊𝓵(𝖊∧(𝑥)) = 𝑥	#R18/M94.KorektoMath,C17 a → (a)
⌊(𝖊∧(𝑥)) = 𝖊𝓵(𝖊∧(𝑥))	#T48/A88.KorektoMath Log
⌊(𝖊∧(𝑥)) = 𝑥	#C49/I151.KorektoMath,T48,R18 a=b;b=c;a=c
⌉(𝑥) = 𝖊∧(𝑥)	#T50/A87.KorektoMath Exp
⌊(⌉(𝑥)) = 𝑥	#C51/I192.KorektoMath,T50,C49 (a)=(b),(b)→(a)
⌊(⌉𝑥) = 𝑥	#R52/M95.KorektoMath,C51 (a) → a
⌊⌉𝑥 = 𝑥	#R53/M95.KorektoMath,R52 (a) → a
⌊⌉𝓍 = 𝓍	#A54/R53 ⌊⌉=1
# Likewise
⌉⌊𝓍 = 𝓍	#A55 ⌉⌊=1
# If 𝖊∧0 = 1, then 𝖊𝓵1 = 0 by definition of 𝓵
⌊1 = 𝖊𝓵1	#T56/A88.KorektoMath Log
𝖊∧0 = 1	#T57/A35.KorektoMath x∧0=1
𝖊𝓵1 = 0	#R58/M40.KorektoMath,T57 ∧→𝓵
⌊1 = 0	#C59/I185.KorektoMath,R58,T56 a=b,_a$→_b$
```
### Squash
```korekto
# The squash function in Ruby is:
#     1 / (1 + Math.exp(-𝑥))
# Here its:
⌈𝓍 = 1 / 1+⌉-𝓍	#A60 Squash: ⌈
⌈𝑥 = 1 / 1+⌉-𝑥	#T61/A60 Squash
⌈𝑥 = 1 / (1 + ⌉-𝑥)	#R62/M103.KorektoMath,T61 _a+b$ → ♭(a♭+♭b)$
# Alternate
⌈𝑥 = (1) / (1 + ⌉-𝑥)	#R63/M94.KorektoMath,R62 a → (a)
⌈𝑥 = ⌉𝑥*(1) / ⌉𝑥*(1 + ⌉-𝑥)	#R64/M169.KorektoMath,R63 _x*a_/_x*b$
⌈𝑥 = ⌉𝑥 / ⌉𝑥*(1 + ⌉-𝑥)	#R65/M159.KorektoMath,R64 *(1)_
⌈𝑥 = ⌉𝑥 / (⌉𝑥*1 + ⌉𝑥*⌉-𝑥)	#R66/M176.KorektoMath,R65 (x*a♭±♭x*b)
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + ⌉𝑥*⌉-𝑥)	#R67/M157.KorektoMath,R66 *1_
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + ⌉𝑥⌉-𝑥)	#R68/M148.KorektoMath,R67 Implied*
⌈𝑥 = ⌉𝑥 / (⌉𝑥 + 1)	#C69/I180.KorektoMath,C44,R68 g=a,_g)→_a)
⌈𝑥 = ⌉𝑥 / (1 + ⌉𝑥)	#R70/M202.KorektoMath,C69 (a+b)→(b+a)
⌈𝑥 = ⌉𝑥 / 1+⌉𝑥	#R71/M102.KorektoMath,R70 ♭(a♭+♭b)$ → _a+b$
⌈𝓍 = ⌉𝓍 / 1+⌉𝓍	#A72/R71 Alternate Squash
# Equivalence 1-⌈𝑥 = ⌈-𝑥
1-⌈𝑥 = 1-⌈𝑥	#T73/A150.KorektoMath Reflection
1-⌈𝑥 = 1 - ⌈𝑥	#R74/M140.KorektoMath,T73 +_a+b$ → +_a_+_b$
1-⌈𝑥 = 1 - (⌉𝑥 / 1+⌉𝑥)	#C75/I187.KorektoMath,R71,R74 a=(b),a→(b)
1-⌈𝑥 = (1+⌉𝑥-⌉𝑥 / 1+⌉𝑥)	#R76/M174.KorektoMath,C75 _1±(a_/_b) → (b±a / b)
1-⌈𝑥 = 1+⌉𝑥-⌉𝑥 / 1+⌉𝑥	#R77/M132.KorektoMath,R76 +_(a)$ → +_a$
1-⌈𝑥 = 1 / 1+⌉𝑥	#R78/M167.KorektoMath,R77 +a-a_
# Cosider ⌈-𝑥
⌈-𝑥 = ⌈-𝑥	#T79/A150.KorektoMath Reflection
⌈-𝑥 = 1 / 1+⌉--𝑥	#T80/A60 Squash
⌈-𝑥 = 1 / 1+⌉𝑥	#R81/M203.KorektoMath,T80 --a→a
# Then:
1-⌈𝑥 = ⌈-𝑥	#C82/I154.KorektoMath,R81,R78 a=b;c=b;c=a
1-⌈𝓍 = ⌈-𝓍	#A83/C82 1-⌈𝑥=⌈-𝑥
⌈-𝑥 = 1-⌈𝑥	#R84/M149.KorektoMath,C82 Symmetry
⌈-𝓍 = 1-⌈𝓍	#A85/R84 ⌈-𝑥=1-⌈𝑥
# Derivative:
# Label 𝑥
ₓ → 𝑥	#S86/L71.KorektoMath Map: ₓ
# ₓ → 𝑥;𝓓ₓ𝓐(𝑥) = ...
𝓓ₓ⌈𝑥 = 𝓓ₓ⌈𝑥	#T87/A150.KorektoMath Reflection
𝓓ₓ⌈𝑥 = 𝓓ₓ(⌈𝑥)	#R88/M94.KorektoMath,T87 a → (a)
𝓓ₓ⌈𝑥 = 𝓓ₓ(1 / 1+⌉-𝑥)	#C89/I191.KorektoMath,T61,R88 (a)=(b),(a)→(b)
𝓓ₓ(1 / 1+⌉-𝑥) = -𝓓ₓ⌉-𝑥 / (1+⌉-𝑥)²	#T90/A212.KorektoMath From quotient rule
𝓓ₓ⌈𝑥 = -𝓓ₓ⌉-𝑥 / (1+⌉-𝑥)²	#C91/I195.KorektoMath,T90,C89 a=b, +_a$ → +_b$
# Consider 𝓓ₓ⌉-𝑥
𝓓ₓ⌉-𝑥 = 𝓓ₓ⌉-𝑥	#T92/A150.KorektoMath Reflection
𝓓ₓ⌉-𝑥 = 𝓓ₓ(⌉-𝑥)	#R93/M94.KorektoMath,T92 a → (a)
⌉-𝑥 = 𝖊∧-𝑥	#T94/A87.KorektoMath Exp
𝓓ₓ⌉-𝑥 = 𝓓ₓ(𝖊∧-𝑥)	#C95/I191.KorektoMath,T94,R93 (a)=(b),(a)→(b)
𝓓ₓ(𝖊∧-𝑥) = 𝓓ₓ(-𝑥)𝖊∧-𝑥	#T96/A215.KorektoMath D(e^x)=D(x)e^x
𝓓ₓ⌉-𝑥 = 𝓓ₓ(-𝑥)𝖊∧-𝑥	#C97/I185.KorektoMath,T96,C95 a=b,_a$→_b$
𝓓ₓ⌉-𝑥 = 𝓓ₓ(-𝑥)*𝖊∧-𝑥	#R98/M147.KorektoMath,C97 Explicit*
𝓓ₓ(-𝑥) = -1	#R99/M218.KorektoMath,S86 𝓓ₓ-𝑥=-1
𝓓ₓ⌉-𝑥 = -1*𝖊∧-𝑥	#C100/I178.KorektoMath,R99,R98 a=b,a→b
𝓓ₓ⌉-𝑥 = -𝖊∧-𝑥	#R101/M162.KorektoMath,C100 1*
𝓓ₓ⌉-𝑥 = -(𝖊∧-𝑥)	#R102/M144.KorektoMath,R101 a^b → (a^b)
-𝓓ₓ⌉-𝑥 = (𝖊∧-𝑥)	#R103/M204.KorektoMath,R102 a=-b;-a=-b
# Substituting
𝓓ₓ⌈𝑥 = (𝖊∧-𝑥) / (1+⌉-𝑥)²	#C104/I178.KorektoMath,R103,C91 a=b,a→b
𝓓ₓ⌈𝑥 = 𝖊∧-𝑥 / (1+⌉-𝑥)²	#R105/M120.KorektoMath,C104 ♭(a)♭ → _a_
𝓓ₓ⌈𝑥 = ⌉-𝑥 / (1+⌉-𝑥)²	#C106/I184.KorektoMath,T94,R105 a=b,_b_→_a_
𝓓ₓ⌈𝑥 = ⌉-𝑥/(1+⌉-𝑥)²	#R107/M109.KorektoMath,C106 _a_*_b$ → _a*b$
𝓓ₓ⌈𝑥 = ⌉-𝑥/(1+⌉-𝑥) 1/(1+⌉-𝑥)	#R108/M175.KorektoMath,R107 _a/b²$→_a/b_1/b$
⌈𝑥 = 1 / (1+⌉-𝑥)	#R109/M100.KorektoMath,R62 (a_+_b) → (a+b)
⌈𝑥 = 1/(1+⌉-𝑥)	#R110/M109.KorektoMath,R109 _a_*_b$ → _a*b$
𝓓ₓ⌈𝑥 = ⌉-𝑥/(1+⌉-𝑥) ⌈𝑥	#C111/I186.KorektoMath,R110,R108 a=b,_b$→_a$
⌈-𝑥 = ⌉-𝑥 / 1+⌉-𝑥	#T112/A72 Alternate Squash
⌈-𝑥 = ⌉-𝑥 / (1+⌉-𝑥)	#R113/M103.KorektoMath,T112 _a+b$ → ♭(a♭+♭b)$
⌈-𝑥 = ⌉-𝑥/(1+⌉-𝑥)	#R114/M109.KorektoMath,R113 _a_*_b$ → _a*b$
𝓓ₓ⌈𝑥 = ⌈-𝑥 ⌈𝑥	#C115/I184.KorektoMath,R114,C111 a=b,_b_→_a_
𝓓ₓ⌈𝑥 = 1-⌈𝑥 ⌈𝑥	#C116/I183.KorektoMath,R84,C115 a=b,_a_→_b_
𝓓ₓ⌈𝑥 = (1-⌈𝑥) ⌈𝑥	#R117/M106.KorektoMath,C116 _a+b_ → ♭(a♭+♭b)♭
𝓓ₓ⌈𝑥 = (1-⌈𝑥)*⌈𝑥	#R118/M147.KorektoMath,R117 Explicit*
𝓑⌈𝑥 = (1-⌈𝑥)*⌈𝑥	#T119/A206.KorektoMath Binary balance
𝓓ₓ⌈𝑥 = 𝓑⌈𝑥	#C120/I154.KorektoMath,T119,R118 a=b;c=b;c=a
```
### Unsquash
```korekto
# The unsquash function in Ruby is:
#   Math.log(𝑥 / (1 - 𝑥))
# Here  its:
⌋𝓍 = ⌊ 𝓍/(1-𝓍)	#A121 Unsquash: ⌋
⌋𝑥 = ⌊ 𝑥/(1-𝑥)	#T122/A121 Unsquash
# Show that unsquash is the inverse of squash(⌋⌈=1):
⌋⌈𝑥 = ⌊ ⌈𝑥/(1-⌈𝑥)	#T123/A121 Unsquash
⌊ ⌈𝑥/(1-⌈𝑥) = ⌊⌈𝑥 - ⌊(1-⌈𝑥)	#T124/A205.KorektoMath ⌊(a/b)=⌊a-⌊b
⌋⌈𝑥 = ⌊⌈𝑥 - ⌊(1-⌈𝑥)	#C125/I195.KorektoMath,T124,T123 a=b, +_a$ → +_b$
⌋⌈𝑥 = ⌊(⌈𝑥) - ⌊(1-⌈𝑥)	#R126/M94.KorektoMath,C125 a → (a)
# ⌈𝑥 = ⌉𝑥 / 1+⌉𝑥
⌋⌈𝑥 = ⌊(⌉𝑥 / 1+⌉𝑥) - ⌊(1-⌈𝑥)	#C127/I191.KorektoMath,R71,R126 (a)=(b),(a)→(b)
⌋⌈𝑥 = ⌊(⌉𝑥 / (1+⌉𝑥)) - ⌊(1-⌈𝑥)	#R128/M126.KorektoMath,C127 _a)→_(a))
⌋⌈𝑥 = ⌊(⌉𝑥/(1+⌉𝑥)) - ⌊(1-⌈𝑥)	#R129/M100.KorektoMath,R128 (a_+_b) → (a+b)
⌊ ⌉𝑥/(1+⌉𝑥) = ⌊⌉𝑥 - ⌊(1+⌉𝑥)	#T130/A205.KorektoMath ⌊(a/b)=⌊a-⌊b
⌊(⌉𝑥/(1+⌉𝑥)) = ⌊⌉𝑥 - ⌊(1+⌉𝑥)	#R131/M106.KorektoMath,T130 _a+b_ → ♭(a♭+♭b)♭
⌋⌈𝑥 = (⌊⌉𝑥 - ⌊(1+⌉𝑥)) - ⌊(1-⌈𝑥)	#C132/I187.KorektoMath,R131,R129 a=(b),a→(b)
⌋⌈𝑥 = ⌊⌉𝑥 - ⌊(1+⌉𝑥) - ⌊(1-⌈𝑥)	#R133/M128.KorektoMath,C132 +_(a)_+ → +_a_+
⌊⌉𝑥 = 𝑥	#R53/M95.KorektoMath,R52 (a) → a
⌊⌉(𝑥) = 𝑥	#R134/M94.KorektoMath,R53 a → (a)
⌋⌈𝑥 = 𝑥 - ⌊(1+⌉𝑥) - ⌊(1-⌈𝑥)	#C135/I178.KorektoMath,R53,R133 a=b,a→b
! stop!
    = ⌊ ⌉𝑥/(⌉𝑥+1) - ⌊ 1-⌈𝑥  # by alternate definition of squash.
    = ⌊⌉𝑥 - ⌊ ⌉𝑥+1 - ⌊ 1-⌈𝑥
    = 𝑥 - ⌊ ⌉𝑥+1 - ⌊ 1-⌈𝑥
    = 𝑥 - ⌊ ⌉𝑥+1 - ⌊ 1-⌉𝑥/(⌉𝑥+1)
    = 𝑥 - ⌊ ⌉𝑥+1 - ⌊ (⌉𝑥+1-⌉𝑥)/(⌉𝑥+1)
    = 𝑥 - ⌊ ⌉𝑥+1 - ⌊ 1/(⌉𝑥+1)
    = 𝑥 - ⌊ ⌉𝑥+1 - (⌊1 - ⌊ ⌉𝑥+1)
    = 𝑥 - ⌊ ⌉𝑥+1 - (0 - ⌊ ⌉𝑥+1)
    = 𝑥 - ⌊ ⌉𝑥+1 - (-⌊ ⌉𝑥+1)
    = 𝑥 - ⌊ ⌉𝑥+1 + ⌊ ⌉𝑥+1
⌋⌈𝑥 = 𝑥
⌋(⌈(𝑥)) = 𝑥
```
### Activation and value of a neuron
```korekto
# The activation of the h-th Neuron(in level h connecting to level i):
𝒂ₕ := ⌈(𝒃ₕ + ∑ᵢ(𝑾ₕᵢ * 𝒂ᵢ))
   = ⌈ 𝒃ₕ+𝑾ⁱ𝒂ᵢ
𝒂 = ⌈ 𝒃+𝑾𝒂'
⌋𝒂 = 𝒃+𝑾𝒂'
⌋𝒂ₕ = 𝒃ₕ+𝑾ⁱ𝒂ᵢ
⌋(𝒂ₕ) = 𝒃ₕ + ∑ᵢ(𝑾ₕᵢ * 𝒂ᵢ)
# The value of the h-th Neuron is the unsquashed activation:
𝒗ₕ = ⌋(𝒂ₕ)
   = 𝒃ₕ + ∑ᵢ(𝑾ₕᵢ * 𝒂ᵢ)
𝒗 = 𝒃 + 𝑾 𝒂'
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
