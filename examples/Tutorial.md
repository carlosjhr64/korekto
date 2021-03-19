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
-:72:D1:5 Symbols including space
-:73:D2:10 Numbers
-:74:D3:10 Words
-:85:A4:Reflection
-:94:T5/A4:Reflection
-:106:I6:Modus ponen
-:108:I7:Synthesis
-:117:P8:How can you have any pudding?
-:118:P9:You did have your meat!
-:126:C10/I6,P8,P9:Modus ponen
-:127:C11/I7,P9,C10:Synthesis
-:136:M12:If A and B, then A good with B
-:144:R13/M12,C11:If A and B, then A good with B
-:153:E14:Also good with 1
-:166:X15/E14,R13:Also good with 1
-:177:L16:Let 1
-:185:S17/L16:Let 1
-:269:A18:Reflection
-:276:M19:If A and B, then A good with B.
```
Also, in `neovim` you can run the command `Korekto` or press `<F7>`.
It will check your work and move the cursor to the first error it finds.
It will also automate many of the statement's comments.
You only need to give the statement type,
`Korekto` completes the comment.

Keep in mind that as powerful as `Regexp` can be,
you'll run into weaknesses in the `Regexp` engine.
There will be times when the simple pattern generator can't create the test you want, and
you'll consider using a literal `Regexp`.
And some tests may not be possible...
the current consensus is that `Regexp` is not Turing Complete.
So you may consider using the `instance_eval` and monkey patch options.
You'll be going down the rabbit hole of trying to create a proof assistant for your project...
burying yourself down all the way to first principles.
CONSIDER YOURSELF WARNED!

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

### D is for Definition

`D` statements are used to introduce new symbols.
It must introduce at least one new symbol.
```korekto
{= &}	#D1 5 Symbols including space
{0 1 2 3 4 5 6 7 8 9}	#D2 10 Numbers
{:pudding :meat :good :if :then :with :cherry :let :there :be}	#D3 10 Words
```
You can specify the number of symbols to be defined in the comment title,
but it's not required.

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
Because this entails a search that grows very quickly with
the size of the list of statements,
`Korekto` requires that the correct combination be found in the last 13 statements.
Restatement of previous results are allowed so as to add old statements into the search heap.
```korekto
# :if A :then B;A;B
/^:if (:\w+) :then (:\w+)\n\1\n\2$/	#I6 Modus ponen
# A;B;A&B
/^(:\w+)\n(:\w+)\n\1&\2$/	#I7 Synthesis
```
`I` statements may introduce new symbols.

### P is for Postulate

`P` statements are used to introduce new facts(underivable from previous statements).
It cannot have any undefined symbols.
```korekto
:if :meat :then :pudding	#P8 How can you have any pudding?
:meat	#P9 You did have your meat!
```
### C is for Conclusion

`C` statements are those that matched any preceding `I` statements
in combination with two previous statements in the heap(typically the last 13 statements).
They must not have any undefined symbols.
```korekto
:pudding	#C10/I6,P8,P9 Modus ponen
:meat&:pudding	#C11/I7,P9,C10 Synthesis
```
### M is for Mapping

`M` statements are acceptance patterns on two statements,
one previously accepted statement and the one being validated.
The accepted statement must be in the heap(typically the last 13 statements).
```korekto
# A&B;A :good :with B
/^(:\w+)&(:\w+)\n\1 :good :with \2$/	#M12 If A and B, then A good with B
```
### R is for Result

`R` statements are those that matched any preceding `M` statements
in combination with one previous statement in the heap(typically the last 13 statements).
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
:cherry :also :good :with :pudding	#X15/E14,R13 Also good with 1
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
:let :there :be :light	#S17/L16 Let 1
```
### W is for Which

Sometimes a statement might be validated by
either an `M` mapping or an `I` inference,
but you forget which... so is it `R` or `C`?
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
The period at the start of the pattern name means this pattern is not to capture.
Pattern definitions have the following form:
```ruby
%r{^! (?<type>\S+)\s*/(?<pattern>.*)/$}
/^! (?<type>\S+)\s*\{(?<variables>\S+( \S+})*)\}$/
```
So if you want to capture a number into pattern variables(i,j,k), you could write:
```korekto
! Number /\d+/
! Number {i j k}
```
A Reflection axiom like `#A3` above can then be rewritten for numbers as:
```korekto
i=i	#A18 Reflection
```
Although you'll probably want to make a Reflection axiom a bit more general than for just numbers.
Demonstrating the use of `!:nl {;}`, map `#M11` above could be rewritten as follows:
```korekto
! KeyWord /:\w+/
! KeyWord {A B}
A&B;A :good :with B	#M19 If A and B, then A good with B.
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

# Scanner

The default scanner pattern is ':\w+|.'.
This is good for mostly logographic statements such as found in mathematical formulas:
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
# Fence

The default fence in a `Markdown` file is `korekto`.
There may be situations where you'll want `Korekto` to read code fenced as another language,
as in the [ABC music notation](ABC.md) example.
You can change the fence to something else, like `abc` for example:
```korekto
! fence: 'abc'
```
# Section

The default section is the basename of the file without the extension.
You can set the section name as follows:
```korekto
! section: 'Numbers'
```
# Save and Restore

There are times when you'll want to go on a side track in your proof, but
then go back to some prior point discarding the side track...
maybe to demonstrate a dead end.
You can use `! save: '<key>'` and `! restore '<key>'` to do that:
```korekto
! save: 'backup'
# Go on to say whatever nonsense...
# ...then go back the to saved point as if nothing said.
! restore: 'backup'
```
After the `restore`, then statement numbers will continue to increment normally, but
the statements made after the `save` are gone.

# Final thoughts

I hope this gives you enough to get started.
Feel free to contact me for further help.
As you'll see in all my projects, there are no issues.
That's because I write perfect code that never breaks,
with such clear documentation no one ever has any problems.
