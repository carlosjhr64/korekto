# Squash function

The purpose of this example it to illustrate a technique
to avoid having to constantly write both side of an equivalence as follows:
```ruby
Consider: 1+1+1+1
= 1+1+1+1
= 2+1+1
= 3+1
= 4
1+1+1+1 = 4
```
Here I demonstrate that `Squash` and `Unsquash` are inverse of each other by choosing:
```ruby
Squash[x] = 1/(1 + Exp[-x])
Unsquash[x] = Log[x/(1 - x)]
```
I import the monkey patch [Kernel](../imports/Kernel.md)
which defines the `balanced?` method for balanced groupings.
I set some rules on the use of spaces I want my statements to follow.
I set the scanner to parse the statements basically by word, or otherwise single character.
I set my patterns.
And I switch the fence to `ruby`.
```korekto
< imports/Kernel.md
### Syntax ###
? length < 66
? balanced? '()[]{}'
# No tabs or double space
? not match?(/\t|  /)
# Space out equals
? not (match?(/=\S/) or match?(/[^;\s]=/))
# Space out plus
? not match?(/\S\+/) and not match?(/\+\S/)
# Space out minus(unless a unitary operator)
? not match?(/\w\-/)
### Patterns ###
! scanner: ':?\w+:?|.'
! .Newline /\n/
! .Newline {;}
! Variable /\w/
! Variable {u v w x y z}
! Glob /.*/
! Glob {a b c d e f}
! fence: 'ruby'
```
Switching the fence allows me to switch the syntax highlighting to `ruby`
as I intend to write the statements in a ruby-ish way.
I write my acceptance patterns:
```ruby
### Logic ###
# Equality
u = a	#L1 Assignment:   =
# Substitutions
/^(.+) = (.+)\n(.*)[\(\{\[]?\1[\)\}\]]?(.*)\n\3[\(\{\[]?\2[\)\}\]]?\4$/	#I2 Substitution
/^(.+) = (.+)\n(.*)[\(\{\[]?\2[\)\}\]]?(.*)\n\3[\(\{\[]?\1[\)\}\]]?\4$/	#I3 Substitution
# Logical programming
QED: a	#A4 What's to be proven: QED:
QED: a;a;:QED	#I5 Done!: :QED
Consider: a	#A6 Consider this: Consider:
Consider: a;= a	#M7 Considering this
Consider: a;= b;a = b	#I8 Join
### Math ###
Real[x]	#L9 Real: Real [ ]
Log[Exp[a]] = a	#A10 Log and Exp are inverses: Log Exp
Exp[u] = 1/Exp[-u]	#A11 e^x = 1/e^-x: 1 / -
Squash[u] = 1/(1 + Exp[-u])	#A12 Squash: Squash ( + )
Unsquash[a] = Log[(a)/(1 - (a))]	#A13 Unsquash: Unsquash
(a)/(b) = (a)(1/(b))	#A14 a/b = a(1/b)
(u/v)(1/(1 - (a))) = u/(v - v(a))	#A15 Algebra
u(1/u) = 1	#A16 u(1/u)=1
x + a - x = a	#A17 x-x=0
```
In the set up section, I introduce the problem to be solve.
From this point on, all statements are validated by the acceptance patterns.
```ruby
### Setup ###
Real[x]	#S18/L9 Real
QED: Unsquash[Squash[x]] = x	#T19/A4 What's to be proven
```
In the scratch work area, I set equivalences valid for substitutions in the derivation.
```ruby
### Scratch work ###
Squash[x] = 1/(1 + Exp[-x])	#T20/A12 Squash
u = 1 + Exp[-x]	#S21/L1 Assignment
Squash[x] = 1/u	#C22/I3,S21,T20 Substitution
Unsquash[1/u] = Log[(1/u)/(1 - (1/u))]	#T23/A13 Unsquash
(1/u)/(1 - (1/u)) = (1/u)(1/(1 - (1/u)))	#T24/A14 a/b = a(1/b)
(1/u)(1/(1 - (1/u))) = 1/(u - u(1/u))	#T25/A15 Algebra
u(1/u) = 1	#T26/A16 u(1/u)=1
1 + Exp[-x] - 1 = Exp[-x]	#T27/A17 x-x=0
Exp[x] = 1/Exp[-x]	#T28/A11 e^x = 1/e^-x
Log[Exp[x]] = x	#T29/A10 Log and Exp are inverses
```
And finally, the derivation.
I'd put most of the above statements in an import and mostly just feature the statements below:
```ruby
### Derivation ###
Consider: Unsquash[Squash[x]]	#T30/A6 Consider this
= Unsquash[Squash[x]]	#R31/M7,T30 Considering this
= Unsquash[1/u]	#C32/I2,C22,R31 Substitution
= Log[(1/u)/(1 - (1/u))]	#C33/I2,T23,C32 Substitution
= Log[(1/u)(1/(1 - (1/u)))]	#C34/I2,T24,C33 Substitution
= Log[1/(u - u(1/u))]	#C35/I2,T25,C34 Substitution
= Log[1/(u - 1)]	#C36/I2,T26,C35 Substitution
  u = 1 + Exp[-x]	#S21/L1 Remember!
= Log[1/(1 + Exp[-x] - 1)]	#C38/I2,S21,C36 Substitution
= Log[1/Exp[-x]]	#C39/I2,T27,C38 Substitution
= Log[Exp[x]]	#C40/I3,T28,C39 Substitution
= x	#C41/I2,T29,C40 Substitution
Unsquash[Squash[x]] = x	#C42/I8,T30,C41 Join
   QED: Unsquash[Squash[x]] = x	#T19/A4 Remember!
:QED	#C44/I5,T19,C42 Done!
```
