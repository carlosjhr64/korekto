# Korekto

* [VERSION 2.0.231229](https://github.com/carlosjhr64/korekto/releases)
* [github](https://www.github.com/carlosjhr64/korekto)
* [rubygems](https://rubygems.org/gems/korekto)

## DESCRIPTION:

A general proof checker.

Works with [neovim](https://github.com/neovim/neovim).

## INSTALL:
```shell
$ gem install korekto
$ korekto --install
$ ### And if missing:
$ gem install neovim # Provides neovim-ruby-host
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
There might be Cows.	#S3/L1 Let 1: Cows
There might be Chickens.	#S4/L1 Let 1: Chickens
If I see Cows, then I'll probably see Chickens.	#P5
I see Cows.	#P6
I'll probably see Chickens.	#C7/I2,P5,P6 Modus ponens
```
## Examples

* [Tutorial](examples/Tutorial.md)
* [ABC music notation](examples/ABC.md)
* [Computation](examples/Computation.md)
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
 --scrape    	Scrape Korekto lines
 --trace     	Show trace of each line, not just edits and errors
 --patch     	Allow monkey patching in stdin
 --install   	Installs the korekto neovim ruby plugin
 --readme    	Open korekto github page
 --heap=SIZE 	Set heap size (default: 13)
Types:
  SIZE    /^\d+$/
Exclusive:
  scrape trace install readme
# Example usage:
#   cat MARKDOWN.md | korekto
#   korekto < MARKDOWN.md
```
## LICENSE:

Copyright (c) 2023 CarlosJHR64

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
