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
𝟙 / 𝟙 = 1	#A22 Multiplicative identity: 1
1 / 1 = 1	#T23/A22 Multiplicative identity
q1 / q1 = 1	#A24/T23 a/a=1
𝟙² : 𝟙 * 𝟙	#A25 Square: ²
# Addition and Subtraction
𝟙 + 𝟚 = 𝟛;𝟛 - 𝟚 = 𝟙	#M26 Adition-Subraction: + -
𝟙 - 𝟙 = 0	#A27 Additive identity: 0
1 - 1 = 0	#T28/A27 Additive identity
q1 - q1 = 0	#A29/T28 a-a=0
# Exponentiation, Roots, and Logarithm
𝟚∧𝟛 = 𝟠;𝟠∨𝟛 = 𝟚	#M30 Exponentiation-Root: ∧ ∨
𝟚² = 𝟜;√𝟜 = 𝟚	#M31 Square Root: √
# Logarithms
𝟚∧𝟛 = 𝟠;𝟚𝓵𝟠 = 𝟛	#M32 Exponentiation-Logarithm: 𝓵
```
### Implied multiplication
```korekto
S1*𝓊𝟙S2;S1𝓊𝟙S2	#M33 *Token
S1(q1)(q2)S2;S1(q1 * q2)S2	#M34 Group*Group
```
### Spacing
```korekto
S1(u1𝟙 𝒷 u2𝟚)S2;S1(u1𝟙𝒷u2𝟚)S2	#M35 Token.Token
```
## Groups
```korekto
# Group/Space
S1(𝓊𝟙)S2;S1𝓊𝟙S2	#M36 Token ungroup
S1𝓊𝟙S2;S1(𝓊𝟙)S2	#M37 Token group
S1(q1);S1 q1	#M38 Right space
S1 q1;S1(q1)	#M39 Right group
(q1)S1;q1 S1	#M40 Seft space
q1 S1;(q1)S1	#M41 Seft group
S1(q1)S2;S1 q1 S2	#M42 Context space
S1 q1 S2;S1(q1)S2	#M43 Context group
# Group binding
S1(𝓊𝟙∧u2𝟚)S2;S1𝓊𝟙∧u2𝟚S2	#M44 Tight binding
S1𝓊𝟙∧u2𝟚S2;S1(𝓊𝟙∧u2𝟚)S2	#M45 Tight binding
```
## Algebra
```korekto
# Equality
N1 = N2;N2 = N1	#M46 Symetry
N1 = N1	#A47 Reflection
# Multiplication by one
S1(q1)*(1 / q2)S2;S1(q1 / q2)S2	#M48 x*(1/y)=(x/y)
S1 (Q1) / (Q2);S1 𝓊𝟙(Q1) / 𝓊𝟙(Q2)	#M49 (x/x)*
S1*1 S2;S1 S2	#M50 *one
S1 1*S2;S1 S2	#M51 one*
S1*1*S2;S1*S2	#M52 *one*
S1𝟙(1)S2;S1𝟙S2	#M53 Token(one)
S1(1)𝟙S2;S1𝟙S2	#M54 (one)Token
S1(Q1)(1)S2;S1(Q1)S2	#M55 Group(one)
S1(1)(Q1)S2;S1(Q1)S2	#M56 (one)Group
# Distribute
S1𝓊𝟙(X1 + X2)S2;S1(𝓊𝟙 X1 + 𝓊𝟙 X2)S2	#M57 Distribute
# Substitution
𝓊𝟙 = N1;S1𝓊𝟙S2;S1(N1)S2	#I58 Group substitutes token
N1 = 𝓊𝟙;S1𝓊𝟙S2;S1(N1)S2	#I59 Group substitutes token
𝓊𝟙 = N1;S1(N1)S2;S1𝓊𝟙S2	#I60 Token substitutes group
N1 = N1;S1(N1)S2;S1𝓊𝟙S2	#I61 Token substitutes group
N1 = N2;S1(N2)S2;S1(N1)S2	#I62 Group substitutes group
N1 = N2;S1(N1)S2;S1(N2)S2	#I63 Group substitutes group
# Adding
S1(𝟙 + -𝟚)S2;S1(𝟙 - 𝟚)S2	#M64 Adding a negative
S1(𝟙 - 𝟚)S2;S1(𝟙 + -𝟚)S2	#M65 Adding a negative
S1𝓊𝟙∧u2𝟚*𝓊𝟙∧u3𝟛S2;S1𝓊𝟙∧(u2𝟚 + u3𝟛)S2	#M66 Adding exponents to common base
S1𝓊𝟙∧(u2𝟚 + u3𝟛)S2;S1𝓊𝟙∧u2𝟚*𝓊𝟙∧u3𝟛S2	#M67 Adding exponents to common base
```
## Introductions
```korekto
# Digits
1+1 : 2	#S68/L1 Equivalent: 2
2+1 : 3	#S69/L1 Equivalent: 3
3+1 : 4	#S70/L1 Equivalent: 4
4+1 : 5	#S71/L1 Equivalent: 5
5+1 : 6	#S72/L1 Equivalent: 6
6+1 : 7	#S73/L1 Equivalent: 7
7+1 : 8	#S74/L1 Equivalent: 8
8+1 : 9	#S75/L1 Equivalent: 9
```
