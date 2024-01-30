# Korekto Math

* Imports [KorektoKernel](KorektoKernel.md)
* Imported by [Neuronet](../examples/Neuronet.md)

## Contents

* [Notes](#Notes)
* [Ruby patches](#Ruby-patches)
* [Syntax](#Syntax)
* [Patterns](#Patterns)
* [Definitions](#Defintions)
* [Grouping](#Grouping)
* [Algebra](#Algebra)

## Notes

### Factorial

I'm treating the factorial symbol `!` like a superscript.
I think it'll work well thought of as an exponent.

### Character classes

To keep the list of unary operators up-to-date,
edit the following vim command with the full operator list and run it:

* `:g/^[!|]/s/\[-𝓐[^\]]*\]/[-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋]/g`

To keep the list of subscripts up-to-date,
edit the following vim command with the full subscript list and run it:

* `:g/^[!|]/s/\[₀[^\]]*\]/[₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓᵦᵧᵨᵩᵪ]/g`

To keep the list of superscripts up-to-date,
edit the following vim command with the full superscript list and run it:

* `:g/^[!|]/s/\[⁰[^\]]*\]/[⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡ!]/g`

### Pattern keys

Several styles are used for keys:

* Numbered Latin ASCII keys: `W1 W2 W3`
  * lower case will not match spaces
  * upper case may match spaces
  * used for `+` or `*` patterns
* [Mathematical Unicode](https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode)
  * Representative `ABC`
  * Mathematical numbers
    * used for tokens
  * Mathematical script small Latin: `𝒶 𝒷 𝒸`
    * used for symbols
    * used to provide an alternate key
* [Miscellaneous Symbols](https://en.wikipedia.org/wiki/Miscellaneous_Symbols)
  * used for binary operators and space
* And then some of the obvious keys

Pattern key table:

| Name | Match | Keys | Character type  |
|------|:----:|-------|-----------------|
| [Special](#Special) |
| .Newline | \n | ; | ASCII |
| SpaceMaybe | \s? | ♭ ♮ ♯ | Miscellaneous Symbols |
| .Open | \\( | ⦅ | Symbols-B |
| .Close | \\) | ⦆ | Symbols-B |
| [Token](#Token) |
| Decimal | \d[\d\.]* | d1 d2 d3 𝒹 | ASCII |
| Word | \w+ | w1 w2 w3 𝓌 | ASCII |
| Symbol | [^\w\s] | 𝒶 𝒷 𝒸 | Script Small |
| Token | Decimal,Word,Symbol | 𝟣 𝟤 𝟥 𝟦 𝟧 𝟨 𝟩 𝟪 𝟫 𝓅 𝓆 𝓇 | Sans-Serif |
| [Type](#Type) |
| Constant | [𝕬-𝖟] | 𝖆 𝖇 𝖈 | Bold-Fraktur |
| Scalar | [𝑎-𝑧]| 𝑎 𝑏 𝑐 | Italic Small |
| Vector | [𝒂-𝒛] | 𝒂 𝒃 𝒄 | Bold Italic Small |
| Tensor | [𝑨-𝒁] | 𝑨 𝑩 𝑪 | Bold Italic Capitol |
| Set | [𝕒-𝕫] | 𝕒 𝕓 𝕔 | Double-Struck small |
| Type | [𝔸-𝕐ℂℍℕℙℚℝℤ] | 𝔸 𝔹 ℂ | Double-Struck Capitol |
| [Operator](#Operator) |
| Unary | [-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋] | 𝓐 𝓑 𝓒 | Bold Script Capitol |
| Unaries | Unary* | 𝓉 𝓊 𝓋 | Script Small |
| Tight | [∨∧𝓵] | ♩ ♪ | Miscellaneous Symbols |
| .NotTight | (?![∨∧𝓵]) | ⚑ | Miscellaneous Symbols |
| Associative Binaries: |
| Binary | [-+/*] | ♣ ♥ ♦ | Miscellaneous Symbols |
| MultDiv | [/*] | ♝ ♛ ♚ | Miscellaneous Symbols |
| AddSub | [-+] | ⚀ ⚁ ⚂ ± | Miscellaneous Symbols |
| Loose | [-+\<\>=≠≤≥] | ⚌ ⚍ ⚎ ⚏ | Miscellaneous Symbols |
| [Label](#Label) |
| Superscript | [⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡ!] | ⁱ ʲ ᵏ | Latin superscript |
| Subscript | [₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓᵦᵧᵨᵩᵪ] | ᵢ ⱼ ₖ | Latin subscript |
| [Group](#Group) |
| Group | (?:[^()]\|\([^()]*\))+ | G1 G2 G3 | ASCII |
| GroupGlob | (?:[^()\s]\|\([^()]*\))+ | g1 g2 g3 | ASCII |
| Elements | [^{}]* | E1 E2 E3 | ASCII |
| Parameters | [^\[\]]+ | P1 P2 P3 | ASCII |
| [Slurp](#Slurp) |
| Slurp | [^;]* | S1 S2 S3 S4 | ASCII |
| Glob | [^\s;]* | s1 s2 s3 | ASCII |
| Span | [^:=;]* | N1 N2 N3 | ASCII |
| .Clump | \S+ | 𝓂 | Script small|
| [SuperToken](#SuperToken) |
| SuperToken | Unary*(Token|Group)Subscript*Superscript* | 𝟭 𝟮 𝟯 𝟰 𝟱 𝟲 𝟳 𝟴 𝟵 𝓍 𝓎 𝓏 | Sans-Serif Bold |

## Ruby patches

[KorektoKernel](../imports/KorektoKernel.md) provides: `balanced?`, `tight?`, `ltight?`
```korekto
< imports/KorektoKernel.md
```
## Syntax
```korekto
# Scans `1.23` | `word` | `%`
! scanner: '(?:\d[\d\.]*)|\w+|.'
# Must have balanced (){}[]
? balanced? '(){}[]'
# Exponentiation, root, and log are tight
? tight?('∧', '∨', '𝓵')
# Factorial is left tight
? ltight?('!')
# Parenthesis are (l/r)tight
? ltight?(')')
? rtight?('(')
# Can't have two spaces or have tabs
? !(include?('  ') || include?("\t"))
# Consistent spacing around binary operators
? !match?(%r{\S[-+/*]\s}) && !match?(%r{\s[+/*]\S})
```
## Patterns

### Special
```korekto
! .Newline /\n/
! .Newline {;}
! .SpaceMaybe /\s?/
! .SpaceMaybe {♭ ♮ ♯}
# To avoid the balanced ")(" check
! .Open /\(/
! .Open {⦅}
! .Close /\)/
! .Close {⦆}
```
### Token
```korekto
! Decimal /\d[\d\.]*/
! Decimal {d1 d2 d3 𝒹}
! Word /\w+/
! Word {w1 w2 w3 𝓌}
! Symbol /[^\w\s]/
! Symbol {𝒶 𝒷 𝒸}
# Token will use Mathematical Sans-Serift digits
! Token /\d[\d\.]*|\w+|\S/
! Token {𝟣 𝟤 𝟥 𝟦 𝟧 𝟨 𝟩 𝟪 𝟫 𝓅 𝓆 𝓇}
```
### Type
```korekto
! Constant /[𝕬-𝖟]/
! Constant {𝖆 𝖇 𝖈}
! Scalar /[𝑎-𝑧]/
! Scalar {𝑎 𝑏 𝑐}
! Vector /[𝒂-𝒛]/
! Vector {𝒂 𝒃 𝒄}
! Tensor /[𝑨-𝒁]/
! Tensor {𝑨 𝑩 𝑪}
! Set /[𝕒-𝕫]/
! Set {𝕒 𝕓 𝕔}
! Type /[𝔸-𝕐ℂℍℕℙℚℝℤ]/
! Type {𝔸 𝔹 ℂ}
```
### Operator
```korekto
! Unary /[-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋]/
! Unary {𝓐 𝓑 𝓒}
! Unaries /[-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋]*/
! Unaries {𝓉 𝓊 𝓋}
! Tight /[∨∧𝓵]/
! Tight {♩ ♪}
! .NotTight /(?![∨∧𝓵])/
! .NotTight {⚑}
! Binary /[-+/*]/
! Binary {♣ ♥ ♦}
! MultDiv /[/*]/
! MultDiv {♝ ♛ ♚}
! AddSub /[-+]/
! AddSub {⚀ ⚁ ⚂ ±}
! Loose /[-+\<\>=≠≤≥]/
! Loose {⚌ ⚍ ⚎ ⚏}
```
### Label
```korekto
! Superscript /[⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡ!]/
! Superscript {ⁱ ʲ ᵏ}
! Subscript /[₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓᵦᵧᵨᵩᵪ]/
! Subscript {ᵢ ⱼ ₖ}
```
### Group
```korekto
! Group /(?:[^()]|\([^()]*\))+/
! Group {G1 G2 G3}
! GroupGlob /(?:[^()\s]|\([^()]*\))+/
! GroupGlob {g1 g2 g3}
! Elements /[^{}]*/
! Elements {E1 E2 E3}
! Parameters /[^\[\]]+/
! Parameters {P1 P2 P3}
```
### Slurp
```korekto
! Slurp /[^;]*/
! Slurp {S1 S2 S3 S4}
! Glob /[^\s;]*/
! Glob {s1 s2 s3}
! Span /[^:=;]*/
! Span {N1 N2 N3}
! .Clump /\S+/
! .Clump {𝓂}
```
### SuperToken
```korekto
# SuperToken will use Mathematical Sans-Serift Bold digits
! SuperToken /[-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋]*(?:(?:\d[\d\.]*)|\w+|\((?:[^()]|\([^()]*\)|\([^()]*\([^()]*\)*\))*\)|\S)[₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓᵦᵧᵨᵩᵪ]*[⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡ!]*/
! SuperToken {𝟭 𝟮 𝟯 𝟰 𝟱 𝟲 𝟳 𝟴 𝟵 𝓍 𝓎 𝓏}
```
## Definitions

### Equivalence
```korekto
N1 : N2	#L1 Equivalent:   :
N1 : N2;N1 = N2	#M2 If equivalent, then equal: =
```
### Group
```korekto
N1 : (N1)	#A3 Group: ( )
```
### Sets
```korekto
w1{E1}	#L4 Named set: { }
w1{E1𝟣E2};w1[𝟣]	#M5 Membership: [ ]
w1[𝟣];𝟣 ∊ w1	#M6 Element of: ∊
```
### Member operators
```korekto
w1{E1𝟣 𝟤E2};𝟣₊ = 𝟤	#M7 Next: ₊
w1{E1𝟣 𝟤E2};𝟤₋ = 𝟣	#M8 Previous: ₋
```
### Methods on words
```korekto
w1{𝟣E1};w1.first : 𝟣	#M9 First: . first
w1{E1𝟣};w1.last : 𝟣	#M10 Last: last
```
### Raise
```korekto
w1{𝟣E1};w2{𝟤E2};𝟣⁺ = 𝟤	#I11 Raise first: ⁺
w1{𝓂 𝟣E1};w2{𝓂 𝟤E2};𝟣⁺ = 𝟤	#I12 Raise second
w1{𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝟤E2};𝟣⁺ = 𝟤	#I13 Raise third
w1{𝓂 𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝓂 𝟤E2};𝟣⁺ = 𝟤	#I14 Raise fourth
```
### Types
```korekto
Constant[𝖆]	#L15 Constant: Constant
Scalar[𝑎]	#L16 Scalar: Scalar
Vector[𝒂]	#L17 Vector: Vector
Tensor[𝑨]	#L18 Tensor: Tensor
Operator[𝓐]	#L19 Operator: Operator
```
### Addition and Subtraction
```korekto
𝟭 + 𝟮 = 𝟯;𝟯 - 𝟮 = 𝟭	#M20 Addition=>Subtraction: + -
𝟯 - 𝟮 = 𝟭;𝟭 + 𝟮 = 𝟯	#M21 Subtraction=>Addition
𝟭 - 𝟭 = 0	#A22 Zero: 0
𝟭 + 𝟮 = 𝟮 + 𝟭	#A23 Commute+
```
### Multiplication and Division
```korekto
𝟮 * 𝟯 = 𝟲;𝟲 / 𝟯 = 𝟮	#M24 Multiplication=>Division: * /
𝟲 / 𝟯 = 𝟮;𝟮 * 𝟯 = 𝟲	#M25 Division=>Multiplication
𝟮 / 𝟮 = 1	#A26 One: 1
# Note: multiplication does not commute in general(e.g. matrices)
```
### Exponentiation and Root
```korekto
𝟮∧𝟯 = 𝟴;𝟴∨𝟯 = 𝟮	#M27 Exponentiation=>Root: ∧ ∨
𝟴∨𝟯 = 𝟮;𝟮∧𝟯 = 𝟴	#M28 Root=>Exponentiation
# Does not commute
# No analogous 𝟛∨𝟛 = N
𝟮∧1 = 𝟮	#A29 x∧1=x
𝟮∧0 = 1	#A30 X∧0=1
```
### Square and Square Root
```korekto
𝟮² = 𝟮 * 𝟮	#A31 Square: ²
𝟮² = 𝟰;√𝟰 = 𝟮	#M32 Square=>SquareRoot: √
√𝟰 = 𝟮;𝟮² = 𝟰	#M33 SquareRoot=>Square
```
### Exponentiation and Logarithm
```korekto
𝟮∧𝟯 = 𝟴;𝟮𝓵𝟴 = 𝟯	#M34 Exponentiation=>Logarithm: 𝓵
𝟮𝓵𝟴 = 𝟯;𝟮∧𝟯 = 𝟴	#M35 Logarithm=>Exponentiation
𝟮𝓵1 = 0	#A36 xl1=0
```
### Digits
```korekto
1 - 1 = 0	#T37/A22 Zero
0 + 1 = 1	#R38/M21,T37 Subtraction=>Addition
1 + 1 : 2	#S39/L1 Equivalent: 2
2 + 1 : 3	#S40/L1 Equivalent: 3
3 + 1 : 4	#S41/L1 Equivalent: 4
4 + 1 : 5	#S42/L1 Equivalent: 5
5 + 1 : 6	#S43/L1 Equivalent: 6
6 + 1 : 7	#S44/L1 Equivalent: 7
7 + 1 : 8	#S45/L1 Equivalent: 8
8 + 1 : 9	#S46/L1 Equivalent: 9
```
### Show multiplication as repeated addition
```korekto
𝟭 = 𝟭;𝟭 * 1 = 𝟭	#M47 Single
𝟭 + 𝟭 = 𝟮;𝟭 * 2 = 𝟮	#M48 Double
𝟭 + 𝟭 + 𝟭 = 𝟯;𝟭 * 3 = 𝟯	#M49 Triple
```
### Show exponentiation as repeated multiplication
```korekto
𝟮 = 𝟮;𝟮∧1 = 𝟮	#M50 Linear
𝟮 * 𝟮 = 𝟰;𝟮∧2 = 𝟰	#M51 Square
𝟮 * 𝟮 * 𝟮 = 𝟴;𝟮∧3 = 𝟴	#M52 Cube
```
### Inequalities

Here I also introduce an absolute value operator, `⎨`.
This allows use of its closing symbol `⎬` in post-editing.
But to keep the parser simple, I'll treat `⎨` as a unary operator.
```korekto
# Inequalities
𝓍+1 > 𝓍	#A53 Greater than: >
𝓍 > 𝓎;𝓎 > 𝓏;𝓍 > 𝓏	#I54 Transitive >
𝓍 > 𝓎;𝓎 < 𝓍	#M55 Less than: <
𝓍 < 𝓎;𝓎 < 𝓏;𝓍 < 𝓏	#I56 Transitive <
𝓍 > 𝓎;𝓍 ≠ 𝓎	#M57 ≠ if >: ≠
𝓍 < 𝓎;𝓍 ≠ 𝓎	#M58 ≠ if <
∞ > 𝓍	#A59 Infinity: ∞
# Absolute value
⎨𝓍 = ⎨-𝓍	#A60 Absolute: ⎨
𝓍 < 0;⎨𝓍 = -𝓍	#M61 ⎨<0
𝓍 > 0;⎨𝓍 = 𝓍	#M62 ⎨>0
𝓍 = 0;⎨𝓍 = 0	#M63 ⎨=0
# Greater/Less than or equal
⎨𝓍 ≥ 0	#A64 Greater than or equal: ≥
0 ≤ ⎨𝓍	#A65 Less than or equal: ≤
```
### Bijection

Need a way to show a connection between symbols.
Specifically, a way to show that a label refers to a variable or value.
```korekto
𝒶 ⤖ 𝓂	#L66 Bijection: ⤖
ᴺ ⤖ 𝓝	#S67/L66 Bijection: ᴺ 𝓝
ₙ ⤖ 𝑛	#S68/L66 Bijection: ₙ 𝑛
ⁿ ⤖ 𝑛	#S69/L66 Bijection: ⁿ
ᵢ ⤖ 𝑖	#S70/L66 Bijection: ᵢ 𝑖
₀ ⤖ 0	#S71/L66 Bijection: ₀
₁ ⤖ 1	#S72/L66 Bijection: ₁
₌ ⤖ =	#S73/L66 Bijection: ₌
```
### Sums
```korekto
# I'm going to overload 𝓝.
# It's both an operator and an arbitrary positive number.
𝓝ᵢ : ∑ᵢ₌₁ᴺ	#S74/L1 Equivalent: ∑
```
### Products
```korekto
# 𝑛! 
∏𝑛 : ∏ᵢ₌₁ⁿ 𝑖	#S75/L1 Equivalent: ∏
```
### Euler's number
```korekto
𝖊 : ∑ₙ 1/𝑛!	#S76/L1 Equivalent: 𝖊 !
⌊ : 𝖊𝓵	#S77/L1 Equivalent: ⌊
```
### Infinitessimals
```korekto
𝓍 ≠ 0;|𝜀| < |𝓍|	#M78 Infinitessimal: | 𝜀
𝜀 ≠ 0	#P79 First order 𝜀
𝜀² = 0	#P80 Vanishing 𝜀
𝛅𝓐(𝒶) = 𝓐(𝒶+𝜀)-𝓐(𝒶)	#A81 Differential: 𝛅
𝓓𝓐(𝒶) = 𝛅𝓐(𝒶)/𝜀	#A82 Derivative: 𝓓
```
## Grouping

### Token grouping
```korekto
S1𝟭S2;S1(𝟭)S2	#M83 a->(a)
S1(𝟭)S2;S1𝟭S2	#M84 (a)->a
S1𝟭S2𝟮S3;S1(𝟭)S2(𝟮)S3	#M85 a_b->(a)_(b)
S1(𝟭)S2(𝟮)S3;S1𝟭S2𝟮S3	#M86 (a)_(b)->a_b
S1𝟭S2𝟮S3𝟯S4;S1(𝟭)S2(𝟮)S3(𝟯)S4	#M87 a_b_c->(a)_(b)_(c)
S1(𝟭)S2(𝟮)S3(𝟯)S4;S1𝟭S2𝟮S3𝟯S4	#M88 (a)_(b)_(c)->a_b_c
```
### Binary spacing
```korekto
S1(𝟭 ♦ 𝟮)S2;S1(𝟭♦𝟮)S2	#M89 *(a + b)*->*(a+b)*
S1(𝟭♦𝟮)S2;S1(𝟭 ♦ 𝟮)S2	#M90 *(a+b)*->*(a + b)*
S1♮(𝟭♭♦♭𝟮);S1 𝟭♦𝟮	#M91 *(a + b)$-> * a+b$
S1 𝟭♦𝟮;S1♮(𝟭♭♦♭𝟮)	#M92 * a+b$->*(a + b)$
(𝟭♭♦♭𝟮)♮S1;𝟭♦𝟮 S1	#M93 ^(a + b)*->^a+b *
𝟭♦𝟮 S1;(𝟭♭♦♭𝟮)♭S1	#M94 ^a+b *->^(a + b)*
S1 𝟭♦𝟮 S2;S1♮(𝟭♭♦♭𝟮)♭S2	#M95 * a+b *->*(a + b)*
S1♭(𝟭♭♦♭𝟮)♮S2;S1 𝟭♦𝟮 S2	#M96 *(a + b)*->* a+b *
```
### MultDiv spacing
```korekto
# MultDiv has higher precedence than AddSub
S1 𝟭♚𝟮;S1 𝟭 ♚ 𝟮	#M97 ~a*b$->~a * b
S1 𝟭 ♚ 𝟮;S1 𝟭♚𝟮	#M98 ~a * b$->~a*b
𝟭♚𝟮 S2;𝟭 ♚ 𝟮 S2	#M99 ^a*b~$->a * b~
𝟭 ♚ 𝟮 S2;𝟭♚𝟮 S2	#M100 ^a * b~->a*b~
S1 𝟭 ♚ 𝟮 S2;S1 𝟭♚𝟮 S2	#M101 ~a * b~->~a*b~
S1 𝟭♚𝟮 S2;S1 𝟭 ♚ 𝟮 S2	#M102 ~a*b~->~a * b~
```
### MutlDiv Grouping
```korekto
# MultDiv has higher precedence than AddSub
S1♥𝟭♚𝟮♦S2;S1♥(𝟭♭♚♭𝟮)♦S2	#M103 +a*b+->+(a*b)+
S1♥(𝟭♭♚♭𝟮)♦S2;S1♥𝟭♚𝟮♦S2	#M104 +(a*b)+->+a*b+
S1♥𝟭♚𝟮;S1♥(𝟭♭♚♭𝟮)	#M105 +a*b$->+(a*b)
S1♥(𝟭♭♚♭𝟮);S1♥𝟭♚𝟮	#M106 +(a*b)$->+a*b
𝟭♚𝟮♦S2;(𝟭♭♚♭𝟮)♦S2	#M107 ^a*b+->(a*b)+
(𝟭♭♚♭𝟮)♦S2;𝟭♚𝟮♦S2	#M108 ^(a*b)+->a*b+
(𝟭♭♚♭𝟮)♮♚♮S2;𝟭♮♚♮𝟮♮♚♮S2	#M109 ^(a*b)*->a*b*
```
### GroupGlob grouping
```korekto
S1♭(g1)♭S2;S1 g1 S2	#M110 Space
S1 g1 S2;S1♭(g1)♭S2	#M111 Group
S1♭(g1);S1 g1	#M112 Space$
S1 g1;S1♭(g1)	#M113 Group$
(g1)♭S1;g1 S1	#M114 ^Space
g1 S1;(g1)♭S1	#M115 ^Group
```
### Group grouping
```korekto
S1 ⚍ (G1) ⚎ S2;S1 ⚍ G1 ⚎ S2	#M116 +Space+
S1 ⚍ G1 ⚎ S2;S1 ⚍ (G1) ⚎ S2	#M117 +Group+
S1 ⚍ G1 ⚎ G2 ⚏ S2;S1 ⚍ (G1) ⚎ (G2) ⚏ S2	#M118 +Group+Group+
S1 ⚍ (G1);S1 ⚍ G1	#M119 +Space
S1 ⚍ G1;S1 ⚍ (G1)	#M120 +Group
(G1) ⚍ S1;G1 ⚍ S1	#M121 Space+
G1 ⚍ S1;(G1) ⚍ S1	#M122 Group+
S1 ⚍ G1⦆;S1 ⚍ (G1)⦆	#M123 +Group)
S1 ⚍ g1±g2;S1 ⚍ g1 ± g2	#M124 Space ~a+b
```
### Tight grouping
```korekto
S1(𝟭♩𝟮)S2;S1𝟭♩𝟮S2	#M125 Tight un-grouped
S1𝟭♩𝟮S2;S1(𝟭♩𝟮)S2	#M126 Tight grouped
```
## Algebra

### Implied/Explicit multiplication
```korekto
S1𝟭♭𝟮S2;S1𝟭♮*♮𝟮S2	#M127 Explicit*
S1𝟭♮*♮𝟮S2;S1𝟭♭𝟮S2	#M128 Implied*
```

### Equality
```korekto
N1 = N2;N2 = N1	#M129 Symmetry
N1 = N1	#A130 Reflection
```
### Transitive
```korekto
N1 = N2;N2 = N3;N1 = N3	#I131 Transitive a=b;b=c;a=c
N1 = N2;N3 = N2;N3 = N1	#I132 Linked a=b;c=b;c=a
```
### One
```korekto
# (a/a)
S1(𝟭♭/♭𝟭)S2;S1(1)S2	#M133 (a/a)=>(1)
S1(g1 / g1)S2;S1(1)S2	#M134 (a / a)=>(1)
# One
S1♭*♭1 S2;S1 S2	#M135 *one~
S1♭*♭(1) S2;S1 S2	#M136 *(one)~
S1 1♭*♭S2;S1 S2	#M137 ~one*
S1 (1)♭*♭S2;S1 S2	#M138 ~(one)*
S1*1⚑S2;S1⚑S2	#M139 *one
S1⚑1*S2;S1⚑S2	#M140 one*
S1*(1)⚑S2;S1⚑S2	#M141 *(one)
S1⚑(1)*S2;S1⚑S2	#M142 (one)*
```
### Zero
```korekto
S1(𝟭♭-♭𝟭)S2;S1(0)S2	#M143 (a-a)=>(0)
S1♭⚀♭𝟭♭-♭𝟭♭±♭S2;S1♭±♭S2	#M144 ±a-a±=>±
S1⚀𝟭-𝟭 S2;S1 S2	#M145 +a-a~
S1♭⚀♭0♭±♭S2;S1♭±♭S2	#M146 ±0±=>±
```
### (a/b)
```korekto
S1 𝟭♭/♭𝟮;S1 𝟯*𝟭 / 𝟯*𝟮	#M147 x*a / x*b$
S1(𝟭♭/♭𝟮)S2;S1(𝟯*𝟭 / 𝟯*𝟮)S2	#M148 (xa / xb)
S1(g1 / g2)S2;S1(𝟭*(g1) / 𝟭*(g2))S2	#M149 (x(a) / x(b))
S1𝟭*(1♭/♭𝟮)⚑S2;S1(𝟭♮/♮𝟮)S2	#M150 (x*1)/(y)
S1𝟭*(1 / g1)⚑S2;S1(𝟭 / g1)S2	#M151 x*1 /  y
S1 1♭±♭(𝟭 / g2)⚑S2;S1 (g2±𝟭 / g2)S2	#M152 ~1+(a/b)->~(b+a / b)
```
### Distribute
```korekto
S1𝟭*(𝟮♭±♭𝟯)⚑S2;S1(𝟭*𝟮♮±♮𝟭*𝟯)S2	#M153 (xa±xb)
S1𝟭*(g2 ± g3)⚑S2;S1(𝟭*(g2) ± 𝟭*(g3))S2	#M154 (x(a) ± x(b))
```
### Substitution
```korekto
𝟭 = 𝟮;S1𝟭S2;S1𝟮S2	#I155 a=b;a->b
𝟭 = N2;S1𝟭S2;S1(N2)S2	#I156 a=b;a->(b)
N1 = 𝟭;S1♭(N1)♮S2;S1♭𝟭♮S2	#I157 (a)=b;(a)->b
N1 = 𝟭;S1♭(N1)♭S2♭(N1)♭S3;S1♭𝟭♭S2♭𝟭♭S3	#I158 (a)=b;(a)->b,b
N1 = 𝟭;S1𝟭S2;S1(N1)S2	#I159 (a)=b;b->(a)
N1 = N2;S1(N1)S2;S1(N2)S2	#I160 a=b;(a)->(b)
N1 = N2;S1(N2)S2;S1(N1)S2	#I161 a=b;(b)->(a)
N1 = N2;N1 ⚍ S1;N2 ⚍ S1	#I162 a=b;a->b+
N1 = N2;N2 ⚍ S1;N1 ⚍ S1	#I163 a=b;b->a+
N1 = N2;S1 ⚍ N1;S1 ⚍ N2	#I164 a=b;a->+b
N1 = N2;S1 ⚍ N2;S1 ⚍ N1	#I165 a=b;b->+a
```
### Adding
```korekto
S1(𝟭 + -𝟮)S2;S1(𝟭♮-♮𝟮)S2	#M166 a+-b=a-b
S1(𝟭♭-♭𝟮)S2;S1(𝟭 + -𝟮)S2	#M167 a-b=a+-b
S1⚑𝟭∧𝟮*𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M168 a^b*a^c=a^(b+c)
S1⚑𝟭∧𝟮𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M169 a^ba^c=a^(b+c)
S1⚑𝟭∧(𝟮♭+♭𝟯)⚑S2;S1𝟭∧𝟮*𝓊𝟭∧𝟯S2	#M170 a^(b+c)=a^b*a^c
S1(𝟭♭+♭𝟮)S2;S1(𝟮♮+♮𝟭)S2	#M171 (a+b)->(b+a)
```
### Subtracting
```korekto
S1♭--𝟭♮S2;S1♭𝟭♮S2	#M172 --a->a
```
## Calculus
```korekto
# Derivatives
# Constant Rule
𝓓ᵢ𝒹 = 0	#A173 Constant rule
# Power Rule
𝓓ᵢ(𝓍∧𝒹) = 𝒹*𝓍∧(𝒹-1)	#A174 Power rule
# Sum and Difference Rules
𝓓ᵢ(𝓍 + 𝓎) = 𝓓ᵢ𝓍 + 𝓓ᵢ𝓎	#A175 Sum rule
# Product Rule
𝓓ᵢ(𝓍*𝓎) = 𝓓ᵢ𝓍*𝓎 + 𝓍*𝓓ᵢ𝓎	#A176 Product rule
# Quotient Rule
𝓓ᵢ(𝓍 / 𝓎) = (𝓓ᵢ(𝓍)𝓎 - 𝓍𝓓ᵢ(𝓎)) / 𝓎²	#A177 Quotient rule
𝓓ᵢ(1 / 1+𝓍) = -𝓓ᵢ𝓍 / (1+𝓍)²	#A178 From quotient rule
# Chain Rule
# This one is meta.  :-??
𝓓ᵢ𝓐𝓑𝓍 = (𝓓𝓐)𝓑𝓍*(𝓓𝓑)𝓍*𝓓ᵢ𝓍	#A179 Chain rule
# Exponential
𝓓ᵢ(𝑎∧𝓍) = ⌊𝑎𝓓ᵢ(𝓍)𝑎∧𝓍	#A180 D(a^x)=log(a)D(x)a^x
𝓓ᵢ(𝖊∧𝓍) = 𝓓ᵢ(𝓍)𝖊∧𝓍	#A181 D(e^x)=D(x)e^x
```
