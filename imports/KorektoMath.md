# Korekto Math

This is Korekto's standard math import.

## Ruby Monkey Patches

* Provides `balanced?`
```korekto
::Array#blp(k,m) = (m==0)?self<<k:(k==last)?self[0..-2]:self<<k
::Array#bli      = inject([]){|a,km| a.blp(*km)}
::Array#blm(g)   = map{|c| g.index(c).divmod(2)}
::Array#bls(g)   = select{|c| g.include?(c)}
::String#balance(g)   = chars.bls(g).blm(g).bli
::String#balanced?(g) = balance(g).empty?
```
## Syntax
```korekto
? balanced? '(){}[]'
! scanner: '\w+|.'
```
## Patterns

With some exceptions, there are three types of keys:

* Numbered Latin ASCII keys: `W1 W2 W3`
  * lower case will not match spaces
  * upper case may match spaces
* Mathematical script small Latin: `𝓌`
  * lower case will no match spaces
  * upper case may match spaces
* Representative `ABC`

```korekto
# About tokens
! Token /\w+|\S/
! Token {t1 t2 t3 𝟘 𝟙 𝟚 𝟛 𝟜 𝟝 𝟞 𝟟 𝟠 𝟡}
! Word /\w+/
! Word {w1 w2 w3 𝓌}
! Symbol /[^\w\s]/
! Symbol {s1 s2 s3 𝓈}
## About specific tokens
! .Newline /\n/
! .Newline {;}
## About token types
### Constant
! Constant /[𝖆-𝖟]/
! Constant {𝖆 𝖇 𝖈}
### Scalar
! Scalar /[𝑎-𝑧]/
! Scalar {𝑎 𝑏 𝑐}
### Vector
! Vector /[𝒂-𝒛]/
! Vector {𝒂 𝒃 𝒄}
### Tensor
! Tensor /[𝑨-𝒁]/
! Tensor {𝑨 𝑩 𝑪}
### Set
! Set /[𝕒-𝕫]/
! Set {𝕒 𝕓 𝕔}
### Type
! Type /[𝔸-𝕐]/
! Type {𝔸 𝔹}
## About operators
### Unary
! Unary /[-𝓐-𝓩⌈⌉⌊⌋]/
! Unary {𝓐 𝓑 𝓒}
! Unaries /[-𝓐-𝓩⌈⌉⌊⌋]*/
! Unaries {u1 u2 u3 𝓊}
### Binary
! Binary /[-+*\/∧∨^√𝓪-𝔃]/
! Binary {b1 b2 b3 𝒷}
! Commutative /[+*]/
! Commutative {c1 c2 c3 𝒸}
## About superscripts and subscripts
! Superscript /[ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻ]/
! Superscript {ⁱ ʲ ᵏ}
! Subscript /[ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ]/
! Subscript {ᵢ ⱼ ₖ}
# About groups
## Group
! Group /[^()]+/
! Group {Q1 Q2 Q3 𝒬}
! GroupGlob /[^()\s]+/
! GroupGlob {q1 q2 q3 𝓆}
## Elements
! Elements /[^{}]*/
! Elements {Z1 Z2 Z3 𝒵}
## Parameters
! Parameters /[^\[\]]+/
! Parameters {P1 P2 P3 𝒫}
# About slurps
## Slurp
! Slurp /[^;]*/
! Slurp {S1 S2 S3 𝒮}
## Span
! Span /[^:=;]*/
! Span {N1 N2 N3 𝒩}
## Glob
! Glob /\S*/
! Glob {X1 X2 X3 𝓍}
## Clump
! .Clump /\S+/
! .Clump {m0 𝓂}
```
## Definitions
```korekto
# Equivalence
N1 : N2	#L1 Equivalent:   :
N1 : N2;N1 = N2	#M2 If equivalent, then equal: =
# Sets
w1{Z1}	#L3 Named set: { }
w1{Z1𝟙Z2};w1[𝟙]	#M4 Membership: [ ]
w1[𝟙];𝟙 ∍ w1	#M5 Element of: ∍
# Group
N1 : (N1)	#A6 Group: ( )
# Methods
w1.w2 = (w1.w2)	#A7 Dot binds: .
# Member operators
w1{Z1𝟙 𝟚Z2};𝟙₊ : 𝟚	#M8 Next: ₊
w1{Z1𝟙 𝟚Z2};𝟚₋ : 𝟙	#M9 Previous: ₋
w1{𝟙Z1};w1.first : 𝟙	#M10 : first
w1{Z1𝟙};w1.last : 𝟙	#M11 : last
w1{𝟙Z1};w2{𝟚Z2};𝟙⁺ : 𝟚	#I12 Raise: ⁺
w1{𝓂 𝟙Z1};w2{𝓂 𝟚Z2};𝟙⁺ : 𝟚	#I13 Raise
w1{𝓂 𝓂 𝟙Z1};w2{𝓂 𝓂 𝟚Z2};𝟙⁺ : 𝟚	#I14 Raise
w1{𝓂 𝓂 𝓂 𝟙Z1};w2{𝓂 𝓂 𝓂 𝟚Z2};𝟙⁺ : 𝟚	#I15 Raise
# Types
Constant[𝖆]	#L16 Constant: Constant
Scalar[𝑎]	#L17 Scalar: Scalar
Vector[𝒂]	#L18 Vector: Vector
Tensor[𝑨]	#L19 Tensor: Tensor
Operator[𝓐]	#L20 Operator: Operator
# Multiplication and Division
𝟚 * 𝟛 = 𝟞;𝟞 / 𝟛 = 𝟚	#M21 Multiplication-Division: * /
𝟞 / 𝟛 = 𝟚;𝟚 * 𝟛 = 𝟞	#M22 Multiplication-Division
𝟙 / 𝟙 = 1	#A23 Multiplicative identity: 1
1 / 1 = 1	#T24/A23 Multiplicative identity
q1 / q1 = 1	#A25/T24 a/a=1
𝟙² : 𝟙 * 𝟙	#A26 Square: ²
# Addition and Subtraction
𝟙 + 𝟚 = 𝟛;𝟛 - 𝟚 = 𝟙	#M27 Adition-Subraction: + -
𝟛 - 𝟚 = 𝟙;𝟙 + 𝟚 = 𝟛	#M28 Adition-Subraction
𝟙 - 𝟙 = 0	#A29 Additive identity: 0
1 - 1 = 0	#T30/A29 Additive identity
q1 - q1 = 0	#A31/T30 a-a=0
# Digits
1+1 : 2	#S32/L1 Equivalent: 2
2+1 : 3	#S33/L1 Equivalent: 3
3+1 : 4	#S34/L1 Equivalent: 4
4+1 : 5	#S35/L1 Equivalent: 5
5+1 : 6	#S36/L1 Equivalent: 6
6+1 : 7	#S37/L1 Equivalent: 7
7+1 : 8	#S38/L1 Equivalent: 8
8+1 : 9	#S39/L1 Equivalent: 9
# Exponentiation, Roots, and Logarithm
𝟚∧𝟛 = 𝟠;𝟠∨𝟛 = 𝟚	#M40 Exponentiation-Root: ∧ ∨
𝟚² = 𝟜;√𝟜 = 𝟚	#M41 Square Root: √
# Logarithms
𝟚∧𝟛 = 𝟠;𝟚𝓵𝟠 = 𝟛	#M42 Exponentiation-Logarithm: 𝓵
𝟚𝓵𝟠 = 𝟛;𝟚∧𝟛 = 𝟠	#M43 Exponentiation-Logarithm
(N1)∧(N2) = N3;(N1)𝓵(N3) = N2	#M44 By defintion of 𝓵
(N1)𝓵(N3) = N2;(N1)∧(N2) = N3	#M45 By defintion of 𝓵
```
### Implied multiplication
```korekto
S1*𝓊𝟙S2;S1𝓊𝟙S2	#M46 *Token
S1(q1)(q2)S2;S1(q1 * q2)S2	#M47 Group*Group
```
### Spacing
```korekto
S1(u1𝟙 𝒷 u2𝟚)S2;S1(u1𝟙𝒷u2𝟚)S2	#M48 Token.Token
```
## Groups
```korekto
# Group/Space
S1(𝓊𝟙)S2;S1𝓊𝟙S2	#M49 Token un-groupep
S1𝓊𝟙S2;S1(𝓊𝟙)S2	#M50 Token grouped
S1(q1);S1 q1	#M51 Right space
S1 q1;S1(q1)	#M52 Right group
(q1)S1;q1 S1	#M53 Seft space
q1 S1;(q1)S1	#M54 Seft group
S1(q1)S2;S1 q1 S2	#M55 Context space
S1 q1 S2;S1(q1)S2	#M56 Context group
# Group binding
S1(𝓊𝟙∧u2𝟚)S2;S1𝓊𝟙∧u2𝟚S2	#M57 Tight binding
S1𝓊𝟙∧u2𝟚S2;S1(𝓊𝟙∧u2𝟚)S2	#M58 Tight binding
```
## Algebra
```korekto
# Equality
N1 = N2;N2 = N1	#M59 Symetry
N1 = N1	#A60 Reflection
N1(N2)N3 = N1(𝒩)N3;N2 = 𝒩	#M61 Equivalent groups
# Multiplication by one
S1(q1)*(1 / q2)S2;S1(q1 / q2)S2	#M62 x*(1/y)=(x/y)
S1 (Q1) / (Q2);S1 𝓊𝟙(Q1) / 𝓊𝟙(Q2)	#M63 (x/x)*
S1*1 S2;S1 S2	#M64 *one
S1 1*S2;S1 S2	#M65 one*
S1*1*S2;S1*S2	#M66 *one*
S1𝟙(1)S2;S1𝟙S2	#M67 Token(one)
S1(1)𝟙S2;S1𝟙S2	#M68 (one)Token
S1(Q1)(1)S2;S1(Q1)S2	#M69 Group(one)
S1(1)(Q1)S2;S1(Q1)S2	#M70 (one)Group
# Distribute
S1𝓊𝟙(X1 + X2)S2;S1(𝓊𝟙 X1 + 𝓊𝟙 X2)S2	#M71 Distribute
# Substitution
𝓊𝟙 = N1;S1𝓊𝟙S2;S1(N1)S2	#I72 Group substitutes token
N1 = 𝓊𝟙;S1𝓊𝟙S2;S1(N1)S2	#I73 Group substitutes token
𝓊𝟙 = N1;S1(N1)S2;S1𝓊𝟙S2	#I74 Token substitutes group
N1 = 𝓊𝟙;S1(N1)S2;S1𝓊𝟙S2	#I75 Token substitutes group
N1 = N2;S1(N2)S2;S1(N1)S2	#I76 Group substitutes group
N2 = N1;S1(N2)S2;S1(N1)S2	#I77 Group substitutes group
N1 = N2;S1 N2;S1 N1	#I78 Group substitutes left
N2 = N1;S1 N2;S1 N1	#I79 Group substitutes left
# Adding
S1(𝟙 + -𝟚)S2;S1(𝟙 - 𝟚)S2	#M80 Adding a negative
S1(𝟙 - 𝟚)S2;S1(𝟙 + -𝟚)S2	#M81 Adding a negative
S1𝓊𝟙∧u2𝟚*𝓊𝟙∧u3𝟛S2;S1𝓊𝟙∧(u2𝟚 + u3𝟛)S2	#M82 Adding exponents to common base
S1𝓊𝟙∧(u2𝟚 + u3𝟛)S2;S1𝓊𝟙∧u2𝟚*𝓊𝟙∧u3𝟛S2	#M83 Adding exponents to common base
```
