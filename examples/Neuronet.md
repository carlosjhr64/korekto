# Neuronet wiki

The following is a `Korekto` review of
[Neuronet wiki](https://github.com/carlosjhr64/neuronet/wiki).

## Style

Referencing Wikipedia's
[Mathematical operators and symbols in Unicode](https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode)
and
[Unicode subscripts and superscripts:](https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts)

* Italic small(𝑎..𝑧): scalar variables
* Bold italic small(𝒂..𝒛): single-indexed variables, vectors.
* Bold italic capital(𝑨..𝒁): multi-indexed variables, matrices.
* Bold script capital(𝓐..𝓩): unary operators, like 𝓓𝑥.
* Bold script small(𝓪..𝔃): binary operators.
* Double struck small(𝕒..𝕫): finite ordered sets.
* Bold Fraktur small(𝖆..𝖟): derived constant parameters.

## Review of the math

Please allow the terse notation as the algebra gets gnarly.
Operator precedence is as in
[Ruby](https://ruby-doc.org/core-2.6.2/doc/syntax/precedence_rdoc.html):

* Unary binding operators
* *, /
* +, -
* =

But I add spacing to create groups:

* 𝑎 + 𝑏/𝑐 + 𝑑 = 𝑎 + (𝑏/𝑐) + 𝑑
* 𝑎+𝑏 / 𝑐+𝑑 = (𝑎+𝑏) / (𝑐+𝑑)

The above spacing rule reduces the amount of symbols needed to show structure
and makes the algebra less cluttered.

The product, `*`, may be implied:

* 𝑎*𝑏 = 𝑎 𝑏 = 𝑎𝑏
* (𝑎+𝑏)*(𝑐+𝑑) = 𝑎+𝑏 𝑐+𝑑
* 𝑥² = 𝑥𝑥 = 𝑥*𝑥

Definitions are set by `:` and consequent equivalences by `=`.

I may use Einstein notation.
And once indices are shown, they may be dropped:

* ∑ₙ(𝑾ₙ*𝒂ₙ) : 𝑾ⁿ𝒂ₙ : 𝑾𝒂

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

Squash and unsquash contracts nicely as:

* Squash: `⌈𝑥 = 1 / 1+⌉-𝑥`
* Unsquash: `⌋𝑥 = ⌊ 𝑥/(1-𝑥)`

## Binary competition

In [The Math of Species Conflict - Numberphile](https://www.youtube.com/watch?v=WR3GqqWAmfw)
the following function is referred to as "binary competition":

* `𝓑(𝑥) : 𝑥 * (1 - 𝑥)`

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

The next level operator `₊` shifts the (context)index to the next level.

* `𝒂ₕ₊ : 𝒂ᵢ`

## Syntax
```korekto
< imports/Kernel.md
? balanced? '(){}[]'
? length < 66
! scanner: '\w+|.'
! Token /\w+|\S/
! Token {𝟙 𝟚 𝟛 𝟜 𝟝 𝟞 𝟟 𝟠 𝟡}
! .Clump /\S+/
! .Clump {𝟘}
! .Newline /\n/
! .Newline {;}
! Span /[^=;]*/
! Span {Span1 Span2 Span3 Span4}
! Slurp /[^;]*/
! Slurp {Slurp1 Slurp2 Slurp3 Slurp4}
! Glob /\S*/
! Glob {Glob1 Glob2 Glob3 Glob4}
! Group /[^()]+/
! Group {Group1 Group2 Group3 Group4}
! Set /[^{}]*/
! Set {Set1 Set2 Set3 Set4}
! Word /\w+/
! Word {Word1 Word2 Word3 Word4}
! Constant /[𝖆-𝖟]/
! Constant {𝖆 𝖇 𝖈 𝖉}
! Scalar /[𝑎-𝑧]/
! Scalar {𝑎 𝑏 𝑐 𝑑}
! Vector /[𝒂-𝒛]/
! Vector {𝒂 𝒃 𝒄 𝒅}
! Tensor /[𝑨-𝒁]/
! Tensor {𝑨 𝑩 𝑪 𝑫}
! Operator /[𝓐-𝓩]/
! Operator {𝓐 𝓑 𝓒 𝓓}
! Superscript /[ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻ]/
! Superscript {ᵃ ᵇ ᶜ ᵈ ᵉ ᶠ ᵍ ʰ ⁱ ʲ ᵏ ˡ ᵐ ⁿ ᵒ ᵖ ʳ ˢ ᵗ ᵘ ᵛ ʷ ˣ ʸ ᶻ}
! Subscript /[ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ]/
! Subscript {ₐ ₑ ₕ ᵢ ⱼ ₖ ₗ ₘ ₙ ₒ ₚ ᵣ ₛ ₜ ᵤ ᵥ ₓ}
```
## Rules
```korekto
# Equivalence
Span1 : Span2	#L1 Equivalent:   :
Span1 : Span2;Span1 = Span2	#M2 If equivalent, then equal: =
Span1 = Span2;Span2 = Span1	#M3 Reflection
# Sets
Word1{Set1}	#L4 Named set: { }
Word1{Set1𝟙Set2};Word1[𝟙]	#M5 Membership: [ ]
Word1[𝟙];𝟙 ∍ Word1	#M6 Element of: ∍
# Next member operator
Word1{Set1𝟙 𝟚Set2};𝟙₊ : 𝟚	#M7 Next: ₊
Word1{Set1𝟙 𝟚Set2};𝟚₋ : 𝟙	#M8 Previous: ₋
Word1.Word2 = (Word1.Word2)	#A9 Dot binds: . ( )
Word1{𝟙Set1};Word1.first : 𝟙	#M10 : first
Word1{Set1𝟙};Word1.last : 𝟙	#M11 : last
Word1{𝟙Set1};Word2{𝟚Set2};𝟙⁺ : 𝟚	#I12 Raise: ⁺
Word1{𝟘 𝟙Set1};Word2{𝟘 𝟚Set2};𝟙⁺ : 𝟚	#I13 Raise
Word1{𝟘 𝟘 𝟙Set1};Word2{𝟘 𝟘 𝟚Set2};𝟙⁺ : 𝟚	#I14 Raise
Word1{𝟘 𝟘 𝟘 𝟙Set1};Word2{𝟘 𝟘 𝟘 𝟚Set2};𝟙⁺ : 𝟚	#I15 Raise
# Types
Constant[𝖆]	#L16 Constant: Constant
Scalar[𝑎]	#L17 Scalar: Scalar
Vector[𝒂]	#L18 Vector: Vector
Tensor[𝑨]	#L19 Tensor: Tensor
Operator[𝓐]	#L20 Operator: Operator
# Addition and Subtraction
𝟙+𝟚 = 𝟛;𝟛-𝟚 = 𝟙	#M21 Adition-Subraction: + -
𝟙-𝟙 = 0	#A22 Additive identity: 0
# Multiplication and Division
𝟚*𝟛 = 𝟞;𝟞/𝟛 = 𝟚	#M23 Multiplication-Division: * /
𝟙/𝟙 = 1	#A24 Multiplicative identity: 1
𝟙² : 𝟙*𝟙	#A25 Square: ²
# Exponentiation, Roots, and Logarithm
𝟚∧𝟛 = 𝟠;𝟠∨𝟛 = 𝟚	#M26 Exponentiation-Root: ∧ ∨
𝟚² = 𝟜;√𝟜 = 𝟚	#M27 Square Root: √
# Logarithms
𝟚∧𝟛 = 𝟠;𝟚𝓵𝟠 = 𝟛	#M28 Exponentiation-Logarithm: 𝓵
# Implied multiplication
𝟙*𝟚 = 𝟙𝟚	#A29 Implied multiplication
𝟙 𝟚 = 𝟙𝟚	#A30 Implied multiplcation
# Groups
Group1 𝟙 Group2 = (Group1)𝟙(Group2)	#A31 Space groups with operator
Group1 Group2 = (Group1)(Group2)	#A32 Space groups
Span1 Group1 Span2 = Span1 (Group1) Span2	#A33 Space groups
(Group1)*(Group2) = Group1 Group2	#A34 Implied multiplication
(Group1)*(Group2) = (Group1)(Group2)	#A35 Implied multiplication
Slurp1(𝟙)Slurp2;Slurp1𝟙Slurp2	#M36 Token
Slurp1(-𝟙)Slurp2;Slurp1-𝟙Slurp2	#M37 -Token
Slurp1(𝟙 + Group1)Slurp2;Slurp1(𝟙+Group1)Slurp2	#M38 Token+
Slurp1 (Group1);Slurp1 Group1	#M39 Right space group
```
## Introductions
```korekto
# Digits
1+1 : 2	#S40/L1 Equivalent: 2
2+1 : 3	#S41/L1 Equivalent: 3
3+1 : 4	#S42/L1 Equivalent: 4
4+1 : 5	#S43/L1 Equivalent: 5
5+1 : 6	#S44/L1 Equivalent: 6
6+1 : 7	#S45/L1 Equivalent: 7
7+1 : 8	#S46/L1 Equivalent: 8
8+1 : 9	#S47/L1 Equivalent: 9
# Types
Scalar[𝑥]	#S48/L17 Scalar: 𝑥
Scalar[𝑎]	#S49/L17 Scalar: 𝑎
Scalar[𝑏]	#S50/L17 Scalar: 𝑏
Scalar[𝑐]	#S51/L17 Scalar: 𝑐
Scalar[𝑑]	#S52/L17 Scalar: 𝑑
Vector[𝒂]	#S53/L18 Vector: 𝒂
Vector[𝒃]	#S54/L18 Vector: 𝒃
Vector[𝒄]	#S55/L18 Vector: 𝒄
Vector[𝒅]	#S56/L18 Vector: 𝒅
Tensor[𝑾]	#S57/L19 Tensor: 𝑾
# Indeces
## Superscript
Sup{ʰ ⁱ ʲ ᵏ ˡ ᵐ ⁿ ᵒ ᵖ}	#S58/L4 Named set: Sup ʰ ⁱ ʲ ᵏ ˡ ᵐ ⁿ ᵒ ᵖ
## Subscript
Sub{ₕ ᵢ ⱼ ₖ ₗ ₘ ₙ ₒ ₚ}	#S59/L4 Named set: Sub ₕ ᵢ ⱼ ₖ ₗ ₘ ₙ ₒ ₚ
### Next
ₕ₊ : ᵢ	#R60/M7,S59 Next
ᵢ₊ : ⱼ	#R61/M7,S59 Next
ⱼ₊ : ₖ	#R62/M7,S59 Next
### Raise
ₕ⁺ : ʰ	#C63/I12,S59,S58 Raise
ᵢ⁺ : ⁱ	#C64/I13,S59,S58 Raise
ⱼ⁺ : ʲ	#C65/I14,S59,S58 Raise
# Euler's number ~ 2.718⋯
Constant[𝖊]	#S66/L16 Constant: 𝖊
# Natural Exponentiation and Log
𝖊∧𝟛 = 𝟠;𝖊𝓵𝟠 = 𝟛	#M67 Natural log
𝖊𝓵𝟠 = 𝟛;𝖊∧𝟛 = 𝟠	#M68 Natural exponentiation
```
## Natural exponentiation function
```korekto
# In Ruby, the natural exponenction funtion is:
#     Math.exp(x) == Math::E**x #=> true
# Here its:
⌉(𝑥) : 𝖊∧𝑥	#S69/L1 Equivalent: ⌉
# In Ruby, the natural log funtion is:
#     y = Math.exp(x)
#     Math.log(y) == x #=> true
# Here its:
⌊(𝑥) : 𝖊𝓵𝑥	#S70/L1 Equivalent: ⌊
```
## Squash
```korekto
# The squash function in Ruby is:
#     1 / (1 + Math.exp(-𝑥))
# Here its:
⌈(𝑥) : 1 / (1 + ⌉(-𝑥))	#S71/L1 Equivalent: ⌈
⌈(𝑥) = 1 / (1 + ⌉(-𝑥))	#R72/M2,S71 If equivalent, then equal
⌈𝑥 = 1 / (1 + ⌉(-𝑥))	#R73/M36,R72 Token
⌈𝑥 = 1 / (1 + ⌉-𝑥)	#R74/M37,R73 -Token
⌈𝑥 = 1 / (1+⌉-𝑥)	#R75/M38,R74 Token+
⌈𝑥 = 1 / 1+⌉-𝑥	#R76/M39,R75 Right space group
stop
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
