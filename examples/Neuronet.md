# Neuronet wiki

The following is a `Korekto` review of
[Neuronet wiki](https://github.com/carlosjhr64/neuronet/wiki).

Here's a quick review of the math.
Please allow the terse notation as the algebra gets gnarly.

## Syntax
```korekto
< imports/Kernel.md
? balanced? '(){}[]'
? length < 66
! scanner: '\w+|.'
! Token /\w+|./
! Token {𝟙 𝟚 𝟛 𝟜}
! .Newline /\n/
! .Newline {;}
! Span /[^=;]+/
! Span {Span1 Span2 Span3 Span4}
! Glob /\S*/
! Glob {Glob1 Glob2 Glob3 Glob4}
! Group /[^()]+/
! Group {Group1 Group2 Group3 Group4}
! Set /[^{}]*/
! Set {Set1 Set2 Set3 Set4}
! Word /\w+/
! Word {Word1 Word2 Word3 Word4}
! Scalar /[𝑎-𝑧]/
! Scalar {a b c d}
! Vector /[𝒂-𝒛]/
! Vector {W X Y Z}
! Tensor /[𝑨-𝒁]/
! Tensor {A B C D}
! Superscript /[ʰⁱʲᵏⁿ]/
! Superscript {ⁱ ʲ ᵏ}
! Subscript /[ₕᵢⱼₖₙ]/
! Subscript {ᵢ ⱼ ₖ}
```
Operator precedence is as in
[ruby](https://ruby-doc.org/core-2.6.2/doc/syntax/precedence_rdoc.html):

* Unary right binding operators
* *, /
* +, -
* =
```korekto
# Allow equivalent definitions:
#     Introduce EmptySet
Span1 : Span2	#L1 Equivalent:   :
EmptySet : {}	#S2/L1 Equivalent: EmptySet { }
# Equivalences are equal and reflective:
Span1 : Span2;Span1 = Span2	#M3 If equivalent, then equal: =
Span1 = Span2;Span2 = Span1	#M4 Reflection
EmptySet = {}	#R5/M3,S2 If equivalent, then equal
{} = EmptySet	#R6/M4,R5 Reflection
# Allow introduction of sets:
#     Introduce Operators
Word1{Set1}	#L7 Named set
Operator{* / + - =}	#S8/L7 Named set: Operator * / + -
# Introduce membership:
#     `*` is an Operator
Word1{Set1𝟙Set2};Word1[𝟙]	#M9 Membership: [ ]
Word1[𝟙];𝟙 ∍ Word1	#M10 Element of: ∍
Operator[*]	#R11/M9,S8 Membership
# Introduce type Scalar:
#     Introduce scalars 𝑎..𝑑
Scalar[a]	#L12 Scalar variable: Scalar
Scalar[𝑎]	#S13/L12 Scalar variable: 𝑎
Scalar[𝑏]	#S14/L12 Scalar variable: 𝑏
Scalar[𝑐]	#S15/L12 Scalar variable: 𝑐
Scalar[𝑑]	#S16/L12 Scalar variable: 𝑑
𝑑 ∍ Scalar	#R17/M10,S16 Element of
# Introduce type Vector:
#     Introduce vectors 𝒂..𝐝
Vector[X]	#L18 Vector variable: Vector
Vector[𝒂]	#S19/L18 Vector variable: 𝒂
Vector[𝒃]	#S20/L18 Vector variable: 𝒃
Vector[𝒄]	#S21/L18 Vector variable: 𝒄
Vector[𝒅]	#S22/L18 Vector variable: 𝒅
```
But I add spacing to create groups:

* 𝑎 + 𝑏/𝑐 + 𝑑 = 𝑎 + (𝑏/𝑐) + 𝑑
* 𝑎+𝑏 / 𝑐+𝑑 = (𝑎+𝑏) / (𝑐+𝑑)
```korekto
# Space creates groups
Group1 𝟙 Group2 = (Group1)𝟙(Group2)	#A23 Space groups with operator: ( )
Group1 Group2 = (Group1)(Group2)	#A24 Space groups
𝑎+𝑏 / 𝑐+𝑑 = (𝑎+𝑏)/(𝑐+𝑑)	#T25/A23 Space groups with operator
# The following line is a novelty:
𝑎+𝑏 𝑐+𝑑 = (𝑎+𝑏)(𝑐+𝑑)	#T26/A24 Space groups
```
The above spacing rule reduces the amount of symbols needed to show structure
and makes the algebra less cluttered.

The product, `*`, may be implied:

* 𝑎*𝑏 = 𝑎 𝑏 = 𝑎𝑏
* (𝑎+𝑏)*(𝑐+𝑑) = 𝑎+𝑏 𝑐+𝑑
* 𝑥² = 𝑥𝑥 = 𝑥*𝑥
```korekto
(Group1)*(Group2) = (Group1)(Group2)	#A27 Implied group *
(𝑎+𝑏)*(𝑐+𝑑) = (𝑎+𝑏)(𝑐+𝑑)	#T28/A27 Implied group *
𝟙 𝟚 = 𝟙𝟚	#A29 Implied *
𝟙*𝟚 = 𝟙𝟚	#A30 Implied *
𝑎*𝑏 = 𝑎𝑏	#T31/A30 Implied *
```
Definitions are set by `:` and consequent equivalences by `=`.
```korekto
1+1 : 2	#S32/L1 Equivalent: 1 2
1+1 = 2	#R33/M3,S32 If equivalent, then equal
```
I may use Einstein notation.
And once indices are shown, they may be dropped:

* ∑ₙ(𝑾ₙ*𝒂ₙ) = 𝑾ⁿ𝒂ₙ = 𝑾𝒂
```korekto
Subscripts{ₕ ᵢ ⱼ ₖ ₙ}	#S34/L7 Named set: Subscripts ₕ ᵢ ⱼ ₖ ₙ
Superscripts{ʰ ⁱ ʲ ᵏ ⁿ}	#S35/L7 Named set: Superscripts ʰ ⁱ ʲ ᵏ ⁿ
Tensor[A]	#L36 Tensor variable: Tensor
Tensor[𝑾]	#S37/L36 Tensor variable: 𝑾
∑ₙ(Aₙ*Xₙ) : AⁿXₙ	#A38 Einstein notation: ∑
∑ₙ(𝑾ₙ*𝒂ₙ) : 𝑾ⁿ𝒂ₙ	#T39/A38 Einstein notation
∑ₙ(𝑾ₙ*𝒂ₙ) = 𝑾ⁿ𝒂ₙ	#R40/M3,T39 If equivalent, then equal
AⁿXₙ : A X	#A41 Context equivalence
𝑾ⁿ𝒂ₙ : 𝑾 𝒂	#T42/A41 Context equivalence
𝑾ⁿ𝒂ₙ = 𝑾 𝒂	#R43/M3,T42 If equivalent, then equal
𝑾 𝒂 = 𝑾𝒂	#T44/A29 Implied *
Span1 = Span2;Span2 = Span3;Span1 = Span3	#I45 Transitive
𝑾ⁿ𝒂ₙ = 𝑾𝒂	#C46/I45,R43,T44 Transitive
stop
```
Be aware of these rules.

## Style

Referencing Wikipedia's
[Mathematical operators and symbols in Unicode](https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode)
and
[Unicode subscripts and superscripts:](https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts)

* Italic small(𝑎..𝑧): scalar variables
* Bold italic small(𝒂..𝒛): single-indexed variables, vectors.
* Bold italic capital(𝑨..𝒁): multi-indexed variables, matrices.
* Bold script capital(𝓐..𝓩): operators, like 𝓓𝑥.
* Double struck small(𝕒..𝕫): finite ordered sets.
* Bold Fraktur small(𝖆..𝖟): derived constant parameters.
```korekto
# Note that Scalar, Vector, and Tensor(Matrix) have already been defined
! UnaryOperator /[𝓐-𝓩]/
! UnaryOperator {E F G H}
! FiniteOrderedSet /[𝕒-𝕫]/
! FiniteOrderedSet {r s t u}
! Constant /[𝖆-𝖟]/
! Constant {R S T U}
```
## Next level unary postfix operator

Consider a value in a collection of `𝒂` in level h dependent on values in
collection of `𝒂` in level i:

* `𝒂ₕ := ⌈(𝒃ₕ + ∑ᵢ(𝑾ₕᵢ * 𝒂ᵢ))`
```korekto
𝒂ₕ := ⌈(𝒃ₕ + ∑ᵢ(𝑾ₕᵢ * 𝒂ᵢ))	#D16
```

The index `ₕ` enumerates values of `𝒂` in level h, whereas `ᵢ` enumerates
values of `𝒂` in level i.  The levels are labeled alphabetically:

* `{...,ₕ,ᵢ,ⱼ,ₖ,ₗ,ₘ,ₙ,ₒ,ₚ,...}`

I'll want to express the relation between levels without specifying the level.
Given the above, please allow:

* `𝒂 = ⌈(𝒃 + 𝑾 𝒂')`
* `𝒂 = ⌈ 𝒃+𝑾(𝒂')`
* `𝒂 = ⌈ 𝒃+𝑾𝒂'`
```korekto
ᵢ := ₕ'	#D17
ⱼ := ᵢ'	#D18
ₖ := ⱼ'	#D19
ₗ := ₖ'	#D20
𝒂ₕ = ⌈(𝒃ₕ + ∑ᵢ(𝑾ₕᵢ * 𝒂ᵢ))	#R21/M9,D16 Defined equivalent
TODO: It's gnarly. Come back to it later.
```

## Binary competition

In [The Math of Species Conflict - Numberphile](https://www.youtube.com/watch?v=WR3GqqWAmfw)
the following function is referred to as "binary competition":

* `𝓑(𝑥) := 𝑥 * (1 - 𝑥)`

This form occurs in the derivative of the squash function, and so I'll use `𝓑`
in it's expression.

## Squash
```korekto
# Please let:
⌉(𝑥) := Math.exp(𝑥)
# Define the squash function:
⌈(𝑥) := 1 / (1 + Math.exp(-𝑥))
⌈(𝑥) = 1 / (1 + ⌉(-𝑥))
⌈𝑥 = 1 / 1+⌉-𝑥
   = ⌉𝑥 / ⌉𝑥+1
⌈𝑥 = ⌉𝑥 / 1+⌉𝑥
⌈(𝑥) = ⌉(𝑥) / (1 + ⌉(𝑥)) # Alternate definition of squash
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
