# Bootstrap
```korekto
# Ruby Monkey Patches
::Array#blp(k,m) = (m==0)?self<<k:(k==last)?self[0..-2]:self<<k
::Array#bli      = inject([]){|a,km| a.blp(*km)}
::Array#blm(g)   = map{|c| g.index(c).divmod(2)}
::Array#bls(g)   = select{|c| g.include?(c)}
::String#balance(g)   = chars.bls(g).blm(g).bli
::String#balanced?(g) = balance(g).empty?
# Syntax
? balanced? '(){}[]'
? length < 66
# Patterns
! :nl /\n/
! :nl {;}
! :Glob /.*/
! :Glob {a b c d e}
! :Logogram /\p{L}|\d+|:\w+/
! :Logogram {A B C D E}
! :Digits /\d+/
! :Digits {I J K}
# Logic
# Equality
a=b;b=a	#M24
a=b;a;b	#I25 Equally true
a=b;b;a	#I26 Equally true
a=b;c(a)d;c(b)d	#I27 Substitution
a=b;c(b)d;c(a)d	#I28 Substitution
a=b;c[a]d;c[b]d	#I29 Substitution
a=b;c[b]d;c[a]d	#I30 Substitution
a=b;c{a}d;c{b}d	#I31 Substitution
a=b;c{b}d;c{a}d	#I32 Substitution
A=a;cAb;c(a)b	#I33 Substitution
# And
(a)&(b);b	#M35 Independantly true
(a)&(b);a	#M36 Independantly true
((a)&(b))&((c)&(d));a	#M37 Independantly true
((a)&(b))&((c)&(d));b	#M38 Independantly true
((a)&(b))&((c)&(d));c	#M39 Independantly true
((a)&(b))&((c)&(d));d	#M40 Independantly true
# Exist
:Exist[A]{B|aBb};(A[C])&(aCb)	#E42 E1
:Exist[A]{B,C|aBbCcBdCe};((A[D])&(A[E]))&(aDbEcDdEe)	#E43 E2
# Proofing
:ASSUMPTION=a;a	#M45 By assumption
c;:Not[c];:CONTRADICTION	#I46 Implied contradiction
:CONTRADICTION;:ASSUMPTION=a;:Not[a]	#I47 Negate the assumption
# Marks
aAb;a(A)b	#M49 Mark
# Unmarks
a(A)b;aAb	#M51 Unmark
a(A^I)b(B)c;aA^IbBc	#M52 Unmark
```
