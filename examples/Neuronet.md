# Neuronet wiki

The following is a `Korekto` review of
[Neuronet wiki](https://github.com/carlosjhr64/neuronet/wiki).

## Style

Referencing Wikipedia's
[Mathematical operators and symbols in Unicode](https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode)
and
[Unicode subscripts and superscripts:](https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts)

* Italic small `𝑎..𝑧`: scalar variables
* Bold italic small `𝒂..𝒛`: single-labeled variables, vectors.
* Bold italic capital `𝑨..𝒁`: multi-labeled variables, matrices.
* Bold script capital `𝓐..𝓩`: unary operators, like 𝓓𝑥.
* Bold script small `𝓪..𝔃`: binary operators.
* Double struck small `𝕒..𝕫`: finite ordered sets.
* Bold Fraktur small `𝖆..𝖟`: derived constant parameters.

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

## Binary competition

In ["The Math of Species Conflict" by Numberphile](https://www.youtube.com/watch?v=WR3GqqWAmfw),
the following function is referred to as "binary competition":

* `𝓑(𝑥) : 𝑥 * (1 - 𝑥)`
  * `𝓑𝑥 = 𝑥(1-𝑥)`

This form occurs in the derivative of the squash function, and so I'll use `𝓑`
in it's expression.

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

The following is written in `Korekto` code blocks.
I will be importing [KorektoMath](../imports/KorektoMath.md).

### Introductions
```korekto
< imports/KorektoMath.md
? length < 50
# Types
## Euler's constant 𝖊 ~ 2.718⋯
Constant[𝖊]	#S1/L15.KorektoMath Constant: 𝖊
## Scalar variable 𝑥 to help define functions
Scalar[𝑥]	#S2/L16.KorektoMath Scalar: 𝑥
## The labeled activation layer vector 𝒂
Vector[𝒂]	#S3/L17.KorektoMath Vector: 𝒂
## The labeled bias vector 𝒃
Vector[𝒃]	#S4/L17.KorektoMath Vector: 𝒃
## The multi-labeled weights matrix 𝑾
Tensor[𝑾]	#S5/L18.KorektoMath Tensor: 𝑾
## Labels
Supercript{ʰ ⁱ ʲ ᵏ}	#S6/L3.KorektoMath Named set: Supercript ʰ ⁱ ʲ ᵏ
Subscript{ₕ ᵢ ⱼ ₖ}	#S7/L3.KorektoMath Named set: Subscript ₕ ᵢ ⱼ ₖ
## Next labels
ₕ₊ : ᵢ	#R8/M7.KorektoMath,S7 Next
ᵢ₊ : ⱼ	#R9/M7.KorektoMath,S7 Next
ⱼ₊ : ₖ	#R10/M7.KorektoMath,S7 Next
## Raised labels
ₕ⁺ : ʰ	#C11/I11.KorektoMath,S7,S6 Raise
ᵢ⁺ : ⁱ	#C12/I12.KorektoMath,S7,S6 Raise
ⱼ⁺ : ʲ	#C13/I13.KorektoMath,S7,S6 Raise
# Functions
## Natural Exponentiation and Logarythm
𝖊∧𝟛 = 𝟠;𝖊𝓵𝟠 = 𝟛	#M14 Natural Log
𝖊𝓵𝟠 = 𝟛;𝖊∧𝟛 = 𝟠	#M15 Natural Exp
### Natural Log abstract
𝖊∧𝑥 : TMP	#S16/L1.KorektoMath Equivalent: TMP
𝖊∧𝑥 = TMP	#R17/M2.KorektoMath,S16 If equivalent, then equal
𝖊𝓵TMP = 𝑥	#R18/M34.KorektoMath,R17 Exponentiation<=>Logarithm
𝖊∧(𝑥) = TMP	#R19/M62.KorektoMath,R17 a->(a)
𝖊𝓵(TMP) = 𝑥	#R20/M62.KorektoMath,R18 a->(a)
𝖊∧(Q1) = Q2;𝖊𝓵(Q2) = Q1	#M21/R19,R20 Natural Log abstract
### Natural Exp abstract
𝖊𝓵(TMP) = 𝑥	#R20/M62.KorektoMath,R18 Token grouped
𝖊∧(𝑥) = TMP	#R19/M62.KorektoMath,R17 Token grouped
𝖊𝓵(Q1) = Q2;𝖊∧(Q2) = Q1	#M22/R20,R19 Natural Exp abstract
### Exp and Log are inverses of eachother
𝖊∧(𝖊𝓵TMP) = TMP	#C23/I99.KorektoMath,R18,R19 a=b;(b)->(a)
𝖊∧(𝖊𝓵(TMP)) = TMP	#C24/I99.KorektoMath,R20,R19 a=b;(b)->(a)
𝖊∧(𝖊𝓵(Q1)) = Q1	#A25/C24 Exp Log x = x
𝖊𝓵(𝖊∧(𝑥)) = 𝑥	#C26/I99.KorektoMath,R19,R20 a=b;(b)->(a)
𝖊𝓵(𝖊∧(Q1)) = Q1	#A27/C26 Log Exp x = x
```
## Natural exponentiation function
```korekto
# In Ruby, the natural exponentiation function is:
#     Math.exp(x) == Math::E**x #=> true
# Here its:
⌉(𝑥) : 𝖊∧(𝑥)	#S28/L1.KorektoMath Equivalent: ⌉
⌉(𝑥) = 𝖊∧(𝑥)	#R29/M2.KorektoMath,S28 If equivalent, then equal
⌉(Q1) = 𝖊∧(Q1)	#A30/R29 Exp abstract
⌉𝑥 = 𝖊∧(𝑥)	#R31/M61.KorektoMath,R29 (a)->a
⌉𝑥 = 𝖊∧𝑥	#R32/M61.KorektoMath,R31 (a)->a
# Prove 𝖊∧0 = 1
𝖊∧0 = 𝖊∧0	#T33/A80.KorektoMath Reflection
𝖊∧0 = 𝖊∧(0)	#R34/M62.KorektoMath,T33 a->(a)
𝑥 - 𝑥 = 0	#T35/A22.KorektoMath Zero
𝖊∧0 = 𝖊∧(𝑥 - 𝑥)	#C36/I99.KorektoMath,T35,R34 a=b;(b)->(a)
𝖊∧0 = 𝖊∧(𝑥 + -𝑥)	#R37/M101.KorektoMath,C36 a-b=a+-b
𝖊∧0 = 𝖊∧𝑥*𝖊∧-𝑥	#R38/M104.KorektoMath,R37 a^(b+c)=a^b*a^c
𝖊∧0 = 𝖊∧𝑥*(𝖊∧-𝑥)	#R39/M74.KorektoMath,R38 Tight grouped
𝖊∧0 = (𝖊∧𝑥)*(𝖊∧-𝑥)	#R40/M74.KorektoMath,R39 Tight grouped
# The following line is a known fact which I won't prove here:
𝖊∧(-𝑥) = 1 / 𝖊∧(𝑥)	#P41 Equivalent reciprical
𝖊∧-𝑥 = 1 / 𝖊∧(𝑥)	#R42/M61.KorektoMath,P41 (a)->a
𝖊∧-𝑥 = 1 / 𝖊∧𝑥	#R43/M61.KorektoMath,R42 (a)->a
# Then:
𝖊∧0 = (𝖊∧𝑥)*(1 / 𝖊∧𝑥)	#C44/I98.KorektoMath,R43,R40 a=b;(a)->(b)
𝖊∧0 = (𝖊∧𝑥)*(1 / (𝖊∧𝑥))	#R45/M74.KorektoMath,C44 Tight grouped
𝖊∧0 = ((𝖊∧𝑥) / (𝖊∧𝑥))	#R46/M91.KorektoMath,R45 (x*1)/(y)
𝖊∧0 = (1)	#R47/M82.KorektoMath,R46 (a/a)
𝖊∧0 = 1	#R48/M61.KorektoMath,R47 (a)->a
```
## Natural logarithm function
```korekto
# In Ruby, the natural log funtion is:
#     y = Math.exp(x)
#     Math.log(y) == x #=> true
# Here its:
⌊(𝑥) : 𝖊𝓵(𝑥)	#S49/L1.KorektoMath Equivalent: ⌊
⌊(𝑥) = 𝖊𝓵(𝑥)	#R50/M2.KorektoMath,S49 If equivalent, then equal
⌊(Q1) = 𝖊𝓵(Q1)	#A51/R50 Log abstract
⌊𝑥 = 𝖊𝓵(𝑥)	#R52/M61.KorektoMath,R50 (a)->a
⌊𝑥 = 𝖊𝓵𝑥	#R53/M61.KorektoMath,R52 (a)->a
# If 𝖊∧0 = 1, then 𝖊𝓵1 = 0 by definition of 𝓵
𝖊∧0 = 1	#R48/M61.KorektoMath,R47 Token$ un-grouped
𝖊𝓵1 = 0	#R54/M34.KorektoMath,R48 Exponentiation<=>Logarithm
𝖊∧(0) = 1	#R55/M62.KorektoMath,R48 a->(a)
𝖊𝓵(1) = 0	#R56/M21,R55 Natural Log abstract
# Prove ⌉(⌊(𝑥)) = x
⌉(⌊(𝑥)) = ⌉(⌊(𝑥))	#T57/A80.KorektoMath Reflection
# I first shrink the right side's notation
⌉(⌊(𝑥)) = ⌉(⌊𝑥)	#R58/M61.KorektoMath,T57 (a)->a
⌉(⌊(𝑥)) = ⌉⌊𝑥	#R59/M61.KorektoMath,R58 (a)->a
# Now I consider the right side
⌉⌊𝑥 = ⌉⌊𝑥	#T60/A80.KorektoMath Reflection
⌉⌊𝑥 = ⌉(⌊𝑥)	#R61/M62.KorektoMath,T60 a->(a)
# I expand the right side by definitions
⌉⌊𝑥 = ⌉(𝖊𝓵𝑥)	#C62/I98.KorektoMath,R53,R61 a=b;(a)->(b)
⌉⌊𝑥 = ⌉ 𝖊𝓵𝑥	#R63/M65.KorektoMath,C62 Space$
⌉(𝖊𝓵𝑥) = 𝖊∧(𝖊𝓵𝑥)	#T64/A30 Exp abstract
⌉⌊𝑥 = 𝖊∧(𝖊𝓵𝑥)	#C65/I81.KorektoMath,C62,T64 Transitive
⌉⌊𝑥 = 𝖊∧(𝖊𝓵(𝑥))	#R66/M62.KorektoMath,C65 a->(a)
# I next invoke the inverse abstract axiom derived earlier
𝖊∧(𝖊𝓵(𝑥)) = 𝑥	#T67/A25 Exp Log x = x
⌉⌊𝑥 = 𝑥	#C68/I81.KorektoMath,R66,T67 Transitive
⌉(⌊(𝑥)) = ⌉⌊𝑥	#R59/M61.KorektoMath,R58 Token un-grouped
⌉(⌊(𝑥)) = 𝑥	#C69/I81.KorektoMath,R59,C68 Transitive
```
## Squash
```korekto
# The squash function in Ruby is:
#     1 / (1 + Math.exp(-𝑥))
# Here its:
⌈(𝑥) : 1 / (1 + ⌉(-𝑥))	#S70/L1.KorektoMath Equivalent: ⌈
⌈(𝑥) = 1 / (1 + ⌉(-𝑥))	#R71/M2.KorektoMath,S70 If equivalent, then equal
⌈𝑥 = 1 / (1 + ⌉(-𝑥))	#R72/M61.KorektoMath,R71 (a)->a
⌈𝑥 = 1 / (1 + ⌉-𝑥)	#R73/M61.KorektoMath,R72 (a)->a
⌈𝑥 = 1 / (1+⌉-𝑥)	#R74/M53.KorektoMath,R73 *(a + b)*->*(a+b)*
# Shrunk ⌈𝑥
⌈𝑥 = 1 / 1+⌉-𝑥	#R75/M65.KorektoMath,R74 Space$
# Alternates
⌈(𝑥) = (1) / (1 + ⌉(-𝑥))	#R76/M62.KorektoMath,R71 a->(a)
⌈(𝑥) = (1) / (1 + ⌉-𝑥)	#R77/M61.KorektoMath,R76 (a)->a
⌈(𝑥) = ⌉𝑥*(1) / ⌉𝑥*(1 + ⌉-𝑥)	#R78/M88.KorektoMath,R77 x*a / x*b$
⌈(𝑥) = ⌉𝑥 / ⌉𝑥*(1 + ⌉-𝑥)	#R79/M85.KorektoMath,R78 *(one)
⌈(𝑥) = ⌉𝑥 / (⌉𝑥*1 + ⌉𝑥*⌉-𝑥)	#R80/M93.KorektoMath,R79 (xa+xb)
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + ⌉𝑥*⌉-𝑥)	#R81/M84.KorektoMath,R80 *one
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + ⌉𝑥⌉-𝑥)	#R82/M76.KorektoMath,R81 Implied*
# Consider ⌉(-𝑥)
⌉(-𝑥) = 𝖊∧(-𝑥)	#T83/A30 Exp abstract
⌉-𝑥 = 𝖊∧(-𝑥)	#R84/M61.KorektoMath,T83 (a)->a
⌉-𝑥 = 𝖊∧-𝑥	#R85/M61.KorektoMath,R84 (a)->a
# And remember
⌉𝑥 = 𝖊∧𝑥	#R32/M61.KorektoMath,R31 Token
# Now subtitute in...
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + ⌉𝑥(𝖊∧-𝑥))	#C86/I96.KorektoMath,R85,R82 a=b;a->(b)
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + (𝖊∧𝑥)(𝖊∧-𝑥))	#C87/I96.KorektoMath,R32,C86 a=b;a->(b)
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + 𝖊∧𝑥(𝖊∧-𝑥))	#R88/M73.KorektoMath,C87 Tight un-grouped
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + 𝖊∧𝑥𝖊∧-𝑥)	#R89/M73.KorektoMath,R88 Tight un-grouped
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + 𝖊∧(𝑥 + -𝑥))	#R90/M103.KorektoMath,R89 a^ba^c=a^(b+c)
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + 𝖊∧(𝑥 - 𝑥))	#R91/M100.KorektoMath,R90 a+-b=a-b
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + 𝖊∧(𝑥-𝑥))	#R92/M53.KorektoMath,R91 *(a + b)*->*(a+b)*
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + 𝖊∧0)	#R93/M87.KorektoMath,R92 Zero
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + (𝖊∧0))	#R94/M74.KorektoMath,R93 Tight grouped
𝖊∧0 = 1	#R48/M61.KorektoMath,R47 (a)->a
⌈(𝑥) = ⌉𝑥 / (⌉𝑥 + 1)	#C95/I97.KorektoMath,R48,R94 (a)=b;(a)->b
⌈(𝑥) = 1 / (1 + ⌉(-𝑥))	#R71/M2.KorektoMath,S70 If equivalent, then equal
⌈𝑥 = 1 / 1+⌉-𝑥	#R75/M65.KorektoMath,R74 Space$
   = ⌉𝑥 / ⌉𝑥+1 #W
⌈𝑥 = ⌉𝑥 / 1+⌉𝑥 #W
STOP
# Alternate definition of squash
⌈(𝑥) = ⌉(𝑥) / (1 + ⌉(𝑥)) #W
STOP
# Equivalence 1-⌈𝑥 = ⌈-𝑥
1 - ⌈(𝑥) = 1 - (⌉(𝑥) / (1 + ⌉(𝑥)))
1-⌈𝑥 = 1 - ⌉𝑥 / 1+⌉𝑥
     = ⌉𝑥+1-⌉𝑥 / 1+⌉𝑥
     = 1 / 1+⌉𝑥
1-⌈𝑥 = ⌈-𝑥
1 - ⌈(𝑥) = ⌈(-𝑥)
# Equivalence ⌈-𝑥 = 1-⌈𝑥
⌈(-𝑥) = 1 - ⌈(𝑥)
⌈-𝑥 = 1-⌈𝑥
# Equivalence ⌈𝑥 = 1-⌈-𝑥
⌈(𝑥) = 1 - ⌈(-𝑥)
⌈𝑥 = 1-⌈-𝑥
# Derivative:
𝓓𝑥(⌈(𝑥)) = 𝓓𝑥(1 / (1 + ⌉(-𝑥)))
𝓓𝑥⌈𝑥 = 𝓓𝑥(1 / 1+⌉-𝑥)
     = 1/(1+⌉-𝑥)² -𝓓𝑥⌉-𝑥
     = 1/(1+⌉-𝑥)² ⌉-𝑥
     = ⌉-𝑥/(1+⌉-𝑥)² 
     = ⌉-𝑥/(1+⌉-𝑥) 1/(1+⌉-𝑥)
     = ⌉-𝑥/(1+⌉-𝑥) ⌈𝑥
     = 1/(⌉𝑥+1) ⌈𝑥
     = 1/(1+⌉𝑥) ⌈𝑥
     = ⌈-𝑥 ⌈𝑥
𝓓𝑥⌈𝑥 = 1-⌈𝑥 ⌈𝑥
𝓓𝑥(⌈(𝑥)) = (1 - ⌈(𝑥)) * ⌈(𝑥)
         = 𝓑(⌈(𝑥))
```
## Unsquash
```korekto
# Please let:
⌊(𝑥) := Math.log(𝑥)
# Recall that Log and Exp are inverses:
⌊(⌉(𝑥)) = 𝑥
⌊⌉𝑥 = 𝑥
# Recall that Log(1)=0
⌊(1) = 0
# Define the unsquash function:
⌋(𝑥) := Math.log(𝑥 / (1 - 𝑥))
⌋(𝑥) = ⌊(𝑥 / (1 - 𝑥))
⌋𝑥 = ⌊ 𝑥/(1-𝑥)
# Show that unsquash is the inverse of squash:
⌋(⌈(𝑥)) = ⌋(⌈(𝑥))
⌋⌈𝑥 = ⌋ ⌈𝑥
    = ⌊ ⌈𝑥/(1-⌈𝑥)  # by definition of unsquash, it's the log of...
    = ⌊⌈𝑥 - ⌊ 1-⌈𝑥
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
## Activation and value of a neuron
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
## Mirroring
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
## Propagation of errors level 1(Perceptron)
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
## Vanishing small errors
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
## Propagation of errors level 2
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
## Explicit propagation of errors level 2
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
## Explicit propagation of errors level 3
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
## General propagation of errors
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
## Legacy
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
