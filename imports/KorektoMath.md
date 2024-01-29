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
| Token | Decimal,Word,Symbol | 𝟣 𝟤 𝟥 𝟦 𝟧 𝟨 𝟩 𝟪 𝟫 | Sans-Serif |
| [Type](#Type) |
| Constant | [𝕬-𝖟] | 𝖆 𝖇 𝖈 | Bold-Fraktur |
| Scalar | [𝑎-𝑧]| 𝑎 𝑏 𝑐 | Italic Small |
| Vector | [𝒂-𝒛] | 𝒂 𝒃 𝒄 | Bold Italic Small |
| Tensor | [𝑨-𝒁] | 𝑨 𝑩 𝑪 | Bold Italic Capitol |
| Set | [𝕒-𝕫] | 𝕒 𝕓 𝕔 | Double-Struck small |
| Type | [𝔸-𝕐ℂℍℕℙℚℝℤ] | 𝔸 𝔹 ℂ | Double-Struck Capitol |
| [Operator](#Operator) |
| Unary | [-𝓐-𝓩] | 𝓐 𝓑 𝓒 | Bold Script Capitol |
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
| SuperToken | Unaries(Token,Group)!? | 𝟭 𝟮 𝟯 𝟰 𝟱 𝟲 𝟳 𝟴 𝟵 𝓍 𝓎 𝓏 | Sans-Serif Bold |

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
! Token {𝟣 𝟤 𝟥 𝟦 𝟧 𝟨 𝟩 𝟪 𝟫}
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
! Unary /[-𝓐-𝓩]/
! Unary {𝓐 𝓑 𝓒}
! Unaries /[-𝓐-𝓩]*/
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
! SuperToken /[-𝓐-𝓩]*(?:(?:\d[\d\.]*)|\w+|\((?:[^()]|\([^()]*\)|\([^()]*\([^()]*\)*\))*\)|\S)[ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ]*[ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻ]*!?/
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
(𝟭♭♚♭𝟮)♮♚♮S2;𝟭♮♚♮𝟮♮♚♮S2	#M79 ^(a*b)*->a*b*
```
### GroupGlob grouping
```korekto
S1♭(g1)♭S2;S1 g1 S2	#M80 Space
S1 g1 S2;S1♭(g1)♭S2	#M81 Group
S1♭(g1);S1 g1	#M82 Space$
S1 g1;S1♭(g1)	#M83 Group$
(g1)♭S1;g1 S1	#M84 ^Space
g1 S1;(g1)♭S1	#M85 ^Group
```
### Group grouping
```korekto
S1 ⚍ (G1) ⚎ S2;S1 ⚍ G1 ⚎ S2	#M86 +Space+
S1 ⚍ G1 ⚎ S2;S1 ⚍ (G1) ⚎ S2	#M87 +Group+
S1 ⚍ G1 ⚎ G2 ⚏ S2;S1 ⚍ (G1) ⚎ (G2) ⚏ S2	#M88 +Group+Group+
S1 ⚍ (G1);S1 ⚍ G1	#M89 +Space
S1 ⚍ G1;S1 ⚍ (G1)	#M90 +Group
(G1) ⚍ S1;G1 ⚍ S1	#M91 Space+
G1 ⚍ S1;(G1) ⚍ S1	#M92 Group+
S1 ⚍ G1⦆;S1 ⚍ (G1)⦆	#M93 +Group)
S1 ⚍ g1±g2;S1 ⚍ g1 ± g2	#M94 Space ~a+b
```
### Tight grouping
```korekto
S1(𝟭♩𝟮)S2;S1𝟭♩𝟮S2	#M95 Tight un-grouped
S1𝟭♩𝟮S2;S1(𝟭♩𝟮)S2	#M96 Tight grouped
```
## Algebra

### Implied/Explicit multiplication
```korekto
S1𝟭♭𝟮S2;S1𝟭♮*♮𝟮S2	#M97 Explicit*
S1𝟭♮*♮𝟮S2;S1𝟭♭𝟮S2	#M98 Implied*
```

### Equality
```korekto
N1 = N2;N2 = N1	#M99 Symmetry
N1 = N1	#A100 Reflection
```
### Transitive
```korekto
N1 = N2;N2 = N3;N1 = N3	#I101 Transitive a=b;b=c;a=c
N1 = N2;N3 = N2;N3 = N1	#I102 Linked a=b;c=b;c=a
```
### One
```korekto
# (a/a)
S1(𝟭♭/♭𝟭)S2;S1(1)S2	#M103 (a/a)=>(1)
S1(g1 / g1)S2;S1(1)S2	#M104 (a / a)=>(1)
# One
S1♭*♭1 S2;S1 S2	#M105 *one~
S1♭*♭(1) S2;S1 S2	#M106 *(one)~
S1 1♭*♭S2;S1 S2	#M107 ~one*
S1 (1)♭*♭S2;S1 S2	#M108 ~(one)*
S1*1⚑S2;S1⚑S2	#M109 *one
S1⚑1*S2;S1⚑S2	#M110 one*
S1*(1)⚑S2;S1⚑S2	#M111 *(one)
S1⚑(1)*S2;S1⚑S2	#M112 (one)*
```
### Zero
```korekto
S1(𝟭♭-♭𝟭)S2;S1(0)S2	#M113 (a-a)=>(0)
S1♭⚀♭𝟭♭-♭𝟭♭±♭S2;S1♭±♭S2	#M114 ±a-a±=>±
S1⚀𝟭-𝟭 S2;S1 S2	#M115 +a-a~
S1♭⚀♭0♭±♭S2;S1♭±♭S2	#M116 ±0±=>±
```
### (a/b)
```korekto
S1 𝟭♭/♭𝟮;S1 𝟯*𝟭 / 𝟯*𝟮	#M117 x*a / x*b$
S1(𝟭♭/♭𝟮)S2;S1(𝟯*𝟭 / 𝟯*𝟮)S2	#M118 (xa / xb)
S1(g1 / g2)S2;S1(𝟭*(g1) / 𝟭*(g2))S2	#M119 (x(a) / x(b))
S1𝟭*(1♭/♭𝟮)⚑S2;S1(𝟭♮/♮𝟮)S2	#M120 (x*1)/(y)
S1𝟭*(1 / g1)⚑S2;S1(𝟭 / g1)S2	#M121 x*1 /  y
S1 1♭±♭(𝟭 / g2)⚑S2;S1 (g2±𝟭 / g2)S2	#M122 ~1+(a/b)->~(b+a / b)
```
### Distribute
```korekto
S1𝟭*(𝟮♭±♭𝟯)⚑S2;S1(𝟭*𝟮♮±♮𝟭*𝟯)S2	#M123 (xa±xb)
S1𝟭*(g2 ± g3)⚑S2;S1(𝟭*(g2) ± 𝟭*(g3))S2	#M124 (x(a) ± x(b))
```
### Substitution
```korekto
𝟭 = 𝟮;S1𝟭S2;S1𝟮S2	#I125 a=b;a->b
𝟭 = N2;S1𝟭S2;S1(N2)S2	#I126 a=b;a->(b)
N1 = 𝟭;S1♭(N1)♮S2;S1♭𝟭♮S2	#I127 (a)=b;(a)->b
N1 = 𝟭;S1♭(N1)♭S2♭(N1)♭S3;S1♭𝟭♭S2♭𝟭♭S3	#I128 (a)=b;(a)->b,b
N1 = 𝟭;S1𝟭S2;S1(N1)S2	#I129 (a)=b;b->(a)
N1 = N2;S1(N1)S2;S1(N2)S2	#I130 a=b;(a)->(b)
N1 = N2;S1(N2)S2;S1(N1)S2	#I131 a=b;(b)->(a)
N1 = N2;N1 ⚍ S1;N2 ⚍ S1	#I132 a=b;a->b+
N1 = N2;N2 ⚍ S1;N1 ⚍ S1	#I133 a=b;b->a+
N1 = N2;S1 ⚍ N1;S1 ⚍ N2	#I134 a=b;a->+b
N1 = N2;S1 ⚍ N2;S1 ⚍ N1	#I135 a=b;b->+a
```
### Adding
```korekto
S1(𝟭 + -𝟮)S2;S1(𝟭♮-♮𝟮)S2	#M136 a+-b=a-b
S1(𝟭♭-♭𝟮)S2;S1(𝟭 + -𝟮)S2	#M137 a-b=a+-b
S1⚑𝟭∧𝟮*𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M138 a^b*a^c=a^(b+c)
S1⚑𝟭∧𝟮𝟭∧𝟯⚑S2;S1𝟭∧(𝟮♭+♭𝟯)S2	#M139 a^ba^c=a^(b+c)
S1⚑𝟭∧(𝟮♭+♭𝟯)⚑S2;S1𝟭∧𝟮*𝓊𝟭∧𝟯S2	#M140 a^(b+c)=a^b*a^c
S1(𝟭♭+♭𝟮)S2;S1(𝟮♮+♮𝟭)S2	#M141 (a+b)->(b+a)
```
### Subtracting
```korekto
S1♭--𝟭♮S2;S1♭𝟭♮S2	#M142 --a->a
```
## Inequalities
```korekto
# Inequalities
𝓍+1 > 𝓍	#A143 Greater than: >
𝓍 > 𝓎;𝓎 < 𝓍	#M144 Less than: <
𝓍 > 𝓎;𝓍 ≠ 𝓎	#M145 Not equal: ≠
# Absolute value
𝓍 < 0;|𝓍| = -𝓍	#M146 Absolute-: |
𝓍 > 0;|𝓍| = 𝓍	#M147 Absolute+
𝓍 = 0;|𝓍| = 0	#M148 Absolute zero
|𝓍| = |-𝓍|	#A149 Absolute value
# Greater/Less than or equal
|𝓍| ≥ 0	#A150 Greater than or equal: ≥
0 ≤ |𝓍|	#A151 Less than or equal: ≤
```
## Calculus
```korekto
# Infinitessimal
𝓍 ≠ 0;|𝜀| < |𝓍|	#M152 Infinitessimal: 𝜀
𝜀 ≠ 0	#P153 First order 𝜀
𝜀² = 0	#P154 Vanishing 𝜀
# Differential
𝒶⁺ = ᵢ;𝛅ᵢ𝓐(𝒶) = 𝓐(𝒶+𝜀ᵢ)-𝓐(𝒶)	#M155 Differential: 𝛅
# Derivatives
𝒶⁺ = ᵢ;𝓓ᵢ𝓐(𝒶) = 𝛅ᵢ𝓐(𝒶)/𝜀ᵢ	#M156 Derivative: 𝓓
𝒶⁺ = ᵢ;𝓓ᵢ𝓐(𝒶) = 𝓐(𝒶+𝜀ᵢ)-𝓐(𝒶) / 𝜀ᵢ	#M157 Derivative
# Constant Rule
𝓓ᵢ𝒹 = 0	#A158 Constant rule
# Power Rule
𝓓ᵢ(𝓍∧𝒹) = 𝒹*𝓍∧(𝒹-1)	#A159 Power rule
# Sum and Difference Rules
𝓓ᵢ(𝓍 + 𝓎) = 𝓓ᵢ𝓍 + 𝓓ᵢ𝓎	#A160 Sum rule
# Product Rule
𝓓ᵢ(𝓍*𝓎) = 𝓓ᵢ𝓍*𝓎 + 𝓍*𝓓ᵢ𝓎	#A161 Product rule
# Quotient Rule
𝓓ᵢ(𝓍 / 𝓎) = (𝓓ᵢ(𝓍)𝓎 - 𝓍𝓓ᵢ(𝓎)) / 𝓎²	#A162 Quotient rule
𝓓ᵢ(1 / 1+𝓍) = -𝓓ᵢ𝓍 / (1+𝓍)²	#A163 From quotient rule
# Chain Rule
# This one is meta.  :-??
𝓓ᵢ𝓐𝓑𝓍 = (𝓓𝓐)𝓑𝓍*(𝓓𝓑)𝓍*𝓓ᵢ𝓍	#A164 Chain rule
# Exponential
# TODO: Need to introduce natural log
𝓓ᵢ(𝒶∧𝓍) = log(𝒶)𝓓ᵢ(𝓍)𝒶∧𝓍	#A165 Wut: log
```
