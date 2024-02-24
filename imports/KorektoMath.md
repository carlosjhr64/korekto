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
* Double struck capital `𝔸..ℤ`: Types/Infinite sets.
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
  * used for binary operators, space, and lookarounds
* And then some obvious choices that don't fit the above, like `⦅⦆±`

When the name of a pattern(listed below) is prefixed by a dot(`.`),
it means that the pattern is a non-capture pattern.
Note that a capturing pattern will take on the value of the first match.  
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
| Token | Decimal,Word,Symbol | 𝟣 𝟤 𝟥 𝟦 𝟧 𝟨 𝟩 𝟪 𝟫 𝓅 𝓆 | Sans-Serif |
| [Type](#Type) |
| Constant | Decimal,[𝐴-𝑍𝕬-𝖟] | 𝐴 𝐵 𝖆 𝖇 | Italic-Capital, Bold-Fraktur |
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
| NegMaybe | [-]? | ⚬ | Miscellaneous Symbols |
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
| Slurp | [^;]* | S1 S2 S3 S4 𝓇 𝓈| ASCII |
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
! Token {𝟣 𝟤 𝟥 𝟦 𝟧 𝟨 𝟩 𝟪 𝟫 𝓅 𝓆}
```
### Type
```korekto
! Constant /\d[\d\.]*|[𝐴-𝑍𝕬-𝖟]/
! Constant {𝐴 𝐵 𝖆 𝖇}
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
! NegMaybe /[-]?/
! NegMaybe {⚬}
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
! Slurp {S1 S2 S3 S4 𝓇 𝓈}
! Glob /[^\s;]*/
! Glob {s1 s2 s3}
! Span /[^;<>=≠≤≥:]*/
! Span {N1 N2 N3}
! .Clump /\S+/
! .Clump {𝓂}
! .Clump5 /\S+ \S+ \S+ \S+ \S+/
! .Clump5 {M5}
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
# One can think of `{a b c}[b]` as eqivalent to `{a b c}[b] = b`.
# A[𝓍] is "truthy" iff 𝓍∊A.
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
# When semantically appropriate,
# one can replace one label with another having the same "order value"
w1{𝟣E1};w2{𝟤E2};𝟣 → 𝟤	#I11 1st: →
w1{𝓂 𝟣E1};w2{𝓂 𝟤E2};𝟣 → 𝟤	#I12 2nd
w1{𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I13 3rd
w1{𝓂 𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I14 4th
w1{𝓂 𝓂 𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I15 5th
w1{M5 𝟣E1};w2{M5 𝟤E2};𝟣 → 𝟤	#I16 6th
w1{M5 𝓂 𝟣E1};w2{M5 𝓂 𝟤E2};𝟣 → 𝟤	#I17 7th
w1{M5 𝓂 𝓂 𝟣E1};w2{M5 𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I18 8th
w1{M5 𝓂 𝓂 𝓂 𝟣E1};w2{M5 𝓂 𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I19 9th
w1{M5 𝓂 𝓂 𝓂 𝓂 𝟣E1};w2{M5 𝓂 𝓂 𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I20 10th
# Allow one to define a symbol to map to another:
𝒶 → 𝒷	#L21 Map
```
### Types
```korekto
Constant[𝐴]	#L22 Constant: Constant
Scalar[𝑎]	#L23 Scalar: Scalar
Vector[𝒂]	#L24 Vector: Vector
Tensor[𝑨]	#L25 Tensor: Tensor
Operator[𝓐]	#L26 Operator: Operator
```
### Addition and Subtraction
```korekto
𝟭 + 𝟮 ⚌ 𝟯;𝟯 - 𝟮 = 𝟭	#M27 +→-: + -
𝟯 - 𝟮 ⚌ 𝟭;𝟭 + 𝟮 = 𝟯	#M28 -→+
𝟭 - 𝟭 = 0	#A29 Zero: 0
𝟭 + 𝟮 = 𝟮 + 𝟭	#A30 Commutes
```
### Multiplication and Division
```korekto
𝟮 * 𝟯 ⚌ 𝟲;𝟲 / 𝟯 = 𝟮	#M31 *→/: * /
𝟲 / 𝟯 ⚌ 𝟮;𝟮 * 𝟯 = 𝟲	#M32 /→*
𝟮 / 𝟮 = 1	#A33 One: 1
# Note: multiplication does not commute in general(e.g. matrices)
```
### Exponentiation and Root
```korekto
𝟮∧𝟯 ⚌ 𝟴;𝟴∨𝟯 = 𝟮	#M34 ∧→∨: ∧ ∨
𝟴∨𝟯 ⚌ 𝟮;𝟮∧𝟯 = 𝟴	#M35 ∨→∧
# Does not commute
# No analogous 𝟛∨𝟛 = N
𝟮∧1 = 𝟮	#A36 x∧1=x
𝟮∧0 = 1	#A37 x∧0=1
𝟴∧-𝟯 = 1 / 𝟴∧𝟯	#A38 Reciprical
```
### Square and Square Root
```korekto
𝟮² = 𝟮 * 𝟮	#A39 Square: ²
𝟮² ⚌ 𝟰;√𝟰 = 𝟮	#M40 ²→√: √
√𝟰 ⚌ 𝟮;𝟮² = 𝟰	#M41 √→²
```
### Exponentiation and Logarithm
```korekto
𝟮∧𝟯 ⚌ 𝟴;𝟮𝓵𝟴 = 𝟯	#M42 ∧→𝓵: 𝓵
𝟮𝓵𝟴 ⚌ 𝟯;𝟮∧𝟯 = 𝟴	#M43 𝓵→∧
𝟮𝓵1 = 0	#A44 xl1=0
```
### Digits
```korekto
1 - 1 = 0	#T45/A29 Zero
0 + 1 = 1	#R46/M28,T45 -→+
# This is an exemplary use of `:`
1 + 1 : 2	#S47/L1 ≝: 2
2 + 1 : 3	#S48/L1 ≝: 3
3 + 1 : 4	#S49/L1 ≝: 4
4 + 1 : 5	#S50/L1 ≝: 5
5 + 1 : 6	#S51/L1 ≝: 6
6 + 1 : 7	#S52/L1 ≝: 7
7 + 1 : 8	#S53/L1 ≝: 8
8 + 1 : 9	#S54/L1 ≝: 9
```
### Show multiplication as repeated addition
```korekto
𝟭 ⚌ 𝟭;𝟭 * 1 = 𝟭	#M55 Single
𝟭 + 𝟭 ⚌ 𝟮;𝟭 * 2 = 𝟮	#M56 Double
𝟭 + 𝟭 + 𝟭 ⚌ 𝟯;𝟭 * 3 = 𝟯	#M57 Triple
```
### Show exponentiation as repeated multiplication
```korekto
𝟮 ⚌ 𝟮;𝟮∧1 = 𝟮	#M58 Linear
𝟮 * 𝟮 ⚌ 𝟰;𝟮∧2 = 𝟰	#M59 Square
𝟮 * 𝟮 * 𝟮 ⚌ 𝟴;𝟮∧3 = 𝟴	#M60 Cube
```
### Inequalities

Here I also introduce an absolute value operator, `⎨`.
This allows use of its closing symbol `⎬` in post-editing.
But to keep the parser simple, I'll treat `⎨` as a unary operator.
```korekto
# Inequalities
𝓍+1 > 𝓍	#A61 Greater than: >
𝓍 > 𝓎;𝓎 > 𝓏;𝓍 > 𝓏	#I62 Transitive >
𝓍 > 𝓎;𝓎 < 𝓍	#M63 Less than: <
𝓍 < 𝓎;𝓎 < 𝓏;𝓍 < 𝓏	#I64 Transitive <
𝓍 > 𝓎;𝓍 ≠ 𝓎	#M65 >→≠: ≠
𝓍 < 𝓎;𝓍 ≠ 𝓎	#M66 <→≠
# Absolute value
⎨𝓍 = ⎨-𝓍	#A67 Absolute: ⎨
𝓍 < 0;⎨𝓍 = -𝓍	#M68 ⎨<0
𝓍 > 0;⎨𝓍 = 𝓍	#M69 ⎨>0
𝓍 = 0;⎨𝓍 = 0	#M70 ⎨=0
# Greater/Less than or equal
⎨𝓍 ≥ 0	#A71 Greater than or equal: ≥
0 ≤ ⎨𝓍	#A72 Less than or equal: ≤
```
### Names, indices, and labels
```korekto
# Digits
Digits{0 1 2 3 4 5 6 7 8 9}	#S73/L4 Named set: Digits
SubDigits{₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉}	#S74/L4 Named set: SubDigits ₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉
SupDigits{⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹}	#S75/L4 Named set: SupDigits ⁰ ¹ ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹
SubSymbols{₊ ₋ ₌ ₍ ₎}	#S76/L4 Named set: SubSymbols ₌ ₍ ₎
SupSymbols{⁺ ⁻ ⁼ ⁽ ⁾}	#S77/L4 Named set: SupSymbols ⁺ ⁻ ⁼ ⁽ ⁾
Constant[𝑁]	#S78/L22 Constant: 𝑁
ᴺ → 𝑁	#S79/L21 Map: ᴺ
Scalar[𝑛]	#S80/L23 Scalar: 𝑛
ₙ → 𝑛	#S81/L21 Map: ₙ
ⁿ → 𝑛	#S82/L21 Map: ⁿ
Scalar[𝑖]	#S83/L23 Scalar: 𝑖
ᵢ → 𝑖	#S84/L21 Map: ᵢ
ⁱ → 𝑖	#S85/L21 Map: ⁱ
```
### Sums
```korekto
# Bold script capital 𝓝 is an operator.
𝓝ᵢ𝓍 = ∑ᵢ₌₁ᴺ𝓍	#A86 Finite sum: 𝓝 ∑
# Italic capital 𝑁 is a number.
𝑁 = 𝓝ᵢ1	#A87 Finite number
# Need a way to have a conditional loop not terminate...
# Infinity is bigger than any finite number.
∞ > 𝑁	#D88 Infinity
𝑁 < ∞	#R89/M63,D88 Less than
# If the summation interval is not specified,
# the default is to run the sum from zero to infinity.
∑ᵢ𝓍 = ∑ᵢ₌₀∞𝓍	#A90 Infinite sum
```
### Products
```korekto
ʲ → 𝒶;ᵢ → 𝒷;𝒶! = ∏ᵢ₌₁ʲ𝒷	#I91 Factorial: ! ∏
𝑛! = ∏ᵢ₌₁ⁿ𝑖	#C92/I91,S82,S84 Factorial
```
### Euler's number
```korekto
𝖊 : ∑ₙ 1/𝑛!	#S93/L1 ≝: 𝖊
⌉𝓍 = 𝖊∧𝓍	#A94 Exp: ⌉
⌊𝓍 = 𝖊𝓵𝓍	#A95 Log: ⌊
```
### Infinitessimals
```korekto
𝓍 ≠ 0;⎨𝜀 < ⎨𝓍	#M96 Infinitessimal: 𝜀
𝜀 ≠ 0	#P97 1st order 𝜀
𝜀² = 0	#P98 Vanishing 𝜀
𝜹𝓐(𝒶) = 𝓐(𝒶+𝜀)-𝓐(𝒶)	#A99 Differential: 𝜹
𝓓𝓐(𝒶) = 𝜹𝓐(𝒶)/𝜀	#A100 Derivative: 𝓓
```
## Grouping

### Token grouping
```korekto
S1𝟭S2;S1(𝟭)S2	#M101 a → (a)
S1(𝟭)S2;S1𝟭S2	#M102 (a) → a
# And the above repeated up-to 3 times:
S1𝟭S2𝟮S3;S1(𝟭)S2(𝟮)S3	#M103 a~b → (a)~(b)
S1(𝟭)S2(𝟮)S3;S1𝟭S2𝟮S3	#M104 (a)~(b) → a~b
S1𝟭S2𝟮S3𝟯S4;S1(𝟭)S2(𝟮)S3(𝟯)S4	#M105 a~b~c → (a)~(b)~(c)
S1(𝟭)S2(𝟮)S3(𝟯)S4;S1𝟭S2𝟮S3𝟯S4	#M106 (a)~(b)~(c) → a~b~c
```
### Binary spacing
```korekto
S1(𝟭 ♦ 𝟮)S2;S1(𝟭♦𝟮)S2	#M107 (a_+_b) → (a+b)
S1(𝟭♦𝟮)S2;S1(𝟭 ♦ 𝟮)S2	#M108 (a+b) → (a_+_b)
# Binary group/spaced
S1♮(𝟭♭♦♭𝟮);S1 𝟭♦𝟮	#M109 ♭(a♭+♭b)$ → _a+b$
S1 𝟭♦𝟮;S1♮(𝟭♭♦♭𝟮)	#M110 _a+b$ → ♭(a♭+♭b)$
(𝟭♭♦♭𝟮)♮S1;𝟭♦𝟮 S1	#M111 ^(a♭+♭b)♭ → ^a+b_
𝟭♦𝟮 S1;(𝟭♭♦♭𝟮)♮S1	#M112 ^a+b_ → ^(a♭+♭b)♭
S1 𝟭♦𝟮 S2;S1♮(𝟭♭♦♭𝟮)♮S2	#M113 _a+b_ → ♭(a♭+♭b)♭
S1♮(𝟭♭♦♭𝟮)♮S2;S1 𝟭♦𝟮 S2	#M114 ♭(a♭+♭b)♭ → _a+b_
```
### MultDiv spacing
```korekto
# MultDiv has higher precedence than AddSub
S1☜ 𝟭♚𝟮;S1 𝟭 ♚ 𝟮	#M115 _a*b$ → _a_*_b$
S1☜ 𝟭 ♚ 𝟮;S1 𝟭♚𝟮	#M116 _a_*_b$ → _a*b$
𝟭♚𝟮 S2;𝟭 ♚ 𝟮 S2	#M117 ^a*b_ → ^a_*_b_
𝟭 ♚ 𝟮 S2;𝟭♚𝟮 S2	#M118 ^a_*_b_ → ^a*b_
S1☜ 𝟭 ♚ 𝟮 S2;S1 𝟭♚𝟮 S2	#M119 _a_*_b_ → _a*b_
S1☜ 𝟭♚𝟮 S2;S1 𝟭 ♚ 𝟮 S2	#M120 _a*b_ → _a_*_b_
```
### MutlDiv Grouping
```korekto
# MultDiv has higher precedence than AddSub
S1☜☚⚐𝟭♮♚♮𝟮⚑S2;S1(𝟭♭♚♭𝟮)S2	#M121 +a♭*♭b+ → +(a♭*♭b)+
S1☜☚⚐(𝟭♭♚♭𝟮)⚑S2;S1𝟭♮♚♮𝟮S2	#M122 +(a♭*♭b)+ → +a♭*♭b+
S1☜☚⚐𝟭♮♚♮𝟮;S1(𝟭♭♚♭𝟮)	#M123 +a♭*♭b$ → +(a♭*♭b)$
S1☜☚⚐(𝟭♭♚♭𝟮);S1𝟭♮♚♮𝟮	#M124 +(a♭*♭b)$ → +a♭*♭b$
𝟭♮♚♮𝟮⚑S2;(𝟭♭♚♭𝟮)S2	#M125 ^a♭*♭b+>^(a♭*♭b)+
(𝟭♭♚♭𝟮)⚑S2;𝟭♮♚♮𝟮S2	#M126 ^(a♭*♭b)+ → ^a♭*♭b+
S1♭(𝓍 ♚ g1)♭⚑S2;S1 𝓍♚(g1) S2	#M127 ♭(a_*_g)♭ → _a*(g)_
S1 𝓍♚(g1) S2;S1♭(𝓍 ♚ g1)♭S2	#M128 _a*(g)_ → ♭(a_*_g)♭
S1♭(𝓍 ♚ g1);S1 𝓍♚(g1)	#M129 ♭(a_*_g)$ → _a*(g)$
S1 𝓍♚(g1);S1♭(𝓍 ♚ g1)	#M130 _a*(g)$ → ♭(a_*_g)$
(𝓍 ♚ g1)♭⚑S2;𝓍♚(g1) S2	#M131 ^(a_*_g)♭ → ^a*(g)_
𝓍♚(g1) S2;(𝓍 ♚ g1)♭S2	#M132 ^a*(g)_ → ^(a_*_g)♭
S1♦(𝓍𝓎)♥S2;S1♦𝓍𝓎♥S2	#M133 *(ab)* → *ab*
S1♦𝓍𝓎♥S2;S1♦(𝓍𝓎)♥S2	#M134 *ab* → *(ab)*
S1♦(𝓍𝓎);S1♦𝓍𝓎	#M135 *(ab)$ → *ab$
S1♦𝓍𝓎;S1♦(𝓍𝓎)	#M136 *ab$ → *(ab)$
(𝓍𝓎)♦S2;𝓍𝓎♦S2	#M137 ^(ab)* → ^ab*
𝓍𝓎♦S2;(𝓍𝓎)♦S2	#M138 ^ab* → ^(ab)*
```
### GroupGlob grouping
```korekto
S1♭(g1)♭S2;S1 g1 S2	#M139 ♭(g)♭ → _g_
S1 g1 S2;S1♭(g1)♭S2	#M140 _g_ → ♭(g)♭
S1♭(g1);S1 g1	#M141 ♭(g)$ → _g$
S1 g1;S1♭(g1)	#M142 _g$ → ♭(g)$
(g1)♭S1;g1 S1	#M143 ^(g)♭ → ^g_
g1 S1;(g1)♭S1	#M144 ^g_ → ^(g)♭
# Nested groupings
S1 g1⦆S2;S1 (g1)⦆S2	#M145 _g)→_(g))
S1⦅g1 S2;S1⦅(g1) S2	#M146 (g_→((g)_
```
### Group grouping
```korekto
S1 ⚍ (G1) ⚎ S2;S1 ⚍ G1 ⚎ S2	#M147 +_(G)_+ → +_G_+
S1 ⚍ G1 ⚎ S2;S1 ⚍ (G1) ⚎ S2	#M148 +_G_+ → +_(G)_+
S1 ⚍ G1 ⚎ G2 ⚏ S2;S1 ⚍ (G1) ⚎ (G2) ⚏ S2	#M149 →+_(G)_+_(F)_+
S1 ⚍ (G1) ⚎ (G2) ⚏ S2;S1 ⚍ G1 ⚎ G2 ⚏ S2	#M150 →+_G_+_F_+
S1 ⚍ (G1);S1 ⚍ G1	#M151 +_(G)$ → +_G$
S1 ⚍ G1;S1 ⚍ (G1)	#M152 +_G$ → +_(G)$
(G1) ⚍ S1;G1 ⚍ S1	#M153 ^(G)_+ → ^G_+
G1 ⚍ S1;(G1) ⚍ S1	#M154 ^G_+ → ^(G)_+
# Rare cases ((G))
S1 ⚍ G1⦆S2;S1 ⚍ (G1)⦆S2	#M155 +_G)~ → +_(G))~
S1 ⚍ (G1)⦆S2;S1 ⚍ G1⦆S2	#M156 +_(G))~ → +_G)~
S1⦅G1 ⚍ S2;⦅(G1) ⚍ S2	#M157 ~(G_+ → ~((G)_+
S1⦅(G1) ⚍ S2;⦅G1 ⚍ S2	#M158 ~((G)_+ → ~(G_+
# Rare cases g+f+h
S1 ⚍ g1±g2;S1 ⚍ g1 ± g2	#M159 +_g+f$ → +_g_+_f$
g1±g2 ⚍ S2;g1 ± g2 ⚍ S2	#M160 ^g+f_+ → ^g_+_f_+
S1 ⚎ g1±g2 ⚍ S2;S1 ⚎ g1 ± g2 ⚍ S2	#M161 +_g+f_+ → +_g_+_f_+
```
### Tight grouping
```korekto
S1(𝟭♩𝟮)⚑S2;S1𝟭♩𝟮S2	#M162 (a^b) → a^b
S1𝟭♩𝟮⚑S2;S1(𝟭♩𝟮)S2	#M163 a^b → (a^b)
S1(𝟭♩𝟮)⚑S2(𝟯♪𝟰)⚑S3;S1𝟭♩𝟮S2𝟯♪𝟰S3	#M164 (a^b)~(c^d) → a^b~c^c
S1𝟭♩𝟮⚑S2𝟯♪𝟰⚑S3;S1(𝟭♩𝟮)S2(𝟯♪𝟰)S3	#M165 a^b~c^d → (a^b)~(c^c)
```
## Algebra

### Implied/Explicit multiplication
```korekto
S1𝟭♭𝟮S2;S1𝟭♮*♮𝟮S2	#M166 Explicit*
S1𝟭♮*♮𝟮S2;S1𝟭♭𝟮S2	#M167 Implied*
```
### Equality
```korekto
N1 ⚌ N2;N2 = N1	#M168 Symmetry
N1 = N1	#A169 Reflection
```
### Transitive
```korekto
N1 ⚌ N2;N2 ⚌ N3;N1 = N3	#I170 a=b;b=c;a=c
N1 ⚌ N2;N2 ⚌ N3;N3 = N1	#I171 a=b;b=c;c=a
N1 ⚌ N2;N3 ⚌ N2;N1 = N3	#I172 a=b;c=b;a=c
N1 ⚌ N2;N3 ⚌ N2;N3 = N1	#I173 a=b;c=b;c=a
```
### One
```korekto
# (a/a) 𝓇 𝓈
𝓇(𝟭♭/♭𝟭)𝓈;𝓇1𝓈	#M174 (a/a)→1
𝓇(g1 / g1)𝓈;𝓇1𝓈	#M175 (g / g)→1
# *One*
S1♭*♭1 S2;S1 S2	#M176 *1_
S1 ⚬1♭*♭S2;S1 ⚬S2	#M177 _1*
```
### Zero
```korekto
𝓇(𝟭♭-♭𝟭)𝓈;𝓇0𝓈	#M178 (a-a)→0
S1♭+♭𝟭♭-♭𝟭♭±♭S2;S1♭±♭S2	#M179 +a-a± → ±
S1♭-♭𝟭♭+♭𝟭♭±♭S2;S1♭±♭S2	#M180 -a+a± → ±
S1♭+♭𝟭♭-♭𝟭;S1	#M181 +a-a$ → $
S1♭-♭𝟭♭+♭𝟭;S1	#M182 -a+a$ → $
S1+𝟭-𝟭 S2;S1 S2	#M183 +a-a_
S1-𝟭+𝟭 S2;S1 S2	#M184 -a+a_
S1 𝟭+𝟭-S2;S1 S2	#M185 _a+a-
S1 𝟭-𝟭+S2;S1 S2	#M186 _a-a+
# Order here matters. This one is tested first:
S1♭⚀♭0♭⚀♭S2;S1♭+♭S2	#M187 ±0± → +
# This one is tested after the above:
S1♭±♭0♭⚀♭S2;S1♭-♭S2	#M188 ±0+ → -
```
### (a/b)
```korekto
S1 𝟭♭/♭𝟮;S1 𝟯*𝟭 / 𝟯*𝟮	#M189 _x*a_/_x*b$
S1 𝟭♭/♭𝟮 S2;S1 𝟯*𝟭 / 𝟯*𝟮 S2	#M190 _x*a_/_x*b_
𝟭♭/♭𝟮 S2;𝟯*𝟭 / 𝟯*𝟮 S2	#M191 ^x*a_/_x*b_
S1(𝟭♭/♭𝟮)S2;S1(𝟯*𝟭 / 𝟯*𝟮)S2	#M192 (x*a_/_x*b)
S1(g1 / g2)S2;S1(𝟭*(g1) / 𝟭*(g2))S2	#M193 (x*(g)_/_x*(f))
S1𝟭*(1♭/♭𝟮)⚑S2;S1(𝟭♮/♮𝟮)S2	#M194 x*(1/y) → (x/y)
S1𝟭*(1 / g1)⚑S2;S1(𝟭 / g1)S2	#M195 x*(1_/_g) → (x_/_g)
S1 1♭±♭(𝟭 / g2)⚑S2;S1 (g2±𝟭 / g2)S2	#M196 _1±(a_/_g) → (g±a / g)
S1 𝓍/𝓎²;S1 𝓍/𝓎 1/𝓎	#M197 _a/b²$→_a/b_1/b$
𝓍/𝓎² S2;𝓍/𝓎 1/𝓎 S2	#M198 ^a/b²_→^a/b_1/b$_
S1 𝓍/𝓎² S2;S2 𝓍/𝓎 1/𝓎 S2	#M199 _a/b²_→_a/b_1/b$_
```
### Distribute
```korekto
S1𝟭*(𝟮♭±♭𝟯)⚑S2;S1(𝟭*𝟮♮±♮𝟭*𝟯)S2	#M200 (x*a♭±♭x*b)
S1𝟭*(g2 ± g3)⚑S2;S1(𝟭*(g2)♭±♭𝟭*(g3))S2	#M201 (x*(g)♭±♭x*(f))
```
### Substitution
```korekto
𝟭 ⚌ 𝟮;S1𝟭S2;S1𝟮S2	#I202 a=b,a→b
𝟭 ⚌ 𝟮;S1𝟭S2𝟭S3;S1𝟮S2𝟮S3	#I203 a=b,2*a→b
𝟭 ⚌ 𝟮;S1𝟭S2𝟭S3𝟭S4;S1𝟮S2𝟮S3𝟮S4	#I204 a=b,3*a→b
𝟭 ⚌ g1;S1 g1⦆S2;S1 𝟭⦆S2	#I205 a=g,_g)→_a)
g1 ⚌ 𝟭;S1 g1⦆S2;S1 𝟭⦆S2	#I206 g=a,_g)→_a)
𝟭 ⚌ g1;S1⦅g1 S2;S1⦅𝟭 S2	#I207 a=g,(g_→(a_
g1 ⚌ 𝟭;S1⦅g1 S2;S1⦅𝟭 S2	#I208 g=a,(g_→(a_
g1 ⚌ g2;S1 g1 S2;S1 g2 S2	#I209 g=f,_g_→_f_
g1 ⚌ g2;S1 g2 S2;S1 g1 S2	#I210 g=f,_f_→_g_
g1 ⚌ g2;S1 g1;S1 g2	#I211 g=f,_g$→_f$
g1 ⚌ g2;S1 g2;S1 g1	#I212 g=f,_f$→_g$
g1 ⚌ g2;g1 S2;g2 S2	#I213 g=f,^g_→^f_
g1 ⚌ g2;g2 S2;g1 S2	#I214 g=f,^f_→^g_
𝟭 ⚌ N1;S1𝟭S2;S1(N1)S2	#I215 a=G,a→(G)
N1 ⚌ 𝟭;S1𝟭S2;S1(N1)S2	#I216 G=a,a→(G)
# The above twice below
N1 ⚌ 𝟭;S1(N1)S2(N1)S3;S1𝟭S2𝟭S3	#I217 G=a,(G)→a~a
𝟭 ⚌ N1;S1(N1)S2;S1𝟭S2	#I218 a=G,(G)→a
N1 ⚌ 𝟭;S1(N1)S2;S1𝟭S2	#I219 G=a,(G)→a
N1 ⚌ N2;S1(N1)S2;S1(N2)S2	#I220 G=F,(G)→(F)
N1 ⚌ N2;S1(N2)S2;S1(N1)S2	#I221 G=F,(F)→(G)
N1 ⚌ N2;N1 ⚍ S1;N2 ⚍ S1	#I222 G=F, ^G_+ → ^F_+
N1 ⚌ N2;N2 ⚍ S1;N1 ⚍ S1	#I223 G=F, ^F_+ → ^G_+
N1 ⚌ N2;S1 ⚍ N1;S1 ⚍ N2	#I224 G=F, +_G$ → +_F$
N1 ⚌ N2;S1 ⚍ N2;S1 ⚍ N1	#I225 G=F, +_F$ → +_G$
N1 ⚌ N2;S1 ⚍ N1 ⚎ S2;S1 ⚍ N2 ⚎ S2	#I226 G=F, +_G_+ → +_F_+
N1 ⚌ N2;S1 ⚍ N2 ⚎ S2;S1 ⚍ N1 ⚎ S2	#I227 G=F, +_F_+ → +_G_+
```
### Adding
```korekto
S1(𝟭 + -𝟮)S2;S1(𝟭♮-♮𝟮)S2	#M228 a+-b=a-b
S1(𝟭♭-♭𝟮)S2;S1(𝟭 + -𝟮)S2	#M229 a-b=a+-b
S1⚐𝟭∧𝟮*𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M230 a^b*a^c=a^(b+c)
S1⚐𝟭∧𝟮𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M231 a^ba^c=a^(b+c)
S1⚐𝟭∧(𝟮♭+♭𝟯)⚑S2;S1𝟭∧𝟮*𝟭∧𝟯S2	#M232 a^(b+c)=a^b*a^c
S1(𝟭♭+♭𝟮)S2;S1(𝟮♮+♮𝟭)S2	#M233 (a+b)→(b+a)
```
### Subtracting
```korekto
S1♭--𝟭♮S2;S1♭𝟭♮S2	#M234 --a→a
𝓍 = -𝓎;-𝓍 = 𝓎	#M235 a=-b;-a=-b
```
### Balancing
```korekto
𝓍 = 𝓊 g1;𝓐𝓍 = 𝓐𝓊 g1	#M236 x_=_G_g;Fx_=_FG_g
```
## Functions
```korekto
# Natural log
⌊ 𝓍/𝓎 = ⌊𝓍 - ⌊𝓎	#A237 ⌊(a/b)=⌊a-⌊b
# Squash
⌈𝓍 = 1 / 1+⌉-𝓍	#A238 Squash: ⌈
# Unsquash
⌋𝓍 = ⌊ 𝓍/(1-𝓍)	#A239 Unsquash: ⌋
# Binary balance
# 𝓑 is being used as a pattern key, so I temporarily replace it:
! replace! 𝓑 TMP
# Now I can define 𝓑 in an axiom:
𝓑𝓍 = (1-𝓍)*𝓍	#A240 Binary balance: 𝓑
! replace! TMP 𝓑
```
## Calculus
```korekto
# Derivatives
# Constant Rule
𝓓ᵢ𝖆 = 0	#A241 Constant rule
# Power Rule
𝓓ᵢ(𝓍∧𝖆) = 𝖆*𝓍∧(𝖆-1)*𝓓ᵢ𝓍	#A242 Power rule
# Sum and Difference Rules
𝓓ᵢ(𝓍 + 𝓎) = 𝓓ᵢ𝓍 + 𝓓ᵢ𝓎	#A243 Sum rule
# Product Rule
𝓓ᵢ(𝓍*𝓎) = 𝓓ᵢ𝓍*𝓎 + 𝓍*𝓓ᵢ𝓎	#A244 Product rule
# Quotient Rule
𝓓ᵢ(𝓍 / 𝓎) = (𝓓ᵢ(𝓍)𝓎 - 𝓍𝓓ᵢ(𝓎)) / 𝓎²	#A245 Quotient rule
𝓓ᵢ(1 / 1+𝓍) = -𝓓ᵢ𝓍 / (1+𝓍)²	#A246 From quotient rule
# Chain Rule
# This one is meta.  :-??
# 𝓓ᵢ 𝓐𝓑𝓍 = (𝓓𝓐)𝓑𝓍*(𝓓𝓑)𝓍*𝓓ᵢ𝓍	#A244 Chain rule
# Exponential
𝓓ᵢ(𝖆∧𝓍) = ⌊𝖆𝓓ᵢ(𝓍)𝖆∧𝓍	#A247 D(a^x)=log(a)D(x)a^x
𝓓ᵢ(𝖊∧𝓍) = 𝓓ᵢ(𝓍)𝖊∧𝓍	#A248 D(e^x)=D(x)e^x
# Computations:
𝓓ᵢ(-𝓍) = -𝓓ᵢ(𝓍)	#A249 𝓓ₓ(-𝑦)=-𝓓(𝑦)
ᵢ → 𝑎;𝓓ᵢ𝑎 = 1	#M250 𝓓ₓ𝑥=1
ᵢ → 𝑎;𝓓ᵢ(-𝑎) = -1	#M251 𝓓ₓ-𝑥=-1
```
## Vector notation

Let `𝑥,𝑦,𝑧` be in `ℝ`, real numbers.

* Column vector: `𝒗 = 〈𝑥,𝑦,𝑧〉 = |𝑥,𝑦,𝑧⟩`
* Row vector: `𝒗ᵀ = [𝑥,𝑦,𝑧] = ⟨𝑥,𝑦,𝑧|`
* Dot product: `𝒗∙𝒗 = 𝒗ᵀ𝒗 = [𝑥,𝑦,𝑧]〈𝑥,𝑦,𝑧〉 = ⟨𝑥,𝑦,𝑧|𝑥,𝑦,𝑧⟩ = 𝑥²+𝑦²+𝑧²`

For `𝑥,𝑦,𝑧` in `ℂ`, complex numbers:

* `⟨𝑥,𝑦,𝑧|𝑥,𝑦,𝑧⟩ = 𝒗†𝒗 = 𝑥*𝑥 + 𝑦*𝑦 + 𝑧*𝑧`

## Matrix notation

Consider `𝒕 = 〈t11,t12,t13〉`, `𝒖 = 〈u21,u22,u23〉`, and `𝒗 = 〈v31,v32,v33〉`.
Notice the pattern glob `t1*`, `u2*`, and `v3*` for the names of the components.
Consider matrix `𝑴 = [𝒕ᵀ,𝒖ᵀ,𝒗ᵀ]`.
Then `𝑴` has these equivalent representations:

* Row (right) viewed: `𝑴 = [[t11,t12,t13],[u21,u22,u23],[v31,v32,v33]]`
* Column (left) viewed: `𝑴 = [〈t11,u21,v31〉,〈t12,u22,v32〉,〈t13,u23,v33〉]`

Graphically:
```text
    |t11 t12 t13|
𝑴 = |u21 u22 u23|
    |v31 v32 v33|
```
When a matrix is defined in the form `𝑴 = [𝒕ᵀ,𝒖ᵀ,𝒗ᵀ]`,
I will refer to the vector components as follows:

* `𝑴ᵗ = 𝒕ᵀ;𝑴ₜ = 𝒕`
* `𝑴ᵘ = 𝒖ᵀ;𝑴ᵤ = 𝒖`
* `𝑴ᵛ = 𝒗ᵀ;𝑴ᵥ = 𝒗`

I can then refer to the component numbers of the vector as follows:

* `𝑴ᵗⱼ = 𝒕ᵀⱼ = 𝒕ⱼ = 𝑴¹ⱼ`
* `𝑴ᵘⱼ = 𝒖ᵀⱼ = 𝒖ⱼ = 𝑴²ⱼ`
* `𝑴ᵛⱼ = 𝒗ᵀⱼ = 𝒗ⱼ = 𝑴³ⱼ`

##  [Einstein notation](https://en.wikipedia.org/wiki/Einstein_notation)

> ..the 𝑚-th row and 𝑛-th column of a matrix 𝑨 becomes 𝑨ᵐₙ

* `𝑴[𝑖,𝑗] = 𝑴ⁱⱼ` 

In context of covariant and contravariant components of a vector:

* Convariant components: `𝒗ᵢ`
* Contravariant components: `𝒗ⁱ`

In context of row and column vectors:

* Column vector: `𝒗ᵢ`
* Row vector: `𝒗ⁱ`

So despite the Wikipedia article(which prefers writing `𝒗ᵢ𝒗ⁱ`):

* `𝒗∙𝒗 = 𝒗ᵀ𝒗 = 𝒗ⁱ𝒗ᵢ = ∑ᵢ (𝒗ᵢ)²`
```korekto
ᵢ → 𝑎;ⁱ → 𝑎;∑ᵢ(𝓍ᵢ𝓎ᵢ) = 𝓍ⁱ𝓎ᵢ	#I252 Einstein notation
```
