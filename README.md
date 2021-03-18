# Korekto

* [VERSION 1.4.210318](https://github.com/carlosjhr64/korekto/releases)
* [github](https://www.github.com/carlosjhr64/korekto)
* [rubygems](https://rubygems.org/gems/korekto)

## DESCRIPTION:

A general proof checker.

Works with neovim(nvim).

## INSTALL:
```shell
$ gem install korekto
$ korekto --install
```
## SYNOPSIS:
```korekto
### Patterns ###
# 'Hello World!'.scan(/\w+|\S|\s/) #=> ["Hello", " ", "World", "!"]
! scanner: '\w+|\S|\s'
! .Newline /\n/
! .Newline {;}
! Variables /\w+/
! Variables {V W}
### Acceptance patterns ###
There might be V.	#L1 Let 1: There   might be .
# /If I see (\w+), then I'll probably see (\w+).\nI see \1\nI'll probably see \2/
If I see V, then I'll probably see W.;I see V.;I'll probably see W.	#I2 Modus ponens: If I see , then ' ll probably
### Argument ###
There might be Cows.	#S3/L1 Let 1
There might be Chickens.	#S4/L1 Let 1
If I see Cows, then I'll probably see Chickens.	#P5
I see Cows.	#P6
I'll probably see Chickens.	#C7/I2,P5,P6 Modus ponens
```
## MORE

* Tutorial
  * [Intro](examples/Tutorial.md)
  * [Statement types](examples/Tutorial.md#Statement-types)
    * [D is for Definition](examples/Tutorial.md#D-is-for-Definition)
    * [P is for Postulate](examples/Tutorial.md#P-is-for-Postulate)
    * [A is for Axiom](examples/Tutorial.md#A-is-for-Axiom)
    * [T is for Tautology](examples/Tutorial.md#T-is-for-Tautology)
    * [I is for Inference](examples/Tutorial.md#I-is-for-Inference)
    * [C is for Conclusion](examples/Tutorial.md#C-is-for-Conclusion)
    * [M is for Map](examples/Tutorial.md#M-is-for-Map)
    * [R is for Result](examples/Tutorial.md#R-is-for-Result)
    * [E is for Existential](examples/Tutorial.md#E-is-for-Existential)
    * [X is for Instantiation](examples/Tutorial.md#X-is-for-Instantiation)
    * [L is for Let](examples/Tutorial.md#L-is-for-Let)
    * [S is for Set ie Assignment](examples/Tutorial.md#S-is-for-Set-ie-Assignment)
    * [W is for Which](examples/Tutorial.md#W-is-for-Which)
  * [Statements table](examples/Tutorial.md#Statements-table)
  * [Patterns](examples/Tutorial.md#Patterns)
  * [Syntax](examples/Tutorial.md#Syntax)
  * [Monkey patches](examples/Tutorial.md#Monkey-patches)
  * [Scanner](examples/Tutorial.md#Scanner)
  * [Fence](examples/Tutorial.md#Fence)
  * [Section](examples/Tutorial.md#Section)
  * [Save and Restore](examples/Tutorial.md#Save-and-Restore)

* Examples
  * [ABC music notation](examples/ABC.md)
  * [Dx x^x](examples/Dxx.md)
  * [Sqrt(2) is irrational! (Classic Proof)](examples/Sqrt2.md)
  * [Squash Function](examples/Squash.md)

## Help:
```shell
$ korekto --help
Usage:
  korekto [:options+]
Options:
 -h --help
 -v --version
 --install   	Installs the korekto neovim ruby plugin
 --readme    	Open korekto github page
# Example usage:
#   cat MARKDOWN.md | korekto
#   korekto < MARKDOWN.md
```
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
