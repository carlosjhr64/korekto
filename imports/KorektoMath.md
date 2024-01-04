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
```
### Implied multiplication
```korekto
S1*𝓊𝟙S2;S1𝓊𝟙S2	#M29 *Token
```
### Spacing
```korekto
S1(u1𝟙 𝒷 u2𝟚)S2;S1(u1𝟙𝒷u2𝟚)S2	#M30 Token.Token
```
## Groups
```korekto
# Group/Space
S1(𝓊𝟙)S2;S1𝓊𝟙S2	#M31 Token ungroup
S1𝓊𝟙S2;S1(𝓊𝟙)S2	#M32 Token group
S1(q1);S1 q1	#M33 Right space
S1 q1;S1(q1)	#M34 Right group
(q1)S1;q1 S1	#M35 Seft space
q1 S1;(q1)S1	#M36 Seft group
S1(q1)S2;S1 q1 S2	#M37 Context space
S1 q1 S2;S1(q1)S2	#M38 Context group
```
## Algebra
```korekto
# Equality
N1 = N2;N2 = N1	#M39 Symetry
N1 = N1	#A40 Reflection
# Multiplication by one
S1 (Q1) / (Q2);S1 𝓊𝟙(Q1) / 𝓊𝟙(Q2)	#M41 (x/x)*
S1𝟙(1)S2;S1𝟙S2	#M42 Token(one)
S1(1)𝟙S2;S1𝟙S2	#M43 (one)Token
S1*1 S2;S1 S2	#M44 *one
S1 1*S2;S1 S2	#M45 one*
S1*1*S2;S1*S2	#M46 *one*
# Distribute
S1𝓊𝟙(X1 + X2)S2;S1(𝓊𝟙 X1 + 𝓊𝟙 X2)S2	#M47 Distribute
# Substitution
stop
𝓊𝟙 = Group1;Slurp1𝓊𝟙Slurp2;Slurp1(Group1)Slurp2	#I41 Token substitutes Group
Group1 = 𝓊𝟙;Slurp1(Group1)Slurp2;Slurp1𝓊𝟙Slurp2	#I42 Group substitutes Token
Group1 = Group2;Slurp1(Group1)Slurp2;Slurp1(Group2)Slurp2	#I43 Group substitutes Group
Span1 = 𝓊𝟙;Slurp1(Span1)Slurp2;Slurp1𝓊𝟙Slurp2	#I44 Token substitutes Span
Slurp1(𝟙∧𝓊𝟚)Slurp2;Slurp1𝟙∧𝓊𝟚Slurp2	#M45 Tight binding
Slurp1𝟙∧𝓊𝟚Slurp2;Slurp1(𝟙∧𝓊𝟚)Slurp2	#M46 Tight binding
Slurp1𝟙∧𝟚𝟙∧𝓊𝟛Slurp2;Slurp1𝟙∧(𝟚 + 𝓊𝟛)Slurp2	#M47 Adding exponents to common base
Slurp1𝟙∧(𝟚 + 𝓊𝟛)Slurp2;Slurp1𝟙∧𝟚𝟙∧𝓊𝟛Slurp2	#M48 Adding exponents to common base
Slurp1(𝟙 + -𝟚)Slurp2;Slurp1(𝟙 - 𝟚)Slurp2	#M49 Adding a negative
Slurp1(𝟙-𝟚)Slurp2;Slurp1(𝟙 + -𝟚)Slurp2	#M50 Adding a negative
Slurp1(Group1)(Group2)Slurp2;Slurp1(Group1*Group2)Slurp2	#M51 Group*Group
Slurp1𝓊𝟙Slurp2;Slurp1(𝓊𝟙)Slurp2	#M52 Grouping Token
Slurp1(Group1)*(1)Slurp2;Slurp1(Group1)Slurp2	#M53 Identity
```
## Introductions
```korekto
# Digits
1+1 : 2	#S54/L1 Equivalent: 2
2+1 : 3	#S55/L1 Equivalent: 3
3+1 : 4	#S56/L1 Equivalent: 4
4+1 : 5	#S57/L1 Equivalent: 5
5+1 : 6	#S58/L1 Equivalent: 6
6+1 : 7	#S59/L1 Equivalent: 7
7+1 : 8	#S60/L1 Equivalent: 8
8+1 : 9	#S61/L1 Equivalent: 9
stop
Q1 - Q2 = 0	#A25
Q1 / Q1 = 1	#A28 a/a=1
```
