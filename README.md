# korekto

* [VERSION 0.0.210221](https://github.com/carlosjhr64/korekto/releases)
* [github](https://www.github.com/carlosjhr64/korekto)
* TODO: rubygems

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
# Type patterns and variables
! V /\w/
! V {u v w}
! :nl /\n/
! :nl {;}
# Acceptance pattern
u;:if u, :then v;v	#I26 Modus Ponem
# Statements
S{s,t}	#D28 Statements
s	#P29
:if s, :then t	#P30
t	#C31/I26,P29,P30 Modus Ponem
```
See also [BOOTSTRAP.md](BOOTSTRAP.md).

This is a total rewrite of my initial attempt at a proof checker, [ulpc](https://www.github.com/carlosjhr64/ulpc).
Still working on it, but it's much improved and simplified.

## [MORE](examples/index.md)

## LICENSE:

Copyright 2021 CarlosJHR64

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
