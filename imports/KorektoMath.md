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
? length < 66
! scanner: '\w+|.'
```
## Patterns
```korekto
# About tokens
! Token /\w+|\S/
! Token {𝟙 𝟚 𝟛 𝟜 𝟝 𝟞 𝟟 𝟠 𝟡}
! Word /\w+/
! Word {Word1 Word2 Word3 Word4}
! Symbol /[^\w\s]/
! Symbol {𝛾 𝛿 𝜀}
## About specific tokens
! .Newline /\n/
! .Newline {;}
## About token types
! Constant /[𝖆-𝖟]/
! Constant {𝖆 𝖇 𝖈 𝖉}
! Scalar /[𝑎-𝑧]/
! Scalar {𝑎 𝑏 𝑐 𝑑}
! Vector /[𝒂-𝒛]/
! Vector {𝒂 𝒃 𝒄 𝒅}
! Tensor /[𝑨-𝒁]/
! Tensor {𝑨 𝑩 𝑪 𝑫}
! FiniteSet /[𝕒-𝕫]/
! FiniteSet {𝕒 𝕓 𝕔 𝕕}
# About operators
! Unary /[-𝓐-𝓩⌈⌉⌊⌋]/
! Unary {𝓐 𝓑 𝓒 𝓓}
! Unaries /[-𝓐-𝓩⌈⌉⌊⌋]*/
! Unaries {𝓾}
! Binary /[-+*\/∧∨^√𝓪-𝔃]/
! Binary {𝓫}
! Commutative /[+*]/
! Commutative {𝓬}
## About superscripts and subscripts
! Superscript /[ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻ]/
! Superscript {ᵃ ᵇ ᶜ ᵈ ᵉ ᶠ ᵍ ʰ ⁱ ʲ ᵏ ˡ ᵐ ⁿ ᵒ ᵖ ʳ ˢ ᵗ ᵘ ᵛ ʷ ˣ ʸ ᶻ}
! Subscript /[ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ]/
! Subscript {ₐ ₑ ₕ ᵢ ⱼ ₖ ₗ ₘ ₙ ₒ ₚ ᵣ ₛ ₜ ᵤ ᵥ ₓ}
# About groups
! Group /[^()]*/
! Group {Group1 Group2 Group3 Group4}
! Elements /[^{}]*/
! Elements {Elements1 Elements2 Elements3 Elements4}
! Parameters /[^\[\]]*/
! Parameters {Parameters1 Parameters2 Parameters3 Parameters4}
# About slurps
! Slurp /[^;]*/
! Slurp {Slurp1 Slurp2 Slurp3 Slurp4}
! Span /[^:=;]*/
! Span {Span1 Span2 Span3 Span4}
! Glob /\S*/
! Glob {Glob1 Glob2 Glob3 Glob4}
! .Clump /\S+/
! .Clump {𝟘}
```
## Rules
```korekto
# Equivalence
Span1 : Span2	#L1 Equivalent:   :
Span1 : Span2;Span1 = Span2	#M2 If equivalent, then equal: =
Span1 = Span2;Span2 = Span1	#M3 Reflection
# Sets
Word1{Elements1}	#L4 Named set: { }
Word1{Elements1𝟙Elements2};Word1[𝟙]	#M5 Membership: [ ]
Word1[𝟙];𝟙 ∍ Word1	#M6 Element of: ∍
# Methods
Word1.Word2 = (Word1.Word2)	#A7 Dot binds: . ( )
# Member operators
Word1{Elements1𝟙 𝟚Elements2};𝟙₊ : 𝟚	#M8 Next: ₊
Word1{Elements1𝟙 𝟚Elements2};𝟚₋ : 𝟙	#M9 Previous: ₋
Word1{𝟙Elements1};Word1.first : 𝟙	#M10 : first
Word1{Elements1𝟙};Word1.last : 𝟙	#M11 : last
Word1{𝟙Elements1};Word2{𝟚Elements2};𝟙⁺ : 𝟚	#I12 Raise: ⁺
Word1{𝟘 𝟙Elements1};Word2{𝟘 𝟚Elements2};𝟙⁺ : 𝟚	#I13 Raise
Word1{𝟘 𝟘 𝟙Elements1};Word2{𝟘 𝟘 𝟚Elements2};𝟙⁺ : 𝟚	#I14 Raise
Word1{𝟘 𝟘 𝟘 𝟙Elements1};Word2{𝟘 𝟘 𝟘 𝟚Elements2};𝟙⁺ : 𝟚	#I15 Raise
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
𝑎*𝑏 = 𝑎𝑏	#A29 Implied scalar multiplication
# Groups
Slurp1(𝓾𝟙)Slurp2;Slurp1𝓾𝟙Slurp2	#M30 Token
Slurp1(𝟙 𝓫 𝓾𝟚)Slurp2;Slurp1(𝟙𝓫𝓾𝟚)Slurp2	#M31 Token*Token
Slurp1 (Group1);Slurp1 Group1	#M32 Right group
(Group1) Slurp1;Group1 Slurp1	#M33 Left group
```
## Introductions
```korekto
# Digits
1+1 : 2	#S34/L1 Equivalent: 2
2+1 : 3	#S35/L1 Equivalent: 3
3+1 : 4	#S36/L1 Equivalent: 4
4+1 : 5	#S37/L1 Equivalent: 5
5+1 : 6	#S38/L1 Equivalent: 6
6+1 : 7	#S39/L1 Equivalent: 7
7+1 : 8	#S40/L1 Equivalent: 8
8+1 : 9	#S41/L1 Equivalent: 9
```
