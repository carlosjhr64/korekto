# Korekto Math

Imports:

* [KorektoKernel](KorektoKernel.md)

Imported by:

* [Two Cube](../examples/TwoCube.md)
* [Neuronet](../examples/Neuronet.md)

## Contents

* [Notes](#Notes)
* [Ruby patches](#Ruby-patches)
* [Syntax](#Syntax)
* [Patterns](#Patterns)
* [Definitions](#Defintions)
* [Grouping](#Grouping)
* [Algebra](#Algebra)
* [Functions](#Functions)
* [Calculus](#Calculus)

## Notes

### Style

Referencing Wikipedia's
[Mathematical operators and symbols in Unicode](https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode)
and
[Unicode subscripts and superscripts:](https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts)

* Regular ASCII: names like "sin", "cos", "log".
* Italic capital `𝐴..𝑍`: constants.
* Italic small `𝑎..𝑧`: scalar variables.
* Bold italic small `𝒂..𝒛`: single-labeled variables, vectors.
* Bold italic capital `𝑨..𝒁`: multi-labeled variables, matrices.
* Bold script capital `𝓐..𝓩`: unary operators, like 𝓓𝑥.
* Bold script small `𝓪..𝔃`: binary operators.
* Double struck small `𝕒..𝕫`: finite ordered sets.
* Bold Fraktur small `𝖆..𝖟`: transcendental constant.

### Factorial

I'm treating the factorial symbol `!` like a superscript.
I think it'll work well thought of as an exponent.

### Infinity

Depending on context, the infinity symbol may be treated as a superscript.

* Superscript infinity: `𝖊 = ∑ₙ₌₀∞ 1/𝑛!`
* Regular infinity: `∞ > 𝑎`

### Character classes

To keep the list of unary operators up-to-date,
edit the following vim command with the full operator list and run it:

* `:g/^[!|]/s/\[-𝓐[^\]]*\]/[-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋]/g`

To keep the list of subscripts up-to-date,
edit the following vim command with the full subscript list and run it:

* `:g/^[!|]/s/\[₀[^\]]*\]/[₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓᵦᵧᵨᵩᵪ]/g`

To keep the list of superscripts up-to-date,
edit the following vim command with the full superscript list and run it:

* `:g/^[!|]/s/\[⁰[^\]]*\]/[⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡ!∞]/g`

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
| Constant | Decimal,[𝐴-𝑍𝕬-𝖟] | 𝖆 𝖇 𝖈 | Bold-Fraktur |
| Scalar | [𝑎-𝑧]| 𝑎 𝑏 𝑐 | Italic Small |
| Vector | [𝒂-𝒛] | 𝒂 𝒃 𝒄 | Bold Italic Small |
| Tensor | [𝑨-𝒁] | 𝑨 𝑩 𝑪 | Bold Italic Capitol |
| Set | [𝕒-𝕫] | 𝕒 𝕓 𝕔 | Double-Struck small |
| Type | [𝔸-𝕐ℂℍℕℙℚℝℤ] | 𝔸 𝔹 ℂ | Double-Struck Capitol |
| [Operator](#Operator) |
| Unary | [-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋] | 𝓐 𝓑 𝓒 | Bold Script Capitol |
| Unaries | Unary* | 𝓉 𝓊 𝓋 | Script Small |
| Tight | [∨∧𝓵] | ♩ ♪ | Miscellaneous Symbols |
| .NotOperated | (?&lt;![-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋]) | ☜ | Miscellaneous Symbols |
| .NotOperated2 | (?&lt;![-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋]\s) | ☚ | Miscellaneous Symbols |
| .NotTightBehind | (?&lt;![∨∧𝓵]) | ⚐ | Miscellaneous Symbols |
| .NotTightAhead | (?![∨∧𝓵]) | ⚑ | Miscellaneous Symbols |
| Associative Binaries: |
| Binary | [-+/*] | ♣ ♥ ♦ | Miscellaneous Symbols |
| MultDiv | [/*] | ♝ ♛ ♚ | Miscellaneous Symbols |
| AddSub | [-+] | ⚀ ⚁ ⚂ ± | Miscellaneous Symbols |
| .Equals | [:=] | ⚌ | Miscellaneous Symbols |
| Loose | [-+&lt;&gt;=≠≤≥:] | ⚍ ⚎ ⚏ | Miscellaneous Symbols |
| [Label](#Label) |
| Superscript | [⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡ!∞] | ⁱ ʲ ᵏ | Latin superscript |
| Subscript | [₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓᵦᵧᵨᵩᵪ] | ᵢ ⱼ ₖ | Latin subscript |
| [Group](#Group) |
| Group | (?:[^()]\|\([^()]*\))+ | G1 G2 G3 | ASCII |
| GroupGlob | (?:[^()\s]\|\([^()]*\))+ | g1 g2 g3 | ASCII |
| Elements | [^{}]* | E1 E2 E3 | ASCII |
| Parameters | [^\[\]]+ | P1 P2 P3 | ASCII |
| [Slurp](#Slurp) |
| Slurp | [^;]* | S1 S2 S3 S4 | ASCII |
| Glob | [^\s;]* | s1 s2 s3 | ASCII |
| Span | [^;&lt;&gt;=≠≤≥:]* | N1 N2 N3 | ASCII |
| .Clump | \S+ | 𝓂 | Script small|
| [SuperToken](#SuperToken) |
| SuperToken | (Unary+ Subscript* Superscript*)? (Token,Group) Subscript* Superscript* | 𝟭 𝟮 𝟯 𝟰 𝟱 𝟲 𝟳 𝟴 𝟵 𝓍 𝓎 𝓏 | Sans-Serif Bold |

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
# Inequalities and equalities must be spaced
? !match?(%r{\S[\<\>=≠≤≥:]}) && !match?(%r{[\<\>=≠≤≥:]\S})
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
! Constant /\d[\d\.]*|[𝐴-𝑍𝕬-𝖟]/
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
! NotOperated /(?<![-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋])/
! NotOperated {☜}
! NotOperated2 /(?<![-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋]\s)/
! NotOperated2 {☚}
! .NotTightBehind /(?<![∨∧𝓵])/
! .NotTightBehind {⚐}
! .NotTightAhead /(?![∨∧𝓵])/
! .NotTightAhead {⚑}
! Binary /[-+/*]/
! Binary {♣ ♥ ♦}
! MultDiv /[/*]/
! MultDiv {♝ ♛ ♚}
! AddSub /[-+]/
! AddSub {⚀ ⚁ ⚂ ±}
! .Equals /[:=]/
! .Equals {⚌}
! Loose /[-+<>=≠≤≥:]/
! Loose {⚍ ⚎ ⚏}
```
### Label
```korekto
! Superscript /[⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡ!∞]/
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
! Span /[^;<>=≠≤≥:]*/
! Span {N1 N2 N3}
! .Clump /\S+/
! .Clump {𝓂}
```
### SuperToken
```korekto
# SuperToken will use Mathematical Sans-Serift Bold digits
! SuperToken /(?:[-𝓐-𝓩√⎨∑∏⌊⌉⌈⌋]+[₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓᵦᵧᵨᵩᵪ]*[⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡ!∞]*)*(?:\((?:[^()]|\([^()]*\)|\([^()]*\([^()]*\)*\))*\)|(?:\d[\d\.]*)|\w+|\S)[₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓᵦᵧᵨᵩᵪ]*[⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡ!∞]*/
! SuperToken {𝟭 𝟮 𝟯 𝟰 𝟱 𝟲 𝟳 𝟴 𝟵 𝓍 𝓎 𝓏}
```
## Definitions

### Equivalence
```korekto
# Only use `:` to define a new symbol in terms of other symbols.
# Specifically, don't use it in patterns.
N1 : N2	#L1 ≝:   :
N1 : N2;N1 = N2	#M2 ≝→=: =
```
### Group
```korekto
# Note that I'm using `=` here and not `:` which would be poor usage.
N1 = (N1)	#A3 Group: ( )
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
w1{𝟣E1};w1.first = 𝟣	#M9 First: . first
w1{E1𝟣};w1.last = 𝟣	#M10 Last: last
```
### Replace
```korekto
w1{𝟣E1};w2{𝟤E2};𝟣⁺ = 𝟤	#I11 →1st: ⁺
w1{𝓂 𝟣E1};w2{𝓂 𝟤E2};𝟣⁺ = 𝟤	#I12 →2nd
w1{𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝟤E2};𝟣⁺ = 𝟤	#I13 →3rd
w1{𝓂 𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝓂 𝟤E2};𝟣⁺ = 𝟤	#I14 →4th
w1{𝓂 𝓂 𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝓂 𝓂 𝟤E2};𝟣⁺ = 𝟤	#I15 →5th
w1{𝓂 𝓂 𝓂 𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝓂 𝓂 𝓂 𝟤E2};𝟣⁺ = 𝟤	#I16 →6th
w1{𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝟤E2};𝟣⁺ = 𝟤	#I17 →7th
w1{𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝟤E2};𝟣⁺ = 𝟤	#I18 →8th
w1{𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝓂 𝟤E2};𝟣⁺ = 𝟤	#I19 →9th
```
### Types
```korekto
Constant[𝖆]	#L20 Constant: Constant
Scalar[𝑎]	#L21 Scalar: Scalar
Vector[𝒂]	#L22 Vector: Vector
Tensor[𝑨]	#L23 Tensor: Tensor
Operator[𝓐]	#L24 Operator: Operator
```
### Addition and Subtraction
```korekto
𝟭 + 𝟮 ⚌ 𝟯;𝟯 - 𝟮 = 𝟭	#M25 +→-: + -
𝟯 - 𝟮 ⚌ 𝟭;𝟭 + 𝟮 = 𝟯	#M26 -→+
𝟭 - 𝟭 = 0	#A27 Zero: 0
𝟭 + 𝟮 = 𝟮 + 𝟭	#A28 Commutes
```
### Multiplication and Division
```korekto
𝟮 * 𝟯 ⚌ 𝟲;𝟲 / 𝟯 = 𝟮	#M29 *→/: * /
𝟲 / 𝟯 ⚌ 𝟮;𝟮 * 𝟯 = 𝟲	#M30 /→*
𝟮 / 𝟮 = 1	#A31 One: 1
# Note: multiplication does not commute in general(e.g. matrices)
```
### Exponentiation and Root
```korekto
𝟮∧𝟯 ⚌ 𝟴;𝟴∨𝟯 = 𝟮	#M32 ∧→∨: ∧ ∨
𝟴∨𝟯 ⚌ 𝟮;𝟮∧𝟯 = 𝟴	#M33 ∨→∧
# Does not commute
# No analogous 𝟛∨𝟛 = N
𝟮∧1 = 𝟮	#A34 x∧1=x
𝟮∧0 = 1	#A35 x∧0=1
𝟴∧-𝟯 = 1 / 𝟴∧𝟯	#A36 Reciprical
```
### Square and Square Root
```korekto
𝟮² = 𝟮 * 𝟮	#A37 Square: ²
𝟮² ⚌ 𝟰;√𝟰 = 𝟮	#M38 ²→√: √
√𝟰 ⚌ 𝟮;𝟮² = 𝟰	#M39 √→²
```
### Exponentiation and Logarithm
```korekto
𝟮∧𝟯 ⚌ 𝟴;𝟮𝓵𝟴 = 𝟯	#M40 ∧→𝓵: 𝓵
𝟮𝓵𝟴 ⚌ 𝟯;𝟮∧𝟯 = 𝟴	#M41 𝓵→∧
𝟮𝓵1 = 0	#A42 xl1=0
```
### Digits
```korekto
1 - 1 = 0	#T43/A27 Zero
0 + 1 = 1	#R44/M26,T43 -→+
# This is an exemplary use of `:`
1 + 1 : 2	#S45/L1 ≝: 2
2 + 1 : 3	#S46/L1 ≝: 3
3 + 1 : 4	#S47/L1 ≝: 4
4 + 1 : 5	#S48/L1 ≝: 5
5 + 1 : 6	#S49/L1 ≝: 6
6 + 1 : 7	#S50/L1 ≝: 7
7 + 1 : 8	#S51/L1 ≝: 8
8 + 1 : 9	#S52/L1 ≝: 9
```
### Show multiplication as repeated addition
```korekto
𝟭 ⚌ 𝟭;𝟭 * 1 = 𝟭	#M53 Single
𝟭 + 𝟭 ⚌ 𝟮;𝟭 * 2 = 𝟮	#M54 Double
𝟭 + 𝟭 + 𝟭 ⚌ 𝟯;𝟭 * 3 = 𝟯	#M55 Triple
```
### Show exponentiation as repeated multiplication
```korekto
𝟮 ⚌ 𝟮;𝟮∧1 = 𝟮	#M56 Linear
𝟮 * 𝟮 ⚌ 𝟰;𝟮∧2 = 𝟰	#M57 Square
𝟮 * 𝟮 * 𝟮 ⚌ 𝟴;𝟮∧3 = 𝟴	#M58 Cube
```
### Inequalities

Here I also introduce an absolute value operator, `⎨`.
This allows use of its closing symbol `⎬` in post-editing.
But to keep the parser simple, I'll treat `⎨` as a unary operator.
```korekto
# Inequalities
𝓍+1 > 𝓍	#A59 Greater than: >
𝓍 > 𝓎;𝓎 > 𝓏;𝓍 > 𝓏	#I60 Transitive >
𝓍 > 𝓎;𝓎 < 𝓍	#M61 Less than: <
𝓍 < 𝓎;𝓎 < 𝓏;𝓍 < 𝓏	#I62 Transitive <
𝓍 > 𝓎;𝓍 ≠ 𝓎	#M63 >→≠: ≠
𝓍 < 𝓎;𝓍 ≠ 𝓎	#M64 <→≠
# Absolute value
⎨𝓍 = ⎨-𝓍	#A65 Absolute: ⎨
𝓍 < 0;⎨𝓍 = -𝓍	#M66 ⎨<0
𝓍 > 0;⎨𝓍 = 𝓍	#M67 ⎨>0
𝓍 = 0;⎨𝓍 = 0	#M68 ⎨=0
# Greater/Less than or equal
⎨𝓍 ≥ 0	#A69 Greater than or equal: ≥
0 ≤ ⎨𝓍	#A70 Less than or equal: ≤
```
### Mapping

Need a way to show a connection between symbols.
Specifically, a way to show that a label refers to a variable or value.
```korekto
# Although 𝑁 is declared as a Constant,
# it'll be defined as as an arbitrary natural number.
Constant[𝑁]	#S71/L20 Constant: 𝑁
Scalar[𝑛]	#S72/L21 Scalar: 𝑛
Scalar[𝑥]	#S73/L21 Scalar: 𝑥
𝒶 → 𝓂	#L74 Map: →
ᴺ → 𝑁	#S75/L74 Map: ᴺ
ₙ → 𝑛	#S76/L74 Map: ₙ
ⁿ → 𝑛	#S77/L74 Map: ⁿ
ᵢ → 𝑖	#S78/L74 Map: ᵢ 𝑖
₀ → 0	#S79/L74 Map: ₀
₁ → 1	#S80/L74 Map: ₁
₌ → =	#S81/L74 Map: ₌
ₓ → 𝑥	#S82/L74 Map: ₓ
```
### Sums
```korekto
# Bold script capital 𝓝 is an operator.
𝓝ᵢ𝓍 = ∑ᵢ₌₁ᴺ𝓍	#A83 Finite sum: 𝓝 ∑
# Italic capital 𝑁 is a number.
𝑁 = 𝓝ᵢ1	#A84 Finite number
# Need a way to have a conditional loop not terminate...
# Infinity is bigger than any finite number.
∞ > 𝑁	#D85 Infinity
𝑁 < ∞	#R86/M61,D85 Less than
∑ᵢ𝓍 = ∑ᵢ₌₀∞𝓍	#A87 Infinite sum
```
### Products
```korekto
𝒷 → 𝒶;𝒶! = ∏ᵢ₌₁𝒷𝑖	#M88 Factorial: ! ∏
𝑛! = ∏ᵢ₌₁ⁿ𝑖	#R89/M88,S77 Factorial
```
### Euler's number
```korekto
𝖊 : ∑ₙ 1/𝑛!	#S90/L1 ≝: 𝖊
⌉𝓍 = 𝖊∧𝓍	#A91 Exp: ⌉
⌊𝓍 = 𝖊𝓵𝓍	#A92 Log: ⌊
```
### Infinitessimals
```korekto
𝓍 ≠ 0;⎨𝜀 < ⎨𝓍	#M93 Infinitessimal: 𝜀
𝜀 ≠ 0	#P94 1st order 𝜀
𝜀² = 0	#P95 Vanishing 𝜀
𝜹𝓐(𝒶) = 𝓐(𝒶+𝜀)-𝓐(𝒶)	#A96 Differential: 𝜹
𝓓𝓐(𝒶) = 𝜹𝓐(𝒶)/𝜀	#A97 Derivative: 𝓓
```
## Grouping

### Token grouping
```korekto
S1𝟭S2;S1(𝟭)S2	#M98 a → (a)
S1(𝟭)S2;S1𝟭S2	#M99 (a) → a
# And the above repeated up-to 3 times:
S1𝟭S2𝟮S3;S1(𝟭)S2(𝟮)S3	#M100 a~b → (a)~(b)
S1(𝟭)S2(𝟮)S3;S1𝟭S2𝟮S3	#M101 (a)~(b) → a~b
S1𝟭S2𝟮S3𝟯S4;S1(𝟭)S2(𝟮)S3(𝟯)S4	#M102 a~b~c → (a)~(b)~(c)
S1(𝟭)S2(𝟮)S3(𝟯)S4;S1𝟭S2𝟮S3𝟯S4	#M103 (a)~(b)~(c) → a~b~c
```
### Binary spacing
```korekto
S1(𝟭 ♦ 𝟮)S2;S1(𝟭♦𝟮)S2	#M104 (a_+_b) → (a+b)
S1(𝟭♦𝟮)S2;S1(𝟭 ♦ 𝟮)S2	#M105 (a+b) → (a_+_b)
# Binary group/spaced
S1♮(𝟭♭♦♭𝟮);S1 𝟭♦𝟮	#M106 ♭(a♭+♭b)$ → _a+b$
S1 𝟭♦𝟮;S1♮(𝟭♭♦♭𝟮)	#M107 _a+b$ → ♭(a♭+♭b)$
(𝟭♭♦♭𝟮)♮S1;𝟭♦𝟮 S1	#M108 ^(a♭+♭b)♭ → ^a+b_
𝟭♦𝟮 S1;(𝟭♭♦♭𝟮)♮S1	#M109 ^a+b_ → ^(a♭+♭b)♭
S1 𝟭♦𝟮 S2;S1♮(𝟭♭♦♭𝟮)♮S2	#M110 _a+b_ → ♭(a♭+♭b)♭
S1♮(𝟭♭♦♭𝟮)♮S2;S1 𝟭♦𝟮 S2	#M111 ♭(a♭+♭b)♭ → _a+b_
```
### MultDiv spacing
```korekto
# MultDiv has higher precedence than AddSub
S1☜ 𝟭♚𝟮;S1 𝟭 ♚ 𝟮	#M112 _a*b$ → _a_*_b$
S1☜ 𝟭 ♚ 𝟮;S1 𝟭♚𝟮	#M113 _a_*_b$ → _a*b$
𝟭♚𝟮 S2;𝟭 ♚ 𝟮 S2	#M114 ^a*b_ → ^a_*_b_
𝟭 ♚ 𝟮 S2;𝟭♚𝟮 S2	#M115 ^a_*_b_ → ^a*b_
S1☜ 𝟭 ♚ 𝟮 S2;S1 𝟭♚𝟮 S2	#M116 _a_*_b_ → _a*b_
S1☜ 𝟭♚𝟮 S2;S1 𝟭 ♚ 𝟮 S2	#M117 _a*b_ → _a_*_b_
```
### MutlDiv Grouping
```korekto
# MultDiv has higher precedence than AddSub
S1☜☚⚐𝟭♮♚♮𝟮⚑S2;S1(𝟭♭♚♭𝟮)S2	#M118 +a♭*♭b+ → +(a♭*♭b)+
S1☜☚⚐(𝟭♭♚♭𝟮)⚑S2;S1𝟭♮♚♮𝟮S2	#M119 +(a♭*♭b)+ → +a♭*♭b+
S1☜☚⚐𝟭♮♚♮𝟮;S1(𝟭♭♚♭𝟮)	#M120 +a♭*♭b$ → +(a♭*♭b)$
S1☜☚⚐(𝟭♭♚♭𝟮);S1𝟭♮♚♮𝟮	#M121 +(a♭*♭b)$ → +a♭*♭b$
𝟭♮♚♮𝟮⚑S2;(𝟭♭♚♭𝟮)S2	#M122 ^a♭*♭b+>^(a♭*♭b)+
(𝟭♭♚♭𝟮)⚑S2;𝟭♮♚♮𝟮S2	#M123 ^(a♭*♭b)+ → ^a♭*♭b+
S1♭(𝓍 ♚ g1)♭⚑S2;S1 𝓍♚(g1) S2	#M124 ♭(a_*_g)♭ → _a*(g)_
S1 𝓍♚(g1) S2;S1♭(𝓍 ♚ g1)♭S2	#M125 _a*(g)_ → ♭(a_*_g)♭
S1♭(𝓍 ♚ g1);S1 𝓍♚(g1)	#M126 ♭(a_*_g)$ → _a*(g)$
S1 𝓍♚(g1);S1♭(𝓍 ♚ g1)	#M127 _a*(g)$ → ♭(a_*_g)$
S1♦(𝓍𝓎);S1♦𝓍𝓎	#M128 *(ab) → *ab
```
### GroupGlob grouping
```korekto
S1♭(g1)♭S2;S1 g1 S2	#M129 ♭(a)♭ → _a_
S1 g1 S2;S1♭(g1)♭S2	#M130 _a_ → ♭(a)♭
S1♭(g1);S1 g1	#M131 ♭(a)$ → _a$
S1 g1;S1♭(g1)	#M132 _a$ → ♭(a)$
(g1)♭S1;g1 S1	#M133 ^(a)♭ → ^a_
g1 S1;(g1)♭S1	#M134 ^a_ → ^(a)♭
# Nested groupings
S1 g1⦆S2;S1 (g1)⦆S2	#M135 _a)→_(a))
S1⦅g1 S2;S1⦅(g1) S2	#M136 (a_→((a)_
```
### Group grouping
```korekto
S1 ⚍ (G1) ⚎ S2;S1 ⚍ G1 ⚎ S2	#M137 +_(a)_+ → +_a_+
S1 ⚍ G1 ⚎ S2;S1 ⚍ (G1) ⚎ S2	#M138 +_a_+ → +_(a)_+
S1 ⚍ G1 ⚎ G2 ⚏ S2;S1 ⚍ (G1) ⚎ (G2) ⚏ S2	#M139 →+_(a)_+_(b)_+
S1 ⚍ (G1) ⚎ (G2) ⚏ S2;S1 ⚍ G1 ⚎ G2 ⚏ S2	#M140 →+_a_+_b_+
S1 ⚍ (G1);S1 ⚍ G1	#M141 +_(a)$ → +_a$
S1 ⚍ G1;S1 ⚍ (G1)	#M142 +_a$ → +_(a)$
(G1) ⚍ S1;G1 ⚍ S1	#M143 ^(a)_+ → ^a_+
G1 ⚍ S1;(G1) ⚍ S1	#M144 ^a_+ → ^(a)_+
# Rare cases ((a))
S1 ⚍ G1⦆S2;S1 ⚍ (G1)⦆S2	#M145 +_a)~ → +_(a))~
S1 ⚍ (G1)⦆S2;S1 ⚍ G1⦆S2	#M146 +_(a))~ → +_a)~
S1⦅G1 ⚍ S2;⦅(G1) ⚍ S2	#M147 ~(a_+ → ~((a)_+
S1⦅(G1) ⚍ S2;⦅G1 ⚍ S2	#M148 ~((a)_+ → ~(a_+
# Rare cases a+b+c
S1 ⚍ g1±g2;S1 ⚍ g1 ± g2	#M149 +_a+b$ → +_a_+_b$
g1±g2 ⚍ S2;g1 ± g2 ⚍ S2	#M150 ^a+b_+ → ^a_+_b_+
S1 ⚎ g1±g2 ⚍ S2;S1 ⚎ g1 ± g2 ⚍ S2	#M151 +_a+b_+ → +_a_+_b_+
```
### Tight grouping
```korekto
S1(𝟭♩𝟮)⚑S2;S1𝟭♩𝟮S2	#M152 (a^b) → a^b
S1𝟭♩𝟮⚑S2;S1(𝟭♩𝟮)S2	#M153 a^b → (a^b)
S1(𝟭♩𝟮)⚑S2(𝟯♪𝟰)⚑S3;S1𝟭♩𝟮S2𝟯♪𝟰S3	#M154 (a^b)~(c^d) → a^b~c^c
S1𝟭♩𝟮⚑S2𝟯♪𝟰⚑S3;S1(𝟭♩𝟮)S2(𝟯♪𝟰)S3	#M155 a^b~c^d → (a^b)~(c^c)
```
## Algebra

### Implied/Explicit multiplication
```korekto
S1𝟭♭𝟮S2;S1𝟭♮*♮𝟮S2	#M156 Explicit*
S1𝟭♮*♮𝟮S2;S1𝟭♭𝟮S2	#M157 Implied*
```
### Equality
```korekto
N1 ⚌ N2;N2 = N1	#M158 Symmetry
N1 = N1	#A159 Reflection
```
### Transitive
```korekto
N1 ⚌ N2;N2 ⚌ N3;N1 = N3	#I160 a=b;b=c;a=c
N1 ⚌ N2;N2 ⚌ N3;N3 = N1	#I161 a=b;b=c;c=a
N1 ⚌ N2;N3 ⚌ N2;N1 = N3	#I162 a=b;c=b;a=c
N1 ⚌ N2;N3 ⚌ N2;N3 = N1	#I163 a=b;c=b;c=a
```
### One
```korekto
# (a/a)
S1(𝟭♭/♭𝟭)S2;S1(1)S2	#M164 (a/a)→(1)
S1(g1 / g1)S2;S1(1)S2	#M165 (a / a)→(1)
# *One*
S1♭*♭1 S2;S1 S2	#M166 *1_
S1 1♭*♭S2;S1 S2	#M167 _1*
S1♭*♭(1) S2;S1 S2	#M168 *(1)_
S1 (1)♭*♭S2;S1 S2	#M169 _(1)*
S1*1⚑S2;S1⚑S2	#M170 *1
S1⚐1*S2;S1⚐S2	#M171 1*
S1*(1)⚑S2;S1⚑S2	#M172 *(1)
S1⚐(1)*S2;S1⚐S2	#M173 (1)*
```
### Zero
```korekto
S1(𝟭♭-♭𝟭)S2;S1(0)S2	#M174 (a-a)→(0)
S1♭+♭𝟭♭-♭𝟭♭±♭S2;S1♭±♭S2	#M175 +a-a± → ±
S1♭+♭𝟭♭-♭𝟭;S1	#M176 +a-a$ → $
S1♭-♭𝟭♭+♭𝟭;S1	#M177 -a+a$ → $
S1+𝟭-𝟭 S2;S1 S2	#M178 +a-a_
# Order here matters. This one is tested first:
S1♭⚀♭0♭⚀♭S2;S1♭+♭S2	#M179 ±0± → +
# This one is tested after the above:
S1♭±♭0♭⚀♭S2;S1♭-♭S2	#M180 ±0+ → -
```
### (a/b)
```korekto
S1 𝟭♭/♭𝟮;S1 𝟯*𝟭 / 𝟯*𝟮	#M181 _x*a_/_x*b$
S1(𝟭♭/♭𝟮)S2;S1(𝟯*𝟭 / 𝟯*𝟮)S2	#M182 (x*a_/_x*b)
S1(g1 / g2)S2;S1(𝟭*(g1) / 𝟭*(g2))S2	#M183 (x*(a)_/_x*(b))
S1𝟭*(1♭/♭𝟮)⚑S2;S1(𝟭♮/♮𝟮)S2	#M184 x*(1/y) → (x/y)
S1𝟭*(1 / g1)⚑S2;S1(𝟭 / g1)S2	#M185 x*(1_/_y) → (x_/_y)
S1 1♭±♭(𝟭 / g2)⚑S2;S1 (g2±𝟭 / g2)S2	#M186 _1±(a_/_b) → (b±a / b)
S1 𝓍/𝓎²;S1 𝓍/𝓎 1/𝓎	#M187 _a/b²$→_a/b_1/b$
```
### Distribute
```korekto
S1𝟭*(𝟮♭±♭𝟯)⚑S2;S1(𝟭*𝟮♮±♮𝟭*𝟯)S2	#M188 (x*a♭±♭x*b)
S1𝟭*(g2 ± g3)⚑S2;S1(𝟭*(g2)♭±♭𝟭*(g3))S2	#M189 (x*(a)♭±♭x*(b))
```
### Substitution
```korekto
𝟭 ⚌ 𝟮;S1𝟭S2;S1𝟮S2	#I190 a=b,a→b
𝟭 ⚌ 𝟮;S1𝟭S2𝟭S3;S1𝟮S2𝟮S3	#I191 a=b,2*a→b
𝟭 ⚌ 𝟮;S1𝟭S2𝟭S3𝟭S4;S1𝟮S2𝟮S3𝟮S4	#I192 a=b,3*a→b
𝟭 ⚌ g1;S1 g1⦆S2;S1 𝟭⦆S2	#I193 a=g,_g)→_a)
g1 ⚌ 𝟭;S1 g1⦆S2;S1 𝟭⦆S2	#I194 g=a,_g)→_a)
𝟭 ⚌ g1;S1⦅g1 S2;S1⦅𝟭 S2	#I195 a=g,(g_→(a_
g1 ⚌ 𝟭;S1⦅g1 S2;S1⦅𝟭 S2	#I196 g=a,(g_→(a_
g1 ⚌ g2;S1 g1 S2;S1 g2 S2	#I197 a=b,_a_→_b_
g1 ⚌ g2;S1 g2 S2;S1 g1 S2	#I198 a=b,_b_→_a_
g1 ⚌ g2;S1 g1;S1 g2	#I199 a=b,_a$→_b$
g1 ⚌ g2;S1 g2;S1 g1	#I200 a=b,_b$→_a$
𝟭 ⚌ N2;S1𝟭S2;S1(N2)S2	#I201 a=(b),a→(b)
N1 ⚌ 𝟭;S1♭(N1)♮S2;S1♭𝟭♮S2	#I202 (a)=b,(a)→b
N1 ⚌ 𝟭;S1♭(N1)♭S2♭(N1)♭S3;S1♭𝟭♭S2♭𝟭♭S3	#I203 (a)=b,(a)→b~b
N1 ⚌ 𝟭;S1𝟭S2;S1(N1)S2	#I204 (a)=b;b→(a)
N1 ⚌ N2;S1(N1)S2;S1(N2)S2	#I205 (a)=(b),(a)→(b)
N1 ⚌ N2;S1(N2)S2;S1(N1)S2	#I206 (a)=(b),(b)→(a)
N1 ⚌ N2;N1 ⚍ S1;N2 ⚍ S1	#I207 a=b, ^a_+ → ^b_+
N1 ⚌ N2;N2 ⚍ S1;N1 ⚍ S1	#I208 a=b, ^b_+ → ^a_+
N1 ⚌ N2;S1 ⚍ N1;S1 ⚍ N2	#I209 a=b, +_a$ → +_b$
N1 ⚌ N2;S1 ⚍ N2;S1 ⚍ N1	#I210 a=b, +_b$ → +_a$
N1 ⚌ N2;S1 ⚍ N1 ⚎ S2;S1 ⚍ N2 ⚎ S2	#I211 a=b, +_a_+ → +_b_+
N1 ⚌ N2;S1 ⚍ N2 ⚎ S2;S1 ⚍ N1 ⚎ S2	#I212 a=b, +_b_+ → +_a_+
```
### Adding
```korekto
S1(𝟭 + -𝟮)S2;S1(𝟭♮-♮𝟮)S2	#M213 a+-b=a-b
S1(𝟭♭-♭𝟮)S2;S1(𝟭 + -𝟮)S2	#M214 a-b=a+-b
S1⚐𝟭∧𝟮*𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M215 a^b*a^c=a^(b+c)
S1⚐𝟭∧𝟮𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M216 a^ba^c=a^(b+c)
S1⚐𝟭∧(𝟮♭+♭𝟯)⚑S2;S1𝟭∧𝟮*𝟭∧𝟯S2	#M217 a^(b+c)=a^b*a^c
S1(𝟭♭+♭𝟮)S2;S1(𝟮♮+♮𝟭)S2	#M218 (a+b)→(b+a)
```
### Subtracting
```korekto
S1♭--𝟭♮S2;S1♭𝟭♮S2	#M219 --a→a
𝓍 = -𝓎;-𝓍 = 𝓎	#M220 a=-b;-a=-b
```
## Functions
```korekto
# Natural log
⌊ 𝓍/𝓎 = ⌊𝓍 - ⌊𝓎	#A221 ⌊(a/b)=⌊a-⌊b
# Squash
⌈𝓍 = 1 / 1+⌉-𝓍	#A222 Squash: ⌈
# Unsquash
⌋𝓍 = ⌊ 𝓍/(1-𝓍)	#A223 Unsquash: ⌋
# Binary balance
# 𝓑 is being used as a pattern key, so I temporarily replace it:
! replace! 𝓑 TMP
# Now I can define 𝓑 in an axiom:
𝓑𝓍 = (1-𝓍)*𝓍	#A224 Binary balance: 𝓑
! replace! TMP 𝓑
```
## Calculus
```korekto
# Derivatives
# Constant Rule
𝓓ᵢ𝖆 = 0	#A225 Constant rule
# Power Rule
𝓓ᵢ(𝓍∧𝖆) = 𝒹*𝓍∧(𝖆-1)	#A226 Power rule
# Sum and Difference Rules
𝓓ᵢ(𝓍 + 𝓎) = 𝓓ᵢ𝓍 + 𝓓ᵢ𝓎	#A227 Sum rule
# Product Rule
𝓓ᵢ(𝓍*𝓎) = 𝓓ᵢ𝓍*𝓎 + 𝓍*𝓓ᵢ𝓎	#A228 Product rule
# Quotient Rule
𝓓ᵢ(𝓍 / 𝓎) = (𝓓ᵢ(𝓍)𝓎 - 𝓍𝓓ᵢ(𝓎)) / 𝓎²	#A229 Quotient rule
𝓓ᵢ(1 / 1+𝓍) = -𝓓ᵢ𝓍 / (1+𝓍)²	#A230 From quotient rule
# Chain Rule
# This one is meta.  :-??
𝓓ᵢ𝓐𝓑𝓍 = (𝓓𝓐)𝓑𝓍*(𝓓𝓑)𝓍*𝓓ᵢ𝓍	#A231 Chain rule
# Exponential
𝓓ᵢ(𝖆∧𝓍) = ⌊𝖆𝓓ᵢ(𝓍)𝖆∧𝓍	#A232 D(a^x)=log(a)D(x)a^x
𝓓ᵢ(𝖊∧𝓍) = 𝓓ᵢ(𝓍)𝖊∧𝓍	#A233 D(e^x)=D(x)e^x
# Computations:
𝓓ᵢ(-𝓍) = -𝓓ᵢ(𝓍)	#A234 𝓓ₓ(-𝑦)=-𝓓(𝑦)
ᵢ → 𝑎;𝓓ᵢ𝑎 = 1	#M235 𝓓ₓ𝑥=1
ᵢ → 𝑎;𝓓ᵢ(-𝑎) = -1	#M236 𝓓ₓ-𝑥=-1
```
## Einstein notation
```korekto
∑ᵢ 𝓍ᵢ𝓎ᵢ = 𝓍ⁱ𝓎ᵢ	#A237 Einstein notation
∑ᵢ(𝓍ᵢ𝓎ᵢ) = 𝓍ⁱ𝓎ᵢ	#A238 Einstein notation
```
