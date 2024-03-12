# Korekto Math

Imported by:

* [Two Cube](../examples/TwoCube.md)
* [Neuronet](../examples/Neuronet.md)

## Contents

* [Notes](#Notes)
* [Syntax](#Syntax)
* [Patterns](#Patterns)
* [Definitions](#Definitions)
* [Grouping](#Grouping)
* [Algebra](#Algebra)
* [Functions](#Functions)
* [Calculus](#Calculus)
* [Vector notation](#Vector-notation)
* [Matrix notation](#Matrix-notation)
* [Einstein notation](#Einstein-notation)

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
| Scalar | [𝑎-𝑧¼½¾]| 𝑎 𝑏 𝑐 | Italic Small |
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
| PreLoose | [+&lt;&gt;=≠≤≥:] | ⚍ ⚎ | Miscellaneous Symbols |
| PostLoose | [-+&lt;&gt;=≠≤≥:] | ⚏ | Miscellaneous Symbols |
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
! Scalar /[𝑎-𝑧¼½¾]/
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
! PreLoose /[+<>=≠≤≥:]/
! PreLoose {⚍ ⚎}
! PostLoose /[-+<>=≠≤≥:]/
! PostLoose {⚏}
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
# One can think of `{a b c}[b]` as eqivalent to `{a b c}[b] = b`.
# A[𝓍] is "truthy" iff 𝓍∊A.
𝓅 ⚌ {E1𝓍E2};𝓅[𝓍]	#M4 Membership: { } [ ]
𝓅[𝓍];𝓍 ∊ 𝓅	#M5 Element of: ∊
```
### Member operators
```korekto
𝓅 ⚌ {E1𝟣 𝟤E2};𝟣₊ = 𝟤	#M6 Next: ₊
𝓅 ⚌ {E1𝟣 𝟤E2};𝟤₋ = 𝟣	#M7 Previous: ₋
```
### Methods on words
```korekto
𝓅 ⚌ {𝟣E1};𝓅.first = 𝟣	#M8 First: . first
𝓅 ⚌ {E1𝟣};𝓅.last = 𝟣	#M9 Last: last
```
### Replace
```korekto
# When semantically appropriate,
# one can replace one label with another having the same "order value"
𝓅 ⚌ {𝟣E1};𝓆 ⚌ {𝟤E2};𝟣 → 𝟤	#I10 1st: →
𝓅 ⚌ {𝓂 𝟣E1};𝓆 ⚌ {𝓂 𝟤E2};𝟣 → 𝟤	#I11 2nd
𝓅 ⚌ {𝓂 𝓂 𝟣E1};𝓆 ⚌ {𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I12 3rd
𝓅 ⚌ {𝓂 𝓂 𝓂 𝟣E1};𝓆 ⚌ {𝓂 𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I13 4th
𝓅 ⚌ {𝓂 𝓂 𝓂 𝓂 𝟣E1};𝓆 ⚌ {𝓂 𝓂 𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I14 5th
𝓅 ⚌ {M5 𝟣E1};𝓆 ⚌ {M5 𝟤E2};𝟣 → 𝟤	#I15 6th
𝓅 ⚌ {M5 𝓂 𝟣E1};𝓆 ⚌ {M5 𝓂 𝟤E2};𝟣 → 𝟤	#I16 7th
𝓅 ⚌ {M5 𝓂 𝓂 𝟣E1};𝓆 ⚌ {M5 𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I17 8th
𝓅 ⚌ {M5 𝓂 𝓂 𝓂 𝟣E1};𝓆 ⚌ {M5 𝓂 𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I18 9th
𝓅 ⚌ {M5 𝓂 𝓂 𝓂 𝓂 𝟣E1};𝓆 ⚌ {M5 𝓂 𝓂 𝓂 𝓂 𝟤E2};𝟣 → 𝟤	#I19 10th
# Allow one to define a symbol to replace to another:
𝒶 → 𝒷	#L20 Replace
ᵢ → 𝒶;ⁱ → 𝑎;ᵢ → ⁱ	#I21 Raise
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
𝑎 * 𝑏 = 𝑏 * 𝑎	#A34 Scalar Commutes
```
### Exponentiation and Root
```korekto
𝟮∧𝟯 ⚌ 𝟴;𝟴∨𝟯 = 𝟮	#M35 ∧→∨: ∧ ∨
𝟴∨𝟯 ⚌ 𝟮;𝟮∧𝟯 = 𝟴	#M36 ∨→∧
# Does not commute
# No analogous 𝟛∨𝟛 = N
𝟮∧1 = 𝟮	#A37 x∧1=x
𝟮∧0 = 1	#A38 x∧0=1
𝟴∧-𝟯 = 1 / 𝟴∧𝟯	#A39 Reciprical
```
### Square and Square Root
```korekto
𝟮² = 𝟮 * 𝟮	#A40 Square: ²
𝟮² ⚌ 𝟰;√𝟰 = 𝟮	#M41 ²→√: √
√𝟰 ⚌ 𝟮;𝟮² = 𝟰	#M42 √→²
```
### Exponentiation and Logarithm
```korekto
𝟮∧𝟯 ⚌ 𝟴;𝟮𝓵𝟴 = 𝟯	#M43 ∧→𝓵: 𝓵
𝟮𝓵𝟴 ⚌ 𝟯;𝟮∧𝟯 = 𝟴	#M44 𝓵→∧
𝟮𝓵1 = 0	#A45 xl1=0
```
### Digits
```korekto
1 - 1 = 0	#T46/A29 Zero
0 + 1 = 1	#R47/M28,T46 -→+
# This is an exemplary use of `:`
1 + 1 : 2	#S48/L1 ≝: 2
2 + 1 : 3	#S49/L1 ≝: 3
3 + 1 : 4	#S50/L1 ≝: 4
4 + 1 : 5	#S51/L1 ≝: 5
5 + 1 : 6	#S52/L1 ≝: 6
6 + 1 : 7	#S53/L1 ≝: 7
7 + 1 : 8	#S54/L1 ≝: 8
8 + 1 : 9	#S55/L1 ≝: 9
```
### Fractions
```korekto
¼ : 1/4	#S56/L1 ≝: ¼
½ : 1/2	#S57/L1 ≝: ½
¾ : 3/4	#S58/L1 ≝: ¾
```
### Show multiplication as repeated addition
```korekto
𝟭 ⚌ 𝟭;𝟭 * 1 = 𝟭	#M59 Single
𝟭 + 𝟭 ⚌ 𝟮;𝟭 * 2 = 𝟮	#M60 Double
𝟭 + 𝟭 + 𝟭 ⚌ 𝟯;𝟭 * 3 = 𝟯	#M61 Triple
```
### Show exponentiation as repeated multiplication
```korekto
𝟮 ⚌ 𝟮;𝟮∧1 = 𝟮	#M62 Linear
𝟮 * 𝟮 ⚌ 𝟰;𝟮∧2 = 𝟰	#M63 Square
𝟮 * 𝟮 * 𝟮 ⚌ 𝟴;𝟮∧3 = 𝟴	#M64 Cube
```
### Inequalities

Here I also introduce an absolute value operator, `⎨`.
This allows use of its closing symbol `⎬` in post-editing.
But to keep the parser simple, I'll treat `⎨` as a unary operator.
```korekto
# Inequalities
𝓍+1 > 𝓍	#A65 Greater than: >
𝓍 > 𝓎;𝓎 > 𝓏;𝓍 > 𝓏	#I66 Transitive >
𝓍 > 𝓎;𝓎 < 𝓍	#M67 Less than: <
𝓍 < 𝓎;𝓎 < 𝓏;𝓍 < 𝓏	#I68 Transitive <
𝓍 > 𝓎;𝓍 ≠ 𝓎	#M69 >→≠: ≠
𝓍 < 𝓎;𝓍 ≠ 𝓎	#M70 <→≠
# Absolute value
⎨𝓍 = ⎨-𝓍	#A71 Absolute: ⎨
𝓍 < 0;⎨𝓍 = -𝓍	#M72 ⎨<0
𝓍 > 0;⎨𝓍 = 𝓍	#M73 ⎨>0
𝓍 = 0;⎨𝓍 = 0	#M74 ⎨=0
# Greater/Less than or equal
⎨𝓍 ≥ 0	#A75 Greater than or equal: ≥
0 ≤ ⎨𝓍	#A76 Less than or equal: ≤
```
### Names, indices, and labels
```korekto
# Digits
Digits : {0 1 2 3 4 5 6 7 8 9}	#S77/L1 ≝: Digits
SubDigits : {₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉}	#S78/L1 ≝: SubDigits ₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉
SupDigits : {⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹}	#S79/L1 ≝: SupDigits ⁰ ¹ ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹
SubSymbols : {₊ ₋ ₌ ₍ ₎}	#S80/L1 ≝: SubSymbols ₌ ₍ ₎
SupSymbols : {⁺ ⁻ ⁼ ⁽ ⁾}	#S81/L1 ≝: SupSymbols ⁺ ⁻ ⁼ ⁽ ⁾
Constant[𝑁]	#S82/L22 Constant: 𝑁
ᴺ → 𝑁	#S83/L20 Replace: ᴺ
Scalar[𝑛]	#S84/L23 Scalar: 𝑛
ₙ → 𝑛	#S85/L20 Replace: ₙ
ⁿ → 𝑛	#S86/L20 Replace: ⁿ
ₙ → ⁿ	#C87/I21,S85,S86 Raise
Scalar[𝑖]	#S88/L23 Scalar: 𝑖
ᵢ → 𝑖	#S89/L20 Replace: ᵢ
ⁱ → 𝑖	#S90/L20 Replace: ⁱ
ᵢ → ⁱ	#C91/I21,S89,S90 Raise
```
### Sums
```korekto
# Bold script capital 𝓝 is an operator.
𝓝ᵢ𝓍 = ∑ᵢ₌₁ᴺ𝓍	#A92 Finite sum: 𝓝 ∑
# Italic capital 𝑁 is a number.
𝑁 = 𝓝ᵢ1	#A93 Finite number
# Need a way to have a conditional loop not terminate...
# Infinity is bigger than any finite number.
∞ > 𝑁	#D94 Infinity: ∞
𝑁 < ∞	#R95/M67,D94 Less than
# If the summation interval is not specified,
# the default is to run the sum from zero to infinity.
∑ᵢ𝓍 = ∑ᵢ₌₀∞𝓍	#A96 Infinite sum
```
### Products
```korekto
ʲ → 𝒶;ᵢ → 𝒷;𝒶! = ∏ᵢ₌₁ʲ𝒷	#I97 Factorial: ! ∏
𝑛! = ∏ᵢ₌₁ⁿ𝑖	#C98/I97,S86,S89 Factorial
```
### Euler's number
```korekto
𝖊 : ∑ₙ 1/𝑛!	#S99/L1 ≝: 𝖊
⌉𝓍 = 𝖊∧𝓍	#A100 Exp: ⌉
⌊𝓍 = 𝖊𝓵𝓍	#A101 Log: ⌊
```
### Infinitessimals
```korekto
𝓍 ≠ 0;⎨𝜀 < ⎨𝓍	#M102 Infinitessimal: 𝜀
𝜀 ≠ 0	#P103 1st order 𝜀
𝜀² = 0	#P104 Vanishing 𝜀
𝜹𝓐(𝒶) = 𝓐(𝒶+𝜀)-𝓐(𝒶)	#A105 Differential: 𝜹
𝓓𝓐(𝒶) = 𝜹𝓐(𝒶)/𝜀	#A106 Derivative: 𝓓
```
## Grouping

### Token grouping
```korekto
S1𝟭S2;S1(𝟭)S2	#M107 a → (a)
S1(𝟭)S2;S1𝟭S2	#M108 (a) → a
# And the above repeated up-to 3 times:
S1𝟭S2𝟮S3;S1(𝟭)S2(𝟮)S3	#M109 a~b → (a)~(b)
S1(𝟭)S2(𝟮)S3;S1𝟭S2𝟮S3	#M110 (a)~(b) → a~b
S1𝟭S2𝟮S3𝟯S4;S1(𝟭)S2(𝟮)S3(𝟯)S4	#M111 a~b~c → (a)~(b)~(c)
S1(𝟭)S2(𝟮)S3(𝟯)S4;S1𝟭S2𝟮S3𝟯S4	#M112 (a)~(b)~(c) → a~b~c
```
### Binary spacing
```korekto
S1(𝟭 ♦ 𝟮)S2;S1(𝟭♦𝟮)S2	#M113 (a_+_b) → (a+b)
S1(𝟭♦𝟮)S2;S1(𝟭 ♦ 𝟮)S2	#M114 (a+b) → (a_+_b)
# Binary group/spaced
S1♮(𝟭♭♦♭𝟮);S1 𝟭♦𝟮	#M115 ♭(a♭+♭b)$ → _a+b$
S1 𝟭♦𝟮;S1♮(𝟭♭♦♭𝟮)	#M116 _a+b$ → ♭(a♭+♭b)$
(𝟭♭♦♭𝟮)♮S1;𝟭♦𝟮 S1	#M117 ^(a♭+♭b)♭ → ^a+b_
𝟭♦𝟮 S1;(𝟭♭♦♭𝟮)♮S1	#M118 ^a+b_ → ^(a♭+♭b)♭
S1 𝟭♦𝟮 S2;S1♮(𝟭♭♦♭𝟮)♮S2	#M119 _a+b_ → ♭(a♭+♭b)♭
S1♮(𝟭♭♦♭𝟮)♮S2;S1 𝟭♦𝟮 S2	#M120 ♭(a♭+♭b)♭ → _a+b_
```
### MultDiv spacing
```korekto
# MultDiv has higher precedence than AddSub
S1☜ 𝟭♚𝟮;S1 𝟭 ♚ 𝟮	#M121 _a*b$ → _a_*_b$
S1☜ 𝟭 ♚ 𝟮;S1 𝟭♚𝟮	#M122 _a_*_b$ → _a*b$
𝟭♚𝟮 S2;𝟭 ♚ 𝟮 S2	#M123 ^a*b_ → ^a_*_b_
𝟭 ♚ 𝟮 S2;𝟭♚𝟮 S2	#M124 ^a_*_b_ → ^a*b_
S1☜ 𝟭 ♚ 𝟮 S2;S1 𝟭♚𝟮 S2	#M125 _a_*_b_ → _a*b_
S1☜ 𝟭♚𝟮 S2;S1 𝟭 ♚ 𝟮 S2	#M126 _a*b_ → _a_*_b_
S1 𝟭/(𝟮♭♦♭𝟯);S1 𝟭 / 𝟮♦𝟯	#M127 _a/(b♭+♭c)$→_a_/_b+c$
S1 𝟭 / 𝟮♦𝟯;S1 𝟭/(𝟮♭♦♭𝟯)	#M128 _a_/_b+c$→_a/(b♭+♭c)$
S1 𝟭/(𝟮♭♦♭𝟯) S2;S1 𝟭 / 𝟮♦𝟯 S2	#M129 _a/(b♭+♭c)_→_a_/_b+c_
S1 𝟭 / 𝟮♦𝟯 S2;S1 𝟭/(𝟮♭♦♭𝟯) S2	#M130 _a_/_b+c_→_a/(b♭+♭c)_
𝟭/(𝟮♭♦♭𝟯) S2;𝟭 / 𝟮♦𝟯 S2	#M131 ^a/(b♭+♭c)_→^a_/_b+c_
𝟭 / 𝟮♦𝟯 S2;𝟭/(𝟮♭♦♭𝟯) S2	#M132 ^a_/_b+c_→^a/(b♭+♭c)_
```
### MutlDiv Grouping
```korekto
# MultDiv has higher precedence than AddSub
S1☜☚⚐𝟭♮♚♮𝟮⚑S2;S1(𝟭♭♚♭𝟮)S2	#M133 +a♭*♭b+ → +(a♭*♭b)+
S1☜☚⚐(𝟭♭♚♭𝟮)⚑S2;S1𝟭♮♚♮𝟮S2	#M134 +(a♭*♭b)+ → +a♭*♭b+
S1☜☚⚐𝟭♮♚♮𝟮;S1(𝟭♭♚♭𝟮)	#M135 +a♭*♭b$ → +(a♭*♭b)$
S1☜☚⚐(𝟭♭♚♭𝟮);S1𝟭♮♚♮𝟮	#M136 +(a♭*♭b)$ → +a♭*♭b$
𝟭♮♚♮𝟮⚑S2;(𝟭♭♚♭𝟮)S2	#M137 ^a♭*♭b+>^(a♭*♭b)+
(𝟭♭♚♭𝟮)⚑S2;𝟭♮♚♮𝟮S2	#M138 ^(a♭*♭b)+ → ^a♭*♭b+
S1♭(𝓍 ♚ g1)♭⚑S2;S1 𝓍♚(g1) S2	#M139 ♭(a_*_g)♭ → _a*(g)_
S1 𝓍♚(g1) S2;S1♭(𝓍 ♚ g1)♭S2	#M140 _a*(g)_ → ♭(a_*_g)♭
S1♭(𝓍 ♚ g1);S1 𝓍♚(g1)	#M141 ♭(a_*_g)$ → _a*(g)$
S1 𝓍♚(g1);S1♭(𝓍 ♚ g1)	#M142 _a*(g)$ → ♭(a_*_g)$
(𝓍 ♚ g1)♭⚑S2;𝓍♚(g1) S2	#M143 ^(a_*_g)♭ → ^a*(g)_
𝓍♚(g1) S2;(𝓍 ♚ g1)♭S2	#M144 ^a*(g)_ → ^(a_*_g)♭
S1♦(𝓍𝓎)♥S2;S1♦𝓍𝓎♥S2	#M145 *(ab)* → *ab*
S1♦𝓍𝓎♥S2;S1♦(𝓍𝓎)♥S2	#M146 *ab* → *(ab)*
S1♦(𝓍𝓎);S1♦𝓍𝓎	#M147 *(ab)$ → *ab$
S1♦𝓍𝓎;S1♦(𝓍𝓎)	#M148 *ab$ → *(ab)$
(𝓍𝓎)♦S2;𝓍𝓎♦S2	#M149 ^(ab)* → ^ab*
𝓍𝓎♦S2;(𝓍𝓎)♦S2	#M150 ^ab* → ^(ab)*
```
### GroupGlob grouping
```korekto
S1♭(g1)♭S2;S1 g1 S2	#M151 ♭(g)♭ → _g_
S1 g1 S2;S1♭(g1)♭S2	#M152 _g_ → ♭(g)♭
S1♭(g1);S1 g1	#M153 ♭(g)$ → _g$
S1 g1;S1♭(g1)	#M154 _g$ → ♭(g)$
(g1)♭S1;g1 S1	#M155 ^(g)♭ → ^g_
g1 S1;(g1)♭S1	#M156 ^g_ → ^(g)♭
# Nested glob groupings
S1 g1⦆S2;S1 (g1)⦆S2	#M157 _g)→_(g))
S1⦅g1 S2;S1⦅(g1) S2	#M158 (g_→((g)_
```
### Group grouping
```korekto
S1 ⚍ (G1) ⚏ S2;S1 ⚍ G1 ⚏ S2	#M159 +_(G)_± → +_G_±
S1 ⚍ G1 ⚏ S2;S1 ⚍ (G1) ⚏ S2	#M160 +_G_± → +_(G)_±
S1 ⚍ G1 ⚎ G2 ⚏ S2;S1 ⚍ (G1) ⚎ (G2) ⚏ S2	#M161 →+_(G)_+_(F)_±
S1 ⚍ (G1) ⚎ (G2) ⚏ S2;S1 ⚍ G1 ⚎ G2 ⚏ S2	#M162 →+_G_+_F_±
S1 ⚍ (G1);S1 ⚍ G1	#M163 +_(G)$ → +_G$
S1 ⚍ G1;S1 ⚍ (G1)	#M164 +_G$ → +_(G)$
(G1) ⚏ S1;G1 ⚏ S1	#M165 ^(G)_± → ^G_±
G1 ⚏ S1;(G1) ⚏ S1	#M166 ^G_± → ^(G)_±
# Nested groupings
S1 ⚍ G1⦆S2;S1 ⚍ (G1)⦆S2	#M167 +_G)~ → +_(G))~
S1 ⚍ (G1)⦆S2;S1 ⚍ G1⦆S2	#M168 +_(G))~ → +_G)~
S1⦅G1 ⚏ S2;⦅(G1) ⚏ S2	#M169 ~(G_± → ~((G)_±
S1⦅(G1) ⚏ S2;⦅G1 ⚏ S2	#M170 ~((G)_± → ~(G_±
# g+f
S1 ⚍ g1±g2;S1 ⚍ g1 ± g2	#M171 +_g±f$ → +_g_±_f$
g1±g2 ⚏ S2;g1 ± g2 ⚏ S2	#M172 ^g±f_± → ^g_±_f_±
S1 ⚎ g1±g2 ⚏ S2;S1 ⚎ g1 ± g2 ⚏ S2	#M173 +_g±f_± → +_g_±_f_±
```
### Tight grouping
```korekto
S1☜(𝟭♩𝟮)⚑S2;S1𝟭♩𝟮S2	#M174 (a^b) → a^b
S1☜𝟭♩𝟮⚑S2;S1(𝟭♩𝟮)S2	#M175 a^b → (a^b)
S1☜(𝟭♩𝟮)⚑S2(𝟯♪𝟰)⚑S3;S1𝟭♩𝟮S2𝟯♪𝟰S3	#M176 (a^b)~(c^d) → a^b~c^c
S1☜𝟭♩𝟮⚑S2𝟯♪𝟰⚑S3;S1(𝟭♩𝟮)S2(𝟯♪𝟰)S3	#M177 a^b~c^d → (a^b)~(c^c)
```
## Algebra

### Implied/Explicit multiplication
```korekto
S1𝟭♭𝟮S2;S1𝟭♭*♭𝟮S2	#M178 Explicit*
S1𝟭♭*♭𝟮S2;S1𝟭♭𝟮S2	#M179 Implied*
S1☜⚐𝓍*𝑎⚑S2;S1𝑎𝓍S2	#M180 a*N→Na
```
### Equality
```korekto
N1 ⚌ N2;N2 = N1	#M181 Symmetry
N1 = N1	#A182 Reflection
```
### Transitive
```korekto
N1 ⚌ N2;N2 ⚌ N3;N1 = N3	#I183 a=b;b=c;a=c
N1 ⚌ N2;N2 ⚌ N3;N3 = N1	#I184 a=b;b=c;c=a
N1 ⚌ N2;N3 ⚌ N2;N1 = N3	#I185 a=b;c=b;a=c
N1 ⚌ N2;N3 ⚌ N2;N3 = N1	#I186 a=b;c=b;c=a
```
### One
```korekto
# (a/a) 𝓇 𝓈
𝓇(𝟭♭/♭𝟭)𝓈;𝓇1𝓈	#M187 (a/a)→1
𝓇(g1 / g1)𝓈;𝓇1𝓈	#M188 (g / g)→1
# *One*
S1♭*♭1 S2;S1 S2	#M189 *1_
S1 1♭*♭S2;S1 S2	#M190 _1*
S1♭*♭1;S1	#M191 *1$
1♭*♭S2;S2	#M192 ^1*
```
### Zero
```korekto
𝓇(𝟭♭-♭𝟭)𝓈;𝓇0𝓈	#M193 (a-a)→0
S1 𝟭-𝟭 S2;S1 0 S2	#M194 _a-a_→_0_
S1 𝟭-𝟭;S1 0	#M195 _a-a$→_0$
𝟭-𝟭 S2;0 S2	#M196 ^a-a_→^0_
S1♭+♭𝟭♭-♭𝟭♭±♭S2;S1♭±♭S2	#M197 +a-a± → ±
S1♭-♭𝟭♭+♭𝟭♭±♭S2;S1♭±♭S2	#M198 -a+a± → ±
S1♭+♭𝟭♭-♭𝟭;S1	#M199 +a-a$ → $
S1♭-♭𝟭♭+♭𝟭;S1	#M200 -a+a$ → $
𝟭♭-♭𝟭♭+♭S2;S2	#M201 ^a-a+ → ^
S1+𝟭-𝟭 S2;S1 S2	#M202 +a-a_
S1-𝟭+𝟭 S2;S1 S2	#M203 -a+a_
S1 𝟭+𝟭-S2;S1 S2	#M204 _a+a-
S1 𝟭-𝟭+S2;S1 S2	#M205 _a-a+
S1♭⚀♭0♭±♭S2;S1♭±♭S2	#M206 ±0± → ±
```
### (a/b)
```korekto
S1 𝟭♭/♭𝟮;S1 𝟯*𝟭 / 𝟯*𝟮	#M207 _x*a_/_x*b$
S1 𝟭♭/♭𝟮 S2;S1 𝟯*𝟭 / 𝟯*𝟮 S2	#M208 _x*a_/_x*b_
𝟭♭/♭𝟮 S2;𝟯*𝟭 / 𝟯*𝟮 S2	#M209 ^x*a_/_x*b_
S1(𝟭♭/♭𝟮)S2;S1(𝟯*𝟭 / 𝟯*𝟮)S2	#M210 (x*a_/_x*b)
S1(g1 / g2)S2;S1(𝟭*(g1) / 𝟭*(g2))S2	#M211 (x*(g)_/_x*(f))
S1☜⚐𝟭*(1♭/♭𝟮)⚑S2;S1(𝟭♮/♮𝟮)S2	#M212 x*(1/y) → (x/y)
S1☜⚐𝟭*(1 / g1)⚑S2;S1(𝟭 / g1)S2	#M213 x*(1_/_g) → (x_/_g)
S1 1♭±♭(𝟭 / g2)⚑S2;S1 (g2±𝟭 / g2)S2	#M214 _1±(a_/_g) → (g±a / g)
S1 𝓍/𝓎²;S1 𝓍/𝓎 1/𝓎	#M215 _a/b²$→_a/b_1/b$
𝓍/𝓎² S2;𝓍/𝓎 1/𝓎 S2	#M216 ^a/b²_→^a/b_1/b_
S1 𝓍/𝓎² S2;S2 𝓍/𝓎 1/𝓎 S2	#M217 _a/b²_→_a/b_1/b_
```
### ½ tricks
```korekto
𝓍 = ⚬½𝓎;𝓎 = ⚬2𝓍	#M218 a=½b→b=2a
𝓍 = ⚬2𝓎;𝓎 = ⚬½𝓍	#M219 a=2b→b=½a
S1 1 / 𝓍-½;S1 -2 / 1-2𝓍	#M220 _1_/_a-½$→_-2_/_1-2a
S1 ⚬½(⚬2 / g1)S2;S1 (1 / g1)S2	#M221 _½(2 / g)→_(1 / g)
S1(-½♭+♭1♭±♭G1)S2;S1(½♭±♭G1)S2	#M222 (-½+1+g)→(½+g)
S1 1 / 𝓍±½;S1 2 / 2𝓍±1	#M223 _1_/_a+½$→_2_/_2a_1
S1 ⚬½(2 / g1);S1 ⚬1 / g1	#M224 _½(2_/_g)$→_1_/_g
```
### Distribute
```korekto
S1𝟭*(𝟮♭±♭𝟯)⚑S2;S1(𝟭*𝟮♮±♮𝟭*𝟯)S2	#M225 (x*a♭±♭x*b)
S1𝟭*(g2 ± g3)⚑S2;S1(𝟭*(g2)♭±♭𝟭*(g3))S2	#M226 (x*(g)♭±♭x*(f))
S1 𝓍𝓎 ± 𝑎𝓍;S1 𝓍(𝓎 ± 𝑎)	#M227 _ab_+Na$→_a(b+N)$
S1⚍ ⚬𝑎𝓍♭±♭𝓍𝓎;S1⚍ 𝓍(⚬𝑎♮±♮𝓎)	#M228 _Na+ab$→_a(N+b)$
```
### Substitution
```korekto
𝟭 ⚌ 𝟮;S1𝟭S2;S1𝟮S2	#I229 a=b,a→b
𝟭 ⚌ 𝟮;S1𝟭S2𝟭S3;S1𝟮S2𝟮S3	#I230 a=b,2*a→b
𝟭 ⚌ 𝟮;S1𝟭S2𝟭S3𝟭S4;S1𝟮S2𝟮S3𝟮S4	#I231 a=b,3*a→b
𝟭 ⚌ g1;S1 g1⦆S2;S1 𝟭⦆S2	#I232 a=g,_g)→_a)
g1 ⚌ 𝟭;S1 g1⦆S2;S1 𝟭⦆S2	#I233 g=a,_g)→_a)
𝟭 ⚌ g1;S1⦅g1 S2;S1⦅𝟭 S2	#I234 a=g,(g_→(a_
g1 ⚌ 𝟭;S1⦅g1 S2;S1⦅𝟭 S2	#I235 g=a,(g_→(a_
g1 ⚌ g2;S1 g1 S2;S1 g2 S2	#I236 g=f,_g_→_f_
g1 ⚌ g2;S1 g2 S2;S1 g1 S2	#I237 g=f,_f_→_g_
g1 ⚌ g2;S1 g1;S1 g2	#I238 g=f,_g$→_f$
g1 ⚌ g2;S1 g2;S1 g1	#I239 g=f,_f$→_g$
g1 ⚌ g2;g1 S2;g2 S2	#I240 g=f,^g_→^f_
g1 ⚌ g2;g2 S2;g1 S2	#I241 g=f,^f_→^g_
𝟭 ⚌ N1;S1𝟭S2;S1(N1)S2	#I242 a=G,a→(G)
N1 ⚌ 𝟭;S1𝟭S2;S1(N1)S2	#I243 G=a,a→(G)
# The above twice below
N1 ⚌ 𝟭;S1(N1)S2(N1)S3;S1𝟭S2𝟭S3	#I244 G=a,(G)→a~a
𝟭 ⚌ N1;S1(N1)S2;S1𝟭S2	#I245 a=G,(G)→a
N1 ⚌ 𝟭;S1(N1)S2;S1𝟭S2	#I246 G=a,(G)→a
N1 ⚌ N2;S1(N1)S2;S1(N2)S2	#I247 G=F,(G)→(F)
N1 ⚌ N2;S1(N2)S2;S1(N1)S2	#I248 G=F,(F)→(G)
N1 ⚌ N2;N1 ⚏ S1;N2 ⚏ S1	#I249 G=F, ^G_± → ^F_±
N1 ⚌ N2;N2 ⚏ S1;N1 ⚏ S1	#I250 G=F, ^F_± → ^G_±
N1 ⚌ N2;S1 ⚍ N1;S1 ⚍ N2	#I251 G=F, +_G$ → +_F$
N1 ⚌ N2;S1 ⚍ N2;S1 ⚍ N1	#I252 G=F, +_F$ → +_G$
N1 ⚌ N2;S1 ⚍ N1 ⚏ S2;S1 ⚍ N2 ⚏ S2	#I253 G=F, +_G_± → +_F_±
N1 ⚌ N2;S1 ⚍ N2 ⚏ S2;S1 ⚍ N1 ⚏ S2	#I254 G=F, +_F_± → +_G_±
```
### Adding
```korekto
# +-
S1(𝟭 + -𝟮)S2;S1(𝟭♮-♮𝟮)S2	#M255 a+-b=a-b
S1(𝟭♭-♭𝟮)S2;S1(𝟭 + -𝟮)S2	#M256 a-b=a+-b
S1⚐𝟭∧𝟮*𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M257 a^b*a^c=a^(b+c)
S1 g1 + -g2;S1 g1 - g2	#M258 _g_+_-f$→_g_-_f$
# Exponents
S1⚐𝟭∧𝟮𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M259 a^ba^c=a^(b+c)
S1⚐𝟭∧(𝟮♭+♭𝟯)⚑S2;S1𝟭∧𝟮*𝟭∧𝟯S2	#M260 a^(b+c)=a^b*a^c
# Commute
S1(𝟭♭+♭𝟮)S2;S1(𝟮♮+♮𝟭)S2	#M261 (a+b)→(b+a)
S1 g1 + g2;S1 g2 + g1	#M262 _g_+_f$→_f_+_g$
```
### Subtracting
```korekto
S1♭--𝟭♮S2;S1♭𝟭♮S2	#M263 --a→a
𝓍 = -𝓎;-𝓍 = 𝓎	#M264 a=-b;-a=-b
0 = 𝓍♭+♭g1;-𝓍 = g1	#M265 0=b+g→-b=g
S1 -𝓍 / 𝓎-𝓏;S1 𝓍 / 𝓏-𝓎	#M266 _-a_/_b-c$→_a_/_c-b$
```
### Balancing
```korekto
𝓍 = 𝓊 g1;𝓐𝓍 = 𝓐𝓊 g1	#M267 x_=_G_g;Fx_=_FG_g
-𝓍 = 𝓎;𝓍 = -𝓎	#M268 -a=b→a=-b
-𝓍 = 𝓎𝓏;𝓍 = -𝓎𝓏	#M269 -a=bc→a=-bc
1 = 𝓍𝓎;𝓍 = 1/𝓎	#M270 1=ab→a=1/b
-1 = 𝓍(𝓎♭-♭𝓏);𝓍 = 1/(𝓏♮-♮𝓎)	#M271 -1=a(b-c)→a=1/(c-b)
𝓍 = -1*𝓎;-𝓍 = 𝓎	#M272 a=-1*b→-a=b
```
## Functions
```korekto
# Natural log
⌊ 𝓍/𝓎 = ⌊𝓍 - ⌊𝓎	#A273 ⌊(a/b)=⌊a-⌊b
# Squash
⌈𝓍 = 1 / 1+⌉-𝓍	#A274 Squash: ⌈
# Unsquash
⌋𝓍 = ⌊ 𝓍/(1-𝓍)	#A275 Unsquash: ⌋
# Binary balance
# 𝓑 is being used as a pattern key, so I temporarily replace it:
! replace! 𝓑 TMP
# Now I can define 𝓑 in an axiom:
𝓑𝓍 = (1-𝓍)*𝓍	#A276 Binary balance: 𝓑
! replace! TMP 𝓑
```
## Calculus
```korekto
# Derivatives
# Constant Rule
𝓓ᵢ𝖆 = 0	#A277 Constant rule
# Power Rule
𝓓ᵢ(𝓍∧𝖆) = 𝖆*𝓍∧(𝖆-1)*𝓓ᵢ𝓍	#A278 Power rule
# Sum and Difference Rules
𝓓ᵢ(𝓍 + 𝓎) = 𝓓ᵢ𝓍 + 𝓓ᵢ𝓎	#A279 Sum rule
# Product Rule
𝓓ᵢ(𝓍*𝓎) = 𝓓ᵢ𝓍*𝓎 + 𝓍*𝓓ᵢ𝓎	#A280 Product rule
# Quotient Rule
𝓓ᵢ(𝓍 / 𝓎) = (𝓓ᵢ(𝓍)𝓎 - 𝓍𝓓ᵢ(𝓎)) / 𝓎²	#A281 Quotient rule
𝓓ᵢ(1 / 1+𝓍) = -𝓓ᵢ𝓍 / (1+𝓍)²	#A282 From quotient rule
# Chain Rule
# This one is meta.  :-??
# 𝓓ᵢ 𝓐𝓑𝓍 = (𝓓𝓐)𝓑𝓍*(𝓓𝓑)𝓍*𝓓ᵢ𝓍	#A244 Chain rule
# Exponential
𝓓ᵢ(𝖆∧𝓍) = ⌊𝖆𝓓ᵢ(𝓍)𝖆∧𝓍	#A283 D(a^x)=log(a)D(x)a^x
𝓓ᵢ(𝖊∧𝓍) = 𝓓ᵢ(𝓍)𝖊∧𝓍	#A284 D(e^x)=D(x)e^x
# Computations:
𝓓ᵢ(-𝓍) = -𝓓ᵢ(𝓍)	#A285 𝓓ₓ(-𝑦)=-𝓓(𝑦)
ᵢ → 𝑎;𝓓ᵢ𝑎 = 1	#M286 𝓓ₓ𝑥=1
ᵢ → 𝑎;𝓓ᵢ(-𝑎) = -1	#M287 𝓓ₓ-𝑥=-1
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

## Einstein notation

See the [Wikipedia page](https://en.wikipedia.org/wiki/Einstein_notation).

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
ᵢ → ⁱ;∑ᵢ(𝓍ᵢ𝓎ᵢ) = 𝓍ⁱ𝓎ᵢ	#M288 Einstein notation
```
## Hand-waves

### Hiding labels

Once labels(or indices) are shown, allow them to hide until needed.
```korekto
# HIDING
# The folowing hand-wave is for the Vector component label form:
# 1. Labels to hide? Check the antecedent for a term like ...ᵢʲ𝒂ⱼ...
# 2. Vector component labels? Check the heap for ᵢ₊ = ⱼ
# 3. Verify(in heap) that ⱼ → ʲ
# 4. Remove [ᵢʲ] globally
# 5. Replace ⱼ with ₊ globally... result should equal consequent
~ :M/ᵢʲ𝒂ⱼ/t|g/\A$1₊ = $4\Z/|g/\A$4 → $2\Z/|s/[$1$2]//g|s/$4/₊/g
# REVEALING
# The folowing hand-wave is for the Vector component label form:
# 1. Labels to show? Check consequent for term 𝑨ᵢʲ𝒂ⱼ
# 2. Check that ⱼ → ʲ
# 3. Chech ᵢ₊ = ⱼ
# 4. Find label ⱼ → ʲ
# 5+. Append the labels
~ :m/𝑨ᵢʲ𝒂ⱼ/t|g/$5 → $3/|g/$2₊ = $5/|s/([𝒂-𝒛])/\1$2/g|s/$1$4$2₊/$1$2$3$4$5/
```
### Set equations
```korekto
~ :M/𝕒/t|g/$1\[𝓍\]/t|s/$1/$2/g
```
