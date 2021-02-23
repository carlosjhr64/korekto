# Tutorial

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
$ korekto < examples/Tutorial.md
```
Also, in `neovim` you can run the command `Korekto`.
It will check you work and move the cursor to the first error it finds.
It will also automate many of the statement comments.
You only need to give the statement type,
`Korekto` completes the comment.

## Statement types

Although I tried to match the normal semantics of
the words used to describe the statement types
(Definition, Postulate, Axiom, Tautology, ...),
be aware that the statement types
have a very specific meaning in the `Korekto` code.
Also I'm using literal `Regexp`
in the patterns in the following examples,
but one should best use
the pattern translation feature `Korekto` provides.

### `D` is for Definition

`D` statements are used to introduce new symbols.
It must introduce at least one new symbol.
```korekto
N={1,2,3,4,5,6,7,8,9,...}	#D1 Natural numbers
S={:pudding,:meat,:good,...}	#D2 Statements
```
### `A` is for Axiom

`A` statements are acceptance patterns on single statements.
They recognize tautologies.
```korekto
/^(\w)=\1$/	#A3 Reflection
```
### `T` is for Tautology

`T` statements are those that match any preceding `A` statements.
They must not have any undefined symbols.
```korekto
4=4	#T4/A3 Reflection
```
### `I` is for Inference

`I` statements are acceptance patterns on three statements:
two accepted statement and a third to be validated.
Because this entails a search that grows very quickly with
the size of the list of statements,
`Korekto` requires that the correct combination be found in the last 13 statements.
Restatement of previous results are allowed so as to add old statements into the search heap.
```korekto
/^:if (:\w+) :then (:\w+)\n\1\n\2$/	#I5 Modus Ponem
/^(:\w+)\n(:\w+)\n\1&\2$/	#I6 Synthesis
```
### `P` is for Postulate

`P` statements are used to introduce new facts(underivable from previous statements).
It cannot have any undefined symbols.
```korekto
:if :meat :then :pudding	#P7 How can you have any pudding
:meat	#P8 You did have your meat
```
### `C` is for Conclusion

`C` statements are those that matched any preceding `I` statements
in combination with two previous statements in the heap(typically the last 13 statements).
They must not have any undefined symbols.
```korekto
:pudding	#C9/I5,P7,P8 Modus Ponem
:meat&:pudding	#C10/I6,P8,C9 Synthesis
```
### `M` is for Mapping

`M` statements are acceptance patterns on two statements,
one previously accepted statement and the one being validated.
The accepted statement must be in the heap(typically the last 13 statements).
```korekto
/^(:\w+)&(:\w+)\n\1 :good :with \2$/	#M11 A and B then A good with B
```
### `R` is for Result

`R` statements are those that matched any preceding `M` statements
in combination with one previous statement in the heap(typically the last 13 statements).
It must not have any undefined symbols.
```korekto
:meat :good :with :pudding	#R12/M11,C10 A and B then A good with B
```
### `E` is for Existential

`E` statements are mappings like `M`, but instead of yielding `R`(result) statements,
they yield `X`(instantiation) statements.
They are used to instantiate new symbols in some context.
```korekto
/^:\w+ :good :with (:\w+)\n:\w+ :also :good :with \1$/	#E13 Also good with 1
```
If the title(in the comment section) includes a number,
it should be the expected number of instantiations(up to 9).

### `X` if for Instantiation

`X` statements are results like `R`, but
are a consequence of an `E` existential statement, and
must introduce at least one new symbol.
```korekto
# cherry was added in context of "also good with pudding"
:cherry :also :good :with :pudding	#X14/E13,R12 Also good with 1
```
## Statements table

I created these two tables of statement types which differ only in its sorting.
I was hoping to show that all statement types are covered.
Under "Undefined", "Yes" means it may have undefined symbols
whereas "Yes!" mean it must have at least one undefined symbol.

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
Also, `korekto` blindly defines all symbols in a literal `Regexp`,
so it's preferable not to use the literal `Regexp`.

## Patterns

Rather than using literal `Regexp`,
one can write easily readable patterns to be translated into `Regexp`.
You'll want to first define your newline pattern `/\n/`.
I like to use `;` for the newline pattern.
This should be named `:nl`, as `Korekto` will know not to do a capture on this one.
```korekto
! :nl /\n/
! :nl {;}
```
The bang `!` at the start of a line tells `Korekto` it's a pattern definition.
Pattern definitions have the following form:
```ruby
%r{^! (?<type>\p{L}|:\w+)\s*/(?<pattern>.*)/$}
/^! (?<type>\p{L}|:\w+)\s*\{(?<variables>\p{Graph}( \p{Graph})*)\}$/
```
So if you want to capture a number into pattern variables(i,j,k), you could write:
```korekto
! :Number /\d+/
! :Number {i j k}
```
A Reflection axiom like `#A3` above can then be rewritten for numbers as:
```korekto
i=i	#A15 Reflection
```
Although you'll probably want to make a Reflection axiom a bit more general than for just numbers.
Demonstrating the use of `!:nl {;}`, map `#M11` above could be rewritten as follows:
```korekto
! :KeyWord /:\w+/
! :KeyWord {A B}
A&B;A :good :with B	#M16 If A and B, then A good with B.
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
tells `Korekto` to `intance_eval` the `ruby` code on the string.
If the eval returns `true` it proceeds, else it's an error.

## Monkey patches

Because Syntax rules can go beyond what a simple `Regexp` can do,
you can monkey patch in `ruby` code your rule.
For example, balanced parenthesis is not at all trivial.
Here's my monkey patch and test for balanced parenthesis:
```korekto
# Ruby Monkey Patches
::Array#blp(k,m) = (m==0)?self<<k:(k==last)?self[0..-2]:self<<k
::Array#bli = inject([]){|a,km| a.blp(*km)}
::Array#blm(g) = map{|c| g.index(c).divmod(2)}
::Array#bls(g) = select{|c| g.include?(c)}
::String#balance(g) = chars.bls(g).blm(g).bli
::String#balanced?(g) = balance(g).empty?
# Syntax
? balanced? '(){}[]'
```
The `balanced?` method translates to `ruby` as:
```ruby
# Monkey patching String
class String
  # It's a ruby 3 end-less method definition
  def balanced?(g) = balance(g).empty?
end
```
It was quite a challenge to write the algorithm entirely in this form.
Can you see how it works? Me neither, and I wrote it! LOL.

Anyways, hope that's enough to get you started.
