# korekto

* [VERSION 0.0.210210](https://github.com/carlosjhr64/korekto/releases)
* [github](https://www.github.com/carlosjhr64/korekto)
* [rubygems](https://rubygems.org/gems/korekto)

## DESCRIPTION:

A general proof checker.

## INSTALL:
```shell
$ gem install korekto
$ korekto --install
```
## SYNOPSIS:
```korekto
# Imports
< BOOTSTRAP.md
# Syntax
! balanced? '(){}[]'
! length < 66
# Statements
{[(This is all ok and good.)]}	#D1
This is {good}.	#P2 Pass
[This](is)also{ok}.	#P3 Pass also
This is {good}.	#P2 Restatement
[This](is)also{ok}.	#P3 Pass also
# Axioms(Acceptance Patterns)
/^(\w+) = \1$/	#A4 Reflexive axiom
T = T	#D5
{A,B,C}	#D6 A B C Exist
ABC = ABC	#T7/A4 Reflexive axiom
{X,Y}	#D8
X	#P9
T->T	#D10
X->Y	#P11
/(\w+)\n\1->(\w+)\n\2/	#I12 Modus ponem
Y	#C13/I12,P9,P11 Modus ponem
```
See also [BOOTSTRAP.md](BOOTSTRAP.md).

## LICENSE:

Copyright 2021 carlosjhr64

Permission is hereby granted, free of charge,
to any person obtaining a copy of this software and
associated documentation files (the "Software"),
to deal in the Software without restriction,
including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and
to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice
shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS",
WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
