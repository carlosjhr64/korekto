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
# Must have balanced (){}[]
? balanced? '(){}[]'
# Can't have two spaces
? !match?(/\s\s/)
# Scans `1.23` | `word` | `%`
! scanner: '[\d\.]+|\w+|.'
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
## About specific tokens
! .Newline /\n/
! .Newline {;}
! .SpaceMaybe /\s*/
! .SpaceMaybe {?}
! .Open /\(/
! .Open {⦅}
! .Close /\)/
! .Close {⦆}
# About tokens
! Token /[\d\.]+|\w+|\S/
! Token {t1 t2 t3 𝟘 𝟙 𝟚 𝟛 𝟜 𝟝 𝟞 𝟟 𝟠 𝟡}
! Decimal /[\d\.]+/
! Decimal {d1 d2 d3 𝒹}
! Word /\w+/
! Word {w1 w2 w3 𝓌}
! Symbol /[^\w\s]/
! Symbol {s1 s2 s3 𝓈}
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
! Type {𝕀 𝕁 𝕂}
## About operators
### Unary
! Unary /[-𝓐-𝓩⌈⌉⌊⌋]/
! Unary {𝓐 𝓑 𝓒}
! Unaries /[-𝓐-𝓩⌈⌉⌊⌋]*/
! Unaries {u1 u2 u3 𝓊}
### Binary
! Binary /[-+*\/∧∨^√𝓪-𝔃]/
! Binary {b1 b2 b3 𝒷}
### Tight
! Tight /[.∧∨^𝓪-𝔃]/
! Tight {^}
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
! Glob /[^\s;]*/
! Glob {x1 x2 x3 𝓍}
## Clump
! .Clump /[^\s;]+/
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
# Member operators
w1{Z1𝟙 𝟚Z2};𝟙₊ : 𝟚	#M7 Next: ₊
w1{Z1𝟙 𝟚Z2};𝟚₋ : 𝟙	#M8 Previous: ₋
# Methods on words
w1{𝟙Z1};w1.first : 𝟙	#M9 : . first
w1{Z1𝟙};w1.last : 𝟙	#M10 : last
w1{𝟙Z1};w2{𝟚Z2};𝟙⁺ : 𝟚	#I11 Raise: ⁺
w1{𝓂 𝟙Z1};w2{𝓂 𝟚Z2};𝟙⁺ : 𝟚	#I12 Raise
w1{𝓂 𝓂 𝟙Z1};w2{𝓂 𝓂 𝟚Z2};𝟙⁺ : 𝟚	#I13 Raise
w1{𝓂 𝓂 𝓂 𝟙Z1};w2{𝓂 𝓂 𝓂 𝟚Z2};𝟙⁺ : 𝟚	#I14 Raise
# Types
Constant[𝖆]	#L15 Constant: Constant
Scalar[𝑎]	#L16 Scalar: Scalar
Vector[𝒂]	#L17 Vector: Vector
Tensor[𝑨]	#L18 Tensor: Tensor
Operator[𝓐]	#L19 Operator: Operator
# Addition and Subtraction
𝟙 + 𝟚 = 𝟛;𝟛 - 𝟚 = 𝟙	#M20 Addition<=>Subraction: + -
𝟛 - 𝟚 = 𝟙;𝟙 + 𝟚 = 𝟛	#M21 Subtraction<=>Addition
𝟙 - 𝟙 = 0	#A22 Zero: 0
𝟙 + 𝟚 = 𝟚 + 𝟙 #A23 Commute+
# Multiplication and Division
𝟚 * 𝟛 = 𝟞;𝟞 / 𝟛 = 𝟚	#M24 Multiplication<=>Division: * /
𝟞 / 𝟛 = 𝟚;𝟚 * 𝟛 = 𝟞	#M25 Division<=>Multiplication
𝟚 / 𝟚 = 1	#A26 One: 1
𝟚 * 𝟛 = 𝟛 * 𝟚	#A27 Commute*
# Exponentiation and Root
𝟚∧𝟛 = 𝟠;𝟠∨𝟛 = 𝟚	#M28 Exponentiation<=>Root: ∧ ∨
𝟠∨𝟛 = 𝟚;𝟚∧𝟛 = 𝟠	#M29 Root<=>Exponentiation
# There's no analogous 𝟛∨𝟛 = N
𝟚∧1 = 𝟚	#A30 x^1=x
𝟚∧0 = 1	#A31 X^0=1
# Square and Square Root
𝟚² = 𝟚 * 𝟚	#A32 Square: ²
𝟚² = 𝟜;√𝟜 = 𝟚	#M33 Square<=>SquareRoot: √
√𝟜 = 𝟚;𝟚² = 𝟜	#M34 SquareRoot<=>Square
# Exponentiation and Logarithm
𝟚∧𝟛 = 𝟠;𝟚𝓵𝟠 = 𝟛	#M35 Exponentiation<=>Logarithm: 𝓵
𝟚𝓵𝟠 = 𝟛;𝟚∧𝟛 = 𝟠	#M36 Logarithm<=>Exponentiation
𝟚𝓵1 = 0	#A37 xl1=0
## Digits
1 - 1 = 0	#T38/A22 Zero
0 + 1 = 1	#R39/M21,T38 Subtraction<=>Addition
1 + 1 : 2	#S40/L1 Equivalent: 2
2 + 1 : 3	#S41/L1 Equivalent: 3
3 + 1 : 4	#S42/L1 Equivalent: 4
4 + 1 : 5	#S43/L1 Equivalent: 5
5 + 1 : 6	#S44/L1 Equivalent: 6
6 + 1 : 7	#S45/L1 Equivalent: 7
7 + 1 : 8	#S46/L1 Equivalent: 8
8 + 1 : 9	#S47/L1 Equivalent: 9
## Show multiplication as repeated addition
𝟙 = t1;𝟙 * 1 = t1	#M48 Single
𝟙 + 𝟙 = 𝟚;𝟙 * 2 = 𝟚	#M49 Double
𝟙 + 𝟙 + 𝟙 = 𝟛;𝟙 * 3 = 𝟛	#M50 Triple
## Show exponentiation as repeated multiplication
𝟚 = t2;𝟚∧1 = t2	#M51 Linear
𝟚 * 𝟚 = 𝟜;𝟚∧2 = 𝟜	#M52 Square
𝟚 * 𝟚 * 𝟚 = 𝟠;𝟚∧3 = 𝟠	#M53 Cube
```
### Spacing
```korekto
S1(u1𝟙 𝒷 u2𝟚)S2;S1(u1𝟙𝒷u2𝟚)S2	#M54 Token.Token
S1(u1𝟙𝒷u2𝟚)S2;S1(u1𝟙 𝒷 u2𝟚)S2	#M55 Token . Token
```
## Groups
```korekto
S1(𝓊𝟙) S2;S1𝓊𝟙 S2	#M56 Token un-groupep
S1(𝓊𝟙);S1𝓊𝟙	#M57 Token$ un-groupep
S1𝓊𝟙 S2;S1(𝓊𝟙) S2	#M58 Token grouped
S1?(q1)?S2;S1 q1 S2	#M59 Space
S1 q1 S2;S1(q1)S2	#M60 Group
S1?(q1);S1 q1	#M61 Right space
S1 q1;S1?(q1)	#M62 Right group
(q1)?S1;q1 S1	#M63 Left space
q1 S1;(q1)?S1	#M64 Left group
N1 = (Q1);N1 = Q1	#M65 =Right space
S1?+?(Q1)?+?S2;S1 + Q1 + S2	#M66 +Space+
S1?+?(Q1);S1 + Q1	#M67 +Space
(Q1)?+?S1;Q1 + S1	#M68 Space+
# Group binding
S1(𝓊𝟙^u2𝟚)S2;S1𝓊𝟙^u2𝟚S2	#M69 Tight binding un-grouped
S1𝓊𝟙^u2𝟚S2;S1(𝓊𝟙^u2𝟚)S2	#M70 Tight binding grouped
```
# Implied/Explicit multiplication
```korekto
S1⦆?⦅S2;S1⦆*⦅S3	#M71 Explicit multiplication
S1⦆*⦅S2;S1⦆?⦅S3	#M72 Implied multiplication
```
## Algebra
```korekto
# Equality
N1 = N2;N2 = N1	#M73 Symmetry
N1 = N1	#A74 Reflection
N1(N2)N3 = N1(𝒩)N3;N2 = 𝒩	#M75 Equivalent groups
# One
S1(𝓊𝟙?/?𝓊𝟙)S2;S1(1)S2	#M76 x/x
S1((Q1)?/?(Q1))S2;S1(1)S2	#M77 (x)/(x)
# *One*
S1?*?1 S2;S1 S2	#M78 *one
S1 1?*?S2;S1 S2	#M79 one*
# (a/b)
S1((Q1)?/?(Q2))S2;S1((Q3)*(Q1) / (Q3)*(Q2))S2	#M80 (xa)/(xb)
S1(Q1)*(1?/?(Q2))S2;S1((Q1)?/?(Q2))S2	#M81 (x*1)/(y)
# Distribute
S1(Q1)*((Q2)?+?(Q3))S2;S1((Q1)*(Q2)?+?(Q1)*(Q3))S2	#M82 Distribute
# Substitution
N1 = N2;S1(N1)S2;S1(N2)S2	#I83 a=b;a->b
N1 = N2;S1(N2)S2;S1(N1)S2	#I84 a=b;b->a
# Adding
S1(u1𝟙?+?-u2𝟚)S2;S1(u1𝟙?-?u2𝟚)S2	#M85 a+-b=a-b
S1(u1𝟙?-?u2𝟚)S2;S1(u1𝟙?+?-u2𝟚)S2	#M86 a-b=a+-b
S1𝓊𝟙∧u2𝟚*𝓊𝟙∧u3𝟛S2;S1𝓊𝟙∧(u2𝟚?+?u3𝟛)S2	#M87 a^b*a^c=a^(b+c)
S1𝓊𝟙∧(u2𝟚?+?u3𝟛)S2;S1𝓊𝟙∧u2𝟚*𝓊𝟙∧u3𝟛S2	#M88 a^(b+c)=a^b*a^c
```
