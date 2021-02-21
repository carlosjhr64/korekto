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
a=b;b=a	#M1
a=b;a;b	#I2 Equally true
a=b;b;a	#I3 Equally true
a=b;c(a)d;c(b)d	#I4 Substitution
a=b;c(b)d;c(a)d	#I5 Substitution
a=b;c[a]d;c[b]d	#I6 Substitution
a=b;c[b]d;c[a]d	#I7 Substitution
a=b;c{a}d;c{b}d	#I8 Substitution
a=b;c{b}d;c{a}d	#I9 Substitution
A=a;cAb;c(a)b	#I10 Substitution
# And
(a)&(b);b	#M11 Independantly true
(a)&(b);a	#M12 Independantly true
((a)&(b))&((c)&(d));a	#M13 Independantly true
((a)&(b))&((c)&(d));b	#M14 Independantly true
((a)&(b))&((c)&(d));c	#M15 Independantly true
((a)&(b))&((c)&(d));d	#M16 Independantly true
# Exist
:Exist[A]{B|aBb};(A[C])&(aCb)	#E17 E1
:Exist[A]{B,C|aBbCcBdCe};((A[D])&(A[E]))&(aDbEcDdEe)	#E18 E2
# Proofing
:ASSUMPTION=a;a	#M19 By assumption
c;:Not[c];:CONTRADICTION	#I20 Implied contradiction
:CONTRADICTION;:ASSUMPTION=a;:Not[a]	#I21 Negate the assumption
# Marks
aAb;a(A)b	#M22 Mark
# Unmarks
a(A)b;aAb	#M23 Unmark
a(A^I)b(B)c;aA^IbBc	#M24 Unmark
```
