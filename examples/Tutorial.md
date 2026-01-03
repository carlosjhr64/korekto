# Tutorial

## Contents

* [Intro](#Intro)
* [Installation details](#Installation-details)
* [Heap](#Heap)
* [Statement types](#Statement-types)
  * [D is for Definition](#D-is-for-Definition)
  * [P is for Postulate](#P-is-for-Postulate)
  * [A is for Axiom](#A-is-for-Axiom)
  * [T is for Tautology](#T-is-for-Tautology)
  * [I is for Inference](#I-is-for-Inference)
  * [C is for Conclusion](#C-is-for-Conclusion)
  * [M is for Map](#M-is-for-Map)
  * [R is for Result](#R-is-for-Result)
  * [E is for Existential](#E-is-for-Existential)
  * [X is for Instantiation](#X-is-for-Instantiation)
  * [L is for Let](#L-is-for-Let)
  * [S is for Set ie Assignment](#S-is-for-Set-ie-Assignment)
  * [W is for Which](#W-is-for-Which)
* [Statements table](#Statements-table)
* [Patterns](#Patterns)
* [Support for pattern statements](#Support-for-pattern-statements)
* [Syntax](#Syntax)
* [Refinements](#Refinements)
* [Imports](#Imports)
* [Scanner](#Scanner)
* [Fence](#Fence)
* [Section](#Section)
* [Save and Restore](#Save-and-Restore)

## Intro

`Korekto` is not a proof assistant.
Think of `Korekto` the same way as unit testing in `Ruby`.
You write out your proof and for each statement there is a test.

I meant `Korekto` to read markdown files with `Korekto` code fenced.

    # Markdown file with fenced Korekto
    ```korekto
    # This is a Korekto comment
    ```

`Korekto` can be run on this tutorial:
```shell
$ korekto --trace < examples/Tutorial.md
-:109:D1:5 Symbols including space
-:110:D2:10 Numbers
-:111:D3:10 Words
-:123:A4:Reflection
-:132:T5/A4:Reflection
-:146:I6:Modus ponen
-:148:I7:Synthesis
-:157:P8:How can you have any pudding?
-:158:P9:You did have your meat!
-:166:C10/I6,P8,P9:Modus ponen
-:167:C11/I7,P9,C10:Synthesis
-:176:M12:If A and B, then A good with B
-:184:R13/M12,C11:If A and B, then A good with B
-:193:E14:Also good with 1
-:206:X15/E14,R13:Also good with 1
-:217:L16:Let 1
-:225:S17/L16:Let 1
-:309:A18:Reflection
-:316:M19:If A and B, then A good with B.
-:323:D20:
-:324:A21/D20:
```
Also, in `neovim` you can run the command `:Korekto` or press `<F9>`.
It will check your work and move the cursor to the first error it finds.
It will also automate many of the statement's comments.
You only need to give the statement type,
`Korekto` completes the comment.

Keep in mind that as powerful as `Regexp` can be,
you'll run into weaknesses in the `Regexp` engine.
There will be times when the simple pattern generator(provided by `Korekto`)
can't create the test you want, and you'll consider using a literal `Regexp`.
And some tests may not be possible...
The current consensus is that `Regexp` is not Turing Complete.
So you may consider using the `instance_eval` and refinements options.
You'll be going down the rabbit hole of
trying to create a proof assistant for your project...
Burrowing yourself down all the way to first principles.
CONSIDER YOURSELF WARNED!

## Installation details

To make the install as easy as possible,
I automated the install best I could on a typical Linux system.
But you should know what's going on behind the scenes.
Everything in Korekto is accessible for you to tweak and configure, but
hopefully I'm giving you something useful right from the start.

If you're my target audience, you like:

* The Ruby programming language
* The Neovim Vim-based text editor
* Mathematics
* Linux

I have to assume that's you.
Now, if you're not using [rbenv](https://github.com/rbenv/rbenv), you should.
This version of Korekto was tested under Ruby version 4.0.
Rbenv makes it very easy to create work spaces that
will use the correct Ruby version.

This version of Korekto was tested using
[Neovim](https://github.com/neovim/neovim) version 0.12.
In Linux, you should be able to setup your workspace to ensure
that's the version used.

Korekto may work just fine with prior versions, but
I can't say how far back... It's untested.

So this is what happens as you install step by step

1. `gem install korekto`

This will normally install the Korekto gem(given rbenv) somewhere in:

    ~/.rbenv/versions/4.*/ruby/gems/4.*/gems/korekto-*/
    ~/.rbenv/shims/korekto

The `shims/korekto` is the executable stub.
You should now have the `korekto` command available.

2. `korekto --install`

This will install the following files on your system:

    ~/.config/nvim/korekto.lua
    ~/.config/nvim/rplugin/ruby/korekto.rb
    ~/.config/nvim/syntax/korekto.vim

It then runs `nvim -c ':UpdateRemotePlugins|:quit'`.

`korekto.lua` is just an alternate configuration for Neovim.
If you run `korekto README.md`, what you're in effect running is:

    nvim -u ~/.config/nvim/korekto.lua README.md

This was my way to ensure you have a configuration to work with right away.
You can review `korekto.lua` to see how to add it you your `init.lua`
if you wish to have Korekto available when you run `nvim`, but
it gets complicated to have a `nvim` configuration do all the things.
As is, `korekto.lua` is pretty good for working with Markdown files.

`syntax/korekto.vim` adds syntax highlighting to your "korekto" code blocks
in Markdown.

`rplugin/ruby/korekto.rb` adds the `:Korekto` command to Neovim.
It gets mapped to `<F9>` in `korekto.lua`.
This will run `korekto` on the file of your current buffer
to check your Korekto statements, and will automatically make edits to update
your statement validation comments.

I'll assume you're reading this tutorial via `korekto --readme` or something
like `korekto /path-to/examples/Tutorial.md`.

## Heap

`Korekto` keeps a heap of recent (non-pattern)statements to search for matches.
This heap is limited to a size of 60 by default and
does not include imported statements.
One may re-introduce an old/imported statement into the heap
by restating(recalling) it.

## Statement types

Although I tried to match the normal semantics of
the words used to describe the statement types
(Definition, Postulate, Axiom, Tautology, ...),
be aware that the statement types
have a very specific meaning in the `Korekto` code.

I'll be using literal `Regexp` in the patterns in the following examples,
but one would normally use the pattern translation feature `Korekto` provides.
Note that the default scanner pattern is `/:\w+|./`
which is used to tokenize the statements.

### D is for Definition

`D` statements are used to introduce new symbols.
It must introduce at least one new symbol.
```korekto
{= &}	#D1 5 Symbols including space
{0 1 2 3 4 5 6 7 8 9}	#D2 10 Numbers
{:pudding :meat :also :good :if :then :with :let :there :be}	#D3 10 Words
```
You can specify the number of symbols to be defined in the comment title,
but it's not required.
If you provide it, `Korekto` will ensure the number is correct.

### A is for Axiom

`A` statements are acceptance patterns on single statements.
They recognize tautologies.
```korekto
# A=A
/^(\w)=\1$/	#A4 Reflection
```
`A` statements may introduce new symbols.

### T is for Tautology

`T` statements are those that match any preceding `A` statements.
They must not have any undefined symbols.
```korekto
4=4	#T5/A4 Reflection
```
### I is for Inference

`I` statements are acceptance patterns on three statements:
two accepted statement and a third to be validated.
Because this entails a search that grows(O[n²])
with the size of the list of statements,
`Korekto` requires that the correct combination
be found in its recent statements heap.
```korekto
# :if A :then B;A;B
/^:if (:\w+) :then (:\w+)\n\1\n\2$/	#I6 Modus ponen
# A;B;A&B
/^(:\w+)\n(:\w+)\n\1&\2$/	#I7 Synthesis
```
`I` statements may introduce new symbols.

### P is for Postulate

`P` statements are used to introduce new facts
(not derivable from previous statements).
It cannot have any undefined symbols.
```korekto
:if :meat :then :pudding	#P8 How can you have any pudding?
:meat	#P9 You did have your meat!
```
### C is for Conclusion

`C` statements are those that matched any preceding `I` statements
in combination with two previous statements in the heap.
They must not have any undefined symbols.
```korekto
:pudding	#C10/I6,P8,P9 Modus ponen
:meat&:pudding	#C11/I7,P9,C10 Synthesis
```
### M is for Mapping

`M` statements are acceptance patterns on two statements,
one previously accepted statement and the one being validated.
The accepted statement must be in the heap.
```korekto
# A&B;A :good :with B
/^(:\w+)&(:\w+)\n\1 :good :with \2$/	#M12 If A and B, then A good with B
```
### R is for Result

`R` statements are those that matched any preceding `M` statements
in combination with one previous statement in the heap.
It must not have any undefined symbols.
```korekto
:meat :good :with :pudding	#R13/M12,C11 If A and B, then A good with B
```
### E is for Existential

`E` statements are mappings like `M`, but instead of yielding `R`(result) statements,
they yield `X`(instantiation) statements.
They are used to instantiate new symbols in some context.
```korekto
# A :good :with B;C :also :good :with B
/^:\w+ :good :with (:\w+)\n:\w+ :also :good :with \1$/	#E14 Also good with 1
```
`E` statements may introduce new symbols themselves.
If the title(in the comment section) includes a number,
it should be the expected number of instantiations.

### X is for Instantiation

`X` statements are results like `R`, but
are a consequence of an `E` existential statement, and
must introduce at least one new symbol.
```korekto
# cherry was added in context of "also good with pudding"
:cherry :also :good :with :pudding	#X15/E14,R13 Also good with 1: :cherry
```
If the matching `E` statement for the `X` statement has a number in the title,
it'll interpret it has the number of instantiations expected.

### L is for Let

`L` statements are just like `A` in that they're patterns on single statements.
But `L` statement yield statements that can instantiate new symbols.
The number of symbols that can be introduced is set in the comment title.
```korekto
/^:let :there :be (:\w+)$/	#L16 Let 1
```
### S is for Set ie Assignment

`S` statements are just like `T` statements
except that they're validated by `L` statements and
can bring in new symbols.
```korekto
:let :there :be :light	#S17/L16 Let 1: :light
```
### W is for Which

Sometimes a statement might be validated by
either an `M` mapping or an `I` inference,
but you forget which... So is it `R` or `C`?
Setting the statement type to `W` tells `Korekto` to test which one works.
`W` will try in order [`T`,`S`,`R`,`X`,`C`], and
will go with the first match or raise an error.

## Statements table

I created these two tables of statement types which differ only in its sorting.
I was hoping to show that all statement types are covered.
:-??
Under "Undefined", "Yes" means it may have undefined symbols
whereas "Yes!" means it must have at least one undefined symbol.

| Type | Description   | Undefined | Pattern | Yields | Newlines | Heap | Validator |
|:----:|:--------------|:----------|:--------|:------:|:--------:|:----:|:---------:|
|  I   | Inference     | Yes       | Yes     | C      | 2        | -    | -         |
|  E   | Existential   | Yes       | Yes     | X      | 1        | -    | -         |
|  M   | Mapping       | Yes       | Yes     | R      | 1        | -    | -         |
|  A   | Axiom         | Yes       | Yes     | T      | 0        | -    | -         |
|  L   | Let           | Yes       | Yes     | S      | 0        | -    | -         |
|  D   | Definition    | Yes!      | No      | -      | -        | -    | -         |
|  S   | Set           | Yes!      | No      | -      | -        | -    | L         |
|  X   | Instantiation | Yes!      | No      | -      | -        | 1    | E         |
|  R   | Result        | No        | No      | -      | -        | 1    | M         |
|  C   | Conclusion    | No        | No      | -      | -        | 2    | I         |
|  T   | Tautology     | No        | No      | -      | -        | -    | A         |
|  P   | Postulate     | No        | No      | -      | -        | -    | -         |

| Type | Description   | Undefined | Pattern | Yields | Newlines | Heap | Validator |
|:----:|:--------------|:----------|:--------|:------:|:--------:|:----:|:---------:|
|  D   | Definition    | Yes!      | No      | -      | -        | -    | -         |
|  P   | Postulate     | No        | No      | -      | -        | -    | -         |
|  L   | Let           | Yes       | Yes     | S      | 0        | -    | -         |
|  S   | Set           | Yes!      | No      | -      | -        | -    | L         |
|  A   | Axiom         | Yes       | Yes     | T      | 0        | -    | -         |
|  T   | Tautology     | No        | No      | -      | -        | -    | A         |
|  M   | Mapping       | Yes       | Yes     | R      | 1        | -    | -         |
|  R   | Result        | No        | No      | -      | -        | 1    | M         |
|  I   | Inference     | Yes       | Yes     | C      | 2        | -    | -         |
|  C   | Conclusion    | No        | No      | -      | -        | 2    | I         |
|  E   | Existential   | Yes       | Yes     | X      | 1        | -    | -         |
|  X   | Instantiation | Yes!      | No      | -      | -        | 1    | E         |

Currently `Korekto` expects all patterns to capture,
although no checking is done if a literal `Regexp` is given.
Also, `Korekto` will not define any symbols in a literal `Regexp`,
so it's preferable to use `Patterns` described below.

Some generalities:
* All pattern statements may introduce new symbols
* All pattern statements will itemize in the title the new symbols found
* First number found in the title of an instantiating pattern(E,L) is the expected number of instantiations
* First number found in the title of a definition statement(D) is the expected number of undefined symbols

## Patterns

Rather than using literal `Regexp`,
one can write easily readable patterns to be translated into `Regexp`.
You'll want to first define your newline pattern `/\n/`.
I like to use `;` for the newline pattern.
```korekto
! .nl /\n/
! .nl {;}
```
The bang `!` at the start of a line tells `Korekto` it's a pattern definition.
The period at the start of the pattern name
means this pattern is not to capture.
Pattern definitions have the following form:
```ruby
%r{^! (?<type>\S+)\s+/(?<pattern>.*)/$}
/^! (?<type>\S+)\s+\{(?<variables>\S+( \S+})*)\}$/
```
So if you want to capture a number into pattern variables(i,j,k),
you could write:
```korekto
! Number /\d+/
! Number {i j k}
```
A Reflection axiom like `#A3` above can then be rewritten for numbers as:
```korekto
i=i	#A18 Reflection
```
Although you'll probably want to make a Reflection axiom
a bit more general than for just numbers.
Demonstrating the use of `!:nl {;}`, map `#M12` above could be rewritten as follows:
```korekto
! KeyWord /:\w+/
! KeyWord {A B}
A&B;A :good :with B	#M19 If A and B, then A good with B.
```
## Support for pattern statements

If a pattern statement matchesl
the immediately preceding statements(in the heap),
the matched statements will be used as support for the pattern statement.
```korekto
:x + :x = 2 * :x	#D20
A + A = 2 * A	#A21/D20
```
## Syntax

You can have `Korekto` reject a statement right away
should it fail some test in the statement's String value.
The test is `instance_eval` on the String itself.
For example, to reject statements longer than 65 characters,
you can write:
```korekto
? length < 66
```
Lines starting with question mark `?`
tells `Korekto` to `instance_eval` the given `ruby` code on the string.
If the eval returns `true` it proceeds, else it's an error.

## Refinements

Korekto comes with some useful String refinements to be used in syntax rules.

* `balanced?(brackets = '()[]{}')`: checks for balanced brackets
* `ltight?(*chars)`: no char given has a space on the left
* `rtight?(*chars)`: no char given has a space on the right
* `tight?(*chars)`: no char given has a space on either side

The above methods are defined in `Korekto::Refinements`.
See the next section, Imports, for how to add your own refinements.

## Imports

A Korekto file can import other Korekto files as follows:

    < path-to/Import.md

You'll likely want to define your patterns in the import file.
Note that imports don't add to the heap...
You'll need to restate on the current file any required support statement.

If the imported file is a Ruby file(with an ".rb" extension),
it will be `require`'d into the running Korekto process.
This is a way for you to define your own String refinements.
Just package it into `Korekto::Refinements`.

## Scanner

The default scanner pattern is ':\w+|.'.
This is good for mostly logographic statements
such as found in mathematical formulas:
```ruby
':sin[x]^2+:cos[x]^2=1'.scan(/:\w+|./).uniq #=> [":sin", "[", "x", "]", "^", "2", "+", ":cos", "=", "1"]
```
You can change the scanner to something else, as shown in the [README](../README.md).
```korekto
! scanner: '\w+|\S|\s'
```
This is good for natural language:
```ruby
'Hello World!'.scan(/\w+|\S|\s/).uniq #=> ["Hello", " ", "World", "!"]
```
## Fence

The default fence in a `Markdown` file is `korekto`.
There may be situations where you'll want `Korekto`
to read code fenced as another language,
as in the [ABC music notation](ABC.md) example.
You can change the fence to something else, like `abc` for example:
```korekto
! fence: 'abc'
```
## Section

The default section is the basename of the file without the extension.
You can set the section name as follows:
```korekto
! section: 'Numbers'
```
## Save and Restore

There are times when you'll want to go on a side track in your proof, but
then go back to some prior point discarding the side track...
Maybe to demonstrate a dead end.
You can use `! save: '<key>'` and `! restore '<key>'` to do that:
```korekto
! save: 'backup'
# Go on to say whatever nonsense...
# ...then go back the to saved point as if nothing said.
! restore: 'backup'
```
After the `restore`, then statement numbers will continue to increment normally,
but the statements made after the `save` are gone.

# Final thoughts

I hope this gives you enough to get started.
Check out the provided examples where
I fall into the rabbit that I warn about at the Intro.
Feel free to contact me for further help.
As you'll see in all my projects, there are no issues.
That's because I write perfect code that never breaks,
with such clear documentation no one ever has any problems.
