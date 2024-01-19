# Korekto Math

* Imports [KorektoKernel](KorektoKernel.md)
* Imported by [Neuronet](../examples/Neuronet.md)

## Contents

* [Intro](#Intro)
* [Ruby patches](#Ruby-patches)
* [Syntax](#Syntax)
* [Patterns](#Patterns)
* [Definitions](#Defintions)
* [Grouping](#Grouping)
* [Algebra](#Algebra)
* [Abstracts](#Abstracts)

## Intro

### Pattern keys

Several styles are used for keys:

* Numbered Latin ASCII keys: `W1 W2 W3`
  * lower case will not match spaces
  * upper case may match spaces
  * used for `+` or `*` patterns
* Representative `ABC`
* Mathematical numbers
  * used for general concrete objects, tokens
* Mathematical script small Latin: `𝒶 𝒷 𝒸`
  * used for symbols
  * used to provide an alternate key
* Miscellaneous symbols
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
| Token | Decimal,Word,Symbol | 𝟣 𝟤 𝟥 𝟦 𝟧 𝟨 𝟩 𝟪 𝟫 𝓍 𝓎 𝓏 | Sans-Serif |
| [Type](#Type) |
| Constant | [𝕬-𝖟] | 𝖆 𝖇 𝖈 | Bold-Fraktur |
| Scalar | [𝑎-𝑧]| 𝑎 𝑏 𝑐 | Italic Small |
| Vector | [𝒂-𝒛] | 𝒂 𝒃 𝒄 | Bold Italic Small |
| Tensor | [𝑨-𝒁] | 𝑨 𝑩 𝑪 | Bold Italic Capitol |
| Set | [𝕒-𝕫] | 𝕒 𝕓 𝕔 | Double-Struck small |
| Type | [𝔸-𝕐ℂℍℕℙℚℝℤ] | 𝔸 𝔹 ℂ | Double-Struck Capitol |
| [Operator](#Operator) |
| Unary | [𝓐-𝓩] | 𝓐 𝓑 𝓒 | Bold Script Capitol |
| Unaries | Unary* | 𝓉 𝓊 𝓋 | Script Small |
| Tight | [∨∧𝓵] | ♩ ♪ | Miscellaneous Symbols |
| .NotTight | (?![∨∧𝓵]) | ⚑ | Miscellaneous Symbols |
| Associative Binaries: |
| Binary | [-+/*] | ♣ ♥ ♦ | Miscellaneous Symbols |
| MultDiv | [/*] | ♝ ♛ ♚ | Miscellaneous Symbols |
| AddSub | [-+] | ⚀ ⚁ ⚂ ± | Miscellaneous Symbols |
| Loose | [-+=\<\>] | ⚌ ⚍ ⚎ ⚏ | Miscellaneous Symbols |
| [Label](#Label) |
| Superscript | [ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻ] | ⁱ ʲ ᵏ | Latin superscript |
| Subscript | [ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ] | ᵢ ⱼ ₖ | Latin subscript |
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
| SuperToken | Unaries(Token,Group)!? | 𝟭 𝟮 𝟯 𝟰 𝟱 𝟲 𝟳 𝟴 𝟵 | Sans-Serif Bold |

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
# Can't have two spaces or have tabs
? !(include?('  ') || include?("\t"))
# Exponentiation, root, and log are tight
? tight?('∧')
? tight?('∨')
? tight?('𝓵')
# Factorial is left tight
? ltight?('!')
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
! Token {𝟣 𝟤 𝟥 𝟦 𝟧 𝟨 𝟩 𝟪 𝟫 𝓍 𝓎 𝓏}
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
! Unary /[𝓐-𝓩]/
! Unary {𝓐 𝓑 𝓒}
! Unaries /[𝓐-𝓩]*/
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
! Loose /[-+=\<\>]/
! Loose {⚌ ⚍ ⚎ ⚏}
```
### Label
```korekto
! Superscript /[ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻ]/
! Superscript {ⁱ ʲ ᵏ}
! Subscript /[ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ]/
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
! SuperToken /[𝓐-𝓩]*(?:(?:\d[\d\.]*)|\w+|\((?:[^()]|\([^()]*\)|\([^()]*\([^()]*\)*\))*\)|\S)!?/
! SuperToken {𝟭 𝟮 𝟯 𝟰 𝟱 𝟲 𝟳 𝟴 𝟵}
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
w1{E1𝟣 𝟤E2};𝟣₊ : 𝟤	#M7 Next: ₊
w1{E1𝟣 𝟤E2};𝟤₋ : 𝟣	#M8 Previous: ₋
```
### Methods on words
```korekto
w1{𝟣E1};w1.first : 𝟣	#M9 First: . first
w1{E1𝟣};w1.last : 𝟣	#M10 Last: last
```
### Raise
```korekto
w1{𝟣E1};w2{𝟤E2};𝟣⁺ : 𝟤	#I11 Raise first: ⁺
w1{𝓂 𝟣E1};w2{𝓂 𝟤E2};𝟣⁺ : 𝟤	#I12 Raise second
w1{𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝟤E2};𝟣⁺ : 𝟤	#I13 Raise third
w1{𝓂 𝓂 𝓂 𝟣E1};w2{𝓂 𝓂 𝓂 𝟤E2};𝟣⁺ : 𝟤	#I14 Raise fourth
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
𝟣 + 𝟤 = 𝟥;𝟥 - 𝟤 = 𝟣	#M20 Addition=>Subraction: + -
𝟥 - 𝟤 = 𝟣;𝟣 + 𝟤 = 𝟥	#M21 Subtraction=>Addition
𝟣 - 𝟣 = 0	#A22 Zero: 0
𝟣 + 𝟤 = 𝟤 + 𝟣	#A23 Commute+
```
### Multiplication and Division
```korekto
𝟤 * 𝟥 = 𝟨;𝟨 / 𝟥 = 𝟤	#M24 Multiplication=>Division: * /
𝟨 / 𝟥 = 𝟤;𝟤 * 𝟥 = 𝟨	#M25 Division=>Multiplication
𝟤 / 𝟤 = 1	#A26 One: 1
# Note: multiplication does not commute in general(e.g. matrices)
```
### Exponentiation and Root
```korekto
𝟤∧𝟥 = 𝟪;𝟪∨𝟥 = 𝟤	#M27 Exponentiation=>Root: ∧ ∨
𝟪∨𝟥 = 𝟤;𝟤∧𝟥 = 𝟪	#M28 Root=>Exponentiation
# Does not commute
# No analogous 𝟛∨𝟛 = N
𝟤∧1 = 𝟤	#A29 x∧1=x
𝟤∧0 = 1	#A30 X∧0=1
```
### Square and Square Root
```korekto
𝟤² = 𝟤 * 𝟤	#A31 Square: ²
𝟤² = 𝟦;√𝟦 = 𝟤	#M32 Square=>SquareRoot: √
√𝟦 = 𝟤;𝟤² = 𝟦	#M33 SquareRoot=>Square
```
### Exponentiation and Logarithm
```korekto
𝟤∧𝟥 = 𝟪;𝟤𝓵𝟪 = 𝟥	#M34 Exponentiation=>Logarithm: 𝓵
𝟤𝓵𝟪 = 𝟥;𝟤∧𝟥 = 𝟪	#M35 Logarithm=>Exponentiation
𝟤𝓵1 = 0	#A36 xl1=0
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
𝟣 = 𝟣;𝟣 * 1 = 𝟣	#M47 Single
𝟣 + 𝟣 = 𝟤;𝟣 * 2 = 𝟤	#M48 Double
𝟣 + 𝟣 + 𝟣 = 𝟥;𝟣 * 3 = 𝟥	#M49 Triple
```
### Show exponentiation as repeated multiplication
```korekto
𝟤 = 𝟤;𝟤∧1 = 𝟤	#M50 Linear
𝟤 * 𝟤 = 𝟦;𝟤∧2 = 𝟦	#M51 Square
𝟤 * 𝟤 * 𝟤 = 𝟪;𝟤∧3 = 𝟪	#M52 Cube
```
## Grouping

### Token grouping
```korekto
S1𝟭S2;S1(𝟭)S2	#M53 a->(a)
S1(𝟭)S2;S1𝟭S2	#M54 (a)->a
S1𝟭S2𝟮S3;S1(𝟭)S2(𝟮)S3	#M55 a_b->(a)_(b)
S1(𝟭)S2(𝟮)S3;S1𝟭S2𝟮S3	#M56 (a)_(b)->a_b
S1𝟭S2𝟮S3𝟯S4;S1(𝟭)S2(𝟮)S3(𝟯)S4	#M57 a_b_c->(a)_(b)_(c)
S1(𝟭)S2(𝟮)S3(𝟯)S4;S1𝟭S2𝟮S3𝟯S4	#M58 (a)_(b)_(c)->a_b_c
```
### Binary spacing
```korekto
S1(𝟭 ♦ 𝟮)S2;S1(𝟭♦𝟮)S2	#M59 *(a + b)*->*(a+b)*
S1(𝟭♦𝟮)S2;S1(𝟭 ♦ 𝟮)S2	#M60 *(a+b)*->*(a + b)*
S1♮(𝟭♭♦♭𝟮);S1 𝟭♦𝟮	#M61 *(a + b)$-> * a+b$
S1 𝟭♦𝟮;S1♮(𝟭♭♦♭𝟮)	#M62 * a+b$->*(a + b)$
(𝟭♭♦♭𝟮)♮S1;𝟭♦𝟮 S1	#M63 ^(a + b)*->^a+b *
𝟭♦𝟮 S1;(𝟭♭♦♭𝟮)♭S1	#M64 ^a+b *->^(a + b)*
S1 𝟭♦𝟮 S2;S1♮(𝟭♭♦♭𝟮)♭S2	#M65 * a+b *->*(a + b)*
S1♭(𝟭♭♦♭𝟮)♮S2;S1 𝟭♦𝟮 S2	#M66 *(a + b)*->* a+b *
```
### MultDiv spacing
```korekto
# MultDiv has higher precedence than AddSub
S1 𝟭♚𝟮;S1 𝟭 ♚ 𝟮	#M67 ~a*b$->~a * b
S1 𝟭 ♚ 𝟮;S1 𝟭♚𝟮	#M68 ~a * b$->~a*b
𝟭♚𝟮 S2;𝟭 ♚ 𝟮 S2	#M69 ^a*b~$->a * b~
𝟭 ♚ 𝟮 S2;𝟭♚𝟮 S2	#M70 ^a * b~->a*b~
S1 𝟭 ♚ 𝟮 S2;S1 𝟭♚𝟮 S2	#M71 ~a * b~->~a*b~
S1 𝟭♚𝟮 S2;S1 𝟭 ♚ 𝟮 S2	#M72 ~a*b~->~a * b~
```
### MutlDiv Grouping
```korekto
# MultDiv has higher precedence than AddSub
S1♥𝟭♚𝟮♦S2;S1♥(𝟭♭♚♭𝟮)♦S2	#M73 +a*b+->+(a*b)+
S1♥(𝟭♭♚♭𝟮)♦S2;S1♥𝟭♚𝟮♦S2	#M74 +(a*b)+->+a*b+
S1♥𝟭♚𝟮;S1♥(𝟭♭♚♭𝟮)	#M75 +a*b$->+(a*b)
S1♥(𝟭♭♚♭𝟮);S1♥𝟭♚𝟮	#M76 +(a*b)$->+a*b
𝟭♚𝟮♦S2;(𝟭♭♚♭𝟮)♦S2	#M77 ^a*b+->(a*b)+
(𝟭♭♚♭𝟮)♦S2;𝟭♚𝟮♦S2	#M78 ^(a*b)+->a*b+
```
### GroupGlob grouping
```korekto
S1♭(g1)♭S2;S1 g1 S2	#M79 Space
S1 g1 S2;S1♭(g1)♭S2	#M80 Group
S1♭(g1);S1 g1	#M81 Space$
S1 g1;S1♭(g1)	#M82 Group$
(g1)♭S1;g1 S1	#M83 ^Space
g1 S1;(g1)♭S1	#M84 ^Group
```
### Group grouping
```korekto
S1 ⚍ (G1) ⚎ S2;S1 ⚍ G1 ⚎ S2	#M85 +Space+
S1 ⚍ G1 ⚎ S2;S1 ⚍ (G1) ⚎ S2	#M86 +Group+
S1 ⚍ (G1);S1 ⚍ G1	#M87 +Space
S1 ⚍ G1;S1 ⚍ (G1)	#M88 +Group
(G1) ⚍ S1;G1 ⚍ S1	#M89 Space+
G1 ⚍ S1;(G1) ⚍ S1	#M90 Group+
```
### Tight grouping
```korekto
S1(𝟭♩𝟮)S2;S1𝟭♩𝟮S2	#M91 Tight un-grouped
S1𝟭♩𝟮S2;S1(𝟭♩𝟮)S2	#M92 Tight grouped
```
## Algebra

### Implied/Explicit multiplication
```korekto
S1𝟭♭𝟮S2;S1𝟭♮*♮𝟮S2	#M93 Explicit*
S1𝟭♮*♮𝟮S2;S1𝟭♭𝟮S2	#M94 Implied*
```

### Equality
```korekto
N1 = N2;N2 = N1	#M95 Symmetry
N1 = N1	#A96 Reflection
```
### Transitive
```korekto
N1 = N2;N2 = N3;N1 = N3	#I97 Transitive a=b;b=c;a=c
N1 = N2;N3 = N2;N3 = N1	#I98 Linked a=b;c=b;c=a
```
### One
```korekto
# (a/a)
S1(𝟭♭/♭𝟭)S2;S1(1)S2	#M99 (a/a)=>(1)
S1(g1 / g1)S2;S1(1)S2	#M100 (a / a)=>(1)
# One
S1♭*♭1 S2;S1 S2	#M101 *one~
S1♭*♭(1) S2;S1 S2	#M102 *(one)~
S1 1♭*♭S2;S1 S2	#M103 ~one*
S1 (1)♭*♭S2;S1 S2	#M104 ~(one)*
S1*1⚑S2;S1⚑S2	#M105 *one
S1⚑1*S2;S1⚑S2	#M106 one*
S1*(1)⚑S2;S1⚑S2	#M107 *(one)
S1⚑(1)*S2;S1⚑S2	#M108 (one)*
```
### Zero
```korekto
S1(𝟭♭-♭𝟭)S2;S1(0)S2	#M109 (a-a)=>(0)
S1♭⚀♭𝟭♭-♭𝟭♭±♭S2;S1♭±♭S2	#M110 ±a-a±=>±
S1♭⚀♭0♭±♭S2;S1♭±♭S2	#M111 ±0±=>±
```
### (a/b)
```korekto
S1 𝟭♭/♭𝟮;S1 𝟯*𝟭 / 𝟯*𝟮	#M112 x*a / x*b$
S1(𝟭♭/♭𝟮)S2;S1(𝟯*𝟭 / 𝟯*𝟮)S2	#M113 (xa / xb)
S1(g1 / g2)S2;S1(𝟭*(g1) / 𝟭*(g2))S2	#M114 (x(a) / x(b))
S1𝟭*(1♭/♭𝟮)⚑S2;S1(𝟭♮/♮𝟮)S2	#M115 (x*1)/(y)
S1𝟭*(1 / g1)⚑S2;S1(𝟭 / g1)S2	#M116 x*1 /  y
S1 1♭±♭(𝟭 / g2)⚑S2;S1 (g2±𝟭 / g2)S2	#M117 ~1+(a/b)->~(b+a / b)
```
### Distribute
```korekto
S1𝟭*(𝟮♭±♭𝟯)⚑S2;S1(𝟭*𝟮♮±♮𝟭*𝟯)S2	#M118 (xa±xb)
S1𝟭*(g2 ± g3)⚑S2;S1(𝟭*(g2) ± 𝟭*(g3))S2	#M119 (x(a) ± x(b))
```
### Substitution
```korekto
𝟭 = 𝟮;S1𝟭S2;S1𝟮S2	#I120 a=b;a->b
𝟭 = N2;S1𝟭S2;S1(N2)S2	#I121 a=b;a->(b)
N1 = 𝟭;S1♭(N1)♮S2;S1♭𝟭♮S2	#I122 (a)=b;(a)->b
N1 = 𝟭;S1𝟭S2;S1(N1)S2	#I123 (a)=b;b->(a)
N1 = N2;S1(N1)S2;S1(N2)S2	#I124 a=b;(a)->(b)
N1 = N2;S1(N2)S2;S1(N1)S2	#I125 a=b;(b)->(a)
```
### Adding
```korekto
S1(𝟭 + -𝟮)S2;S1(𝟭♮-♮𝟮)S2	#M126 a+-b=a-b
S1(𝟭♭-♭𝟮)S2;S1(𝟭 + -𝟮)S2	#M127 a-b=a+-b
S1⚑𝟭∧𝟮*𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M128 a^b*a^c=a^(b+c)
S1⚑𝟭∧𝟮𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M129 a^ba^c=a^(b+c)
S1⚑𝟭∧(𝟮♭+♭𝟯)⚑S2;S1𝟭∧𝟮*𝓊𝟭∧𝟯S2	#M130 a^(b+c)=a^b*a^c
S1(𝟭♭+♭𝟮)S2;S1(𝟮♮+♮𝟭)S2	#M131 (a+b)->(b+a)
```
### Subtracting
```korekto
S1♭--𝟭♮S2;S1♭𝟭♮S2	#M132 --a->a
```
## Abstracts
```korekto
# By our definition of the digits:
#   2 + 1 = 3
# Then by our defintion of subtraction:
#   3 - 1 = 2
# We can group each token:
#  (2) + (1) = (3)
#  (3) - (1) = (2)
# Thus, we can abstract to SuperTokens our previous definitions.
# I'll just write the simplest true example, and then give the abstraction.
2 + 1 = 3	#R133/M2,S40 If equivalent, then equal
3 - 1 = 2	#R134/M20,R133 Addition=>Subraction
𝟭 + 𝟮 = 𝟯;𝟯 - 𝟮 = 𝟭	#M135/R133,R134 Addition=>Subtraction
```
