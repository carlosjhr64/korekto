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
* Mathematical script small Latin: `𝓌`
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
! Constant {C1 C2 C3 𝖆 𝖇 𝖈}
### Scalar
#### Using R for "Real"
! Scalar /[𝑎-𝑧]/
! Scalar {R1 R2 R3 𝑎 𝑏 𝑐}
### Vector
! Vector /[𝒂-𝒛]/
! Vector {V1 V2 V3 𝒂 𝒃 𝒄}
### Tensor
#### Using M for "Matrix"
! Tensor /[𝑨-𝒁]/
! Tensor {M1 M2 M3 𝑨 𝑩 𝑪}
### Set
! Set /[𝕒-𝕫]/
! Set {S1 S2 S3 𝕒 𝕓 𝕔}
### Type
! Type /[𝔸-𝕐]/
! Type {T1 T2 T3 𝔸 𝔹}
## About operators
### Unary
! Unary /[-𝓐-𝓩⌈⌉⌊⌋]/
! Unary {U1 U2 U3 𝓐 𝓑 𝓒}
! Unaries /[-𝓐-𝓩⌈⌉⌊⌋]*/
! Unaries {u1 u2 u3 𝓊}
### Binary
! Binary /[-+*\/∧∨^√𝓪-𝔃]/
! Binary {B1 B2 B3 𝒷}
! Commutative /[+*]/
! Commutative {c1 c2 c3 𝒸}
## About superscripts and subscripts
! Superscript /[ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻ]/
! Superscript {j1 j2 j3 ⁱ ʲ ᵏ}
! Subscript /[ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ]/
! Subscript {i1 i2 i3 ᵢ ⱼ ₖ}
# About groups
## Group
#### Using q here because g is missing
! Group /[^()]*/
! Group {Q1 Q2 Q3 𝓆}
## Elements
##### Using z here because e is missing
! Elements /[^{}]*/
! Elements {Z1 Z2 Z3 𝓏}
## Parameters
! Parameters /[^\[\]]*/
! Parameters {P1 P2 P3 𝓅}
# About slurps
## Slurp
#### Using l because s was used by Symbol
! Slurp /[^;]*/
! Slurp {L1 L2 L3 𝓁}
## Span
#### Using n because s and p was used by Symbol and Parameters
! Span /[^:=;]*/
! Span {N1 N2 N3 𝓃}
## Glob
#### Using x because g and o are missing, and b was used by Binary
! Glob /\S*/
! Glob {X1 X2 X3 𝓍}
## Clump
#### Using m because c,l,m,p are used being used above.
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
# Groups
L1 Q1 L2;L1(Q1)L2	#M6 Space group: ( )
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
## Algebra
```korekto
N1 = N2;N2 = N1	#M29 Symetry
N1 = N1	#A30 Reflection
stop
# Implied multiplication
Slurp1*𝓊𝟙Slurp2;Slurp1𝓊𝟙Slurp2	#M31 Implied multiplication
# Groups
Slurp1(𝓊𝟙)Slurp2;Slurp1𝓊𝟙Slurp2	#M32 Token
Slurp1(𝟙 𝒷 𝓊𝟚)Slurp2;Slurp1(𝟙𝒷𝓊𝟚)Slurp2	#M33 Token*Token
Slurp1 (Group1);Slurp1 Group1	#M34 Right space group
(Group1) Slurp1;Group1 Slurp1	#M35 Left speace group
Slurp1 Group1 Slurp2;Slurp1 (Group1) Slurp2	#M36 Group
# Algebra
Slurp1 (Group1) / (Group2);Slurp1 𝓊𝟙(Group1) / 𝓊𝟙(Group2)	#M37 Multiplying by x/x
Slurp1𝟙(1)Slurp2;Slurp1𝟙Slurp2	#M38 Multiplying by one
Slurp1*1 Slurp2;Slurp1 Slurp2	#M39 Multiplying by one
Slurp1𝓊𝟙(Group1 + Group2)Slurp2;Slurp1(𝓊𝟙*Group1 + 𝓊𝟙*Group2)Slurp2	#M40 Distribute
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
