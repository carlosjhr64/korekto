# korekto

* [VERSION 0.0.210207](https://github.com/carlosjhr64/korekto/releases)
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
# Statements
This is }bad{.	#! syntax: balanced? '(){}[]'
This is {good}.	# pass
This is {good}.	# restatement
Too long a line.  Want to keep statements at under 66 characters long.	#! syntax: length < 66
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
