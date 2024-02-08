# Korekto

* [VERSION 2.1.240208](https://github.com/carlosjhr64/korekto/releases)
* [github](https://www.github.com/carlosjhr64/korekto)
* [rubygems](https://rubygems.org/gems/korekto)

## Description

A general proof checker.

Works with [neovim](https://github.com/neovim/neovim).

## Install
```shell
$ gem install korekto
$ korekto --install
$ ### And if missing:
$ gem install neovim # Provides neovim-ruby-host
```
## Synopsis
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
* [2^3=8](examples/TwoCube.md)
* [More...](examples/index.md)

## Help
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
 --heap=SIZE 	Set heap size (default: 60)
Types:
  SIZE    /^\d+$/
Exclusive:
  scrape trace install readme
# Example usage:
#   cat MARKDOWN.md | korekto
#   korekto < MARKDOWN.md
```
## Credits

One can(of course) check the project's [dependencies](korekto.gemspec).
Topmost kudos goes to [Neovim](https://neovim.io/)
which makes this project possible in [Ruby](https://www.ruby-lang.org/en/).
I also want to credit sources for ideas I'm using here.

[An Introduction to Formal Logic](https://www.amazon.com/An-Introduction-to-Formal-Logic/dp/B01M6Z6T1E/)
with Steve Gimbel, Ph.D. of Gettysburg College
on Amazon's The Great Courses Signature Collection.

[Insights into Mathematics](https://www.youtube.com/@njwildberger)
with Norman Wildberger, professor of mathematics at UNSW Sydney.
Specially his foundations videos.

For anything really novel here,
I would say that I have not seen an explicit formula
for the propagation of errors of a sigmoid neural network
which I give in my [Neuronet wiki](https://github.com/carlosjhr64/neuronet/wiki).
Also, my [classification of statements](examples/Tutorial.md) without any mention of formal logic
might be somewhat novel, although foreshadows it.

## License

Copyright (c) 2024 CarlosJHR64

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
