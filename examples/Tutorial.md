# Tutorial

* [Statement types](#Statement types)
* [Statements table](#Statements table)

## Intro

Hello! How are you doing?
OK, this section TODO.

## Statement types

Although I tried to match the normal semantics of
the words used to describe the statement types
(Definition, Postulate, Axion, Tautology, ...),
the statement types have a very specific meaning in the `Korekto` code.

### `D` is for Definition

`D` statements are used to introduce new symbols.
It must introduce at least one new symbol.
```korekto
N={1,2,3,4,5,6,7,8,9,...}	#D19 Natural numbers
```
### `P` is for Postulate

`P` statements are used to introduce new facts(underivable from previous statements).
It cannot have any undefined symbols.

### `A` is for Axiom

`A` statements are acceptance patterns on single statements.
They recognize tautologies.
```korekto
/^(\w)=\1$/	#A31 Reflexion
```
### `T` is for Tautology

`T` statements are those that match any preceeding `A` statements.
They must not have any undefined symbols.
```korekto
4=4	#T37/A31 Reflexion
```
### `I` is for Inference

`I` statements are acceptance patterns on three statements:
two accepted statement and a third to be validated.
Because this entails a search that grows very quickly with
the size of the list of statements,
`Korekto` requires that the correct combination be found in the last 13 statements.
Restatement of previous results are allowed so as to add old statements into the search heap.

### `C` is for Conclusion

`C` statements are those that matched any preceeding `I` statements
in combination with two previous statements in the heap(typically the last 13 statements).
They must not have any undefined symbols.

### `M` is for Mapping

`M` statements are acceptance patterns on two statements,
one previously accepted statement and the one being validated.
The accepted statement must be in the heap(typically the last 13 statements).

### `R` if for Result

`R` statements are those that matched any preceeding `M` statements
in combination with one previous statement in the heap(typically the last 13 statements).
The must not have any undefined symbols

### `E` is for Existential

`E` statements are mappings like `M`, but instead of yielding `R`(result) statements,
they yield `X`(instantiation) statements.
They are used to instantiate new symbols in some context.

### `X` if for Instantiation

`X` statements are results like `R`, but
are a consequce of an `E` existential statement, and
must introduce at least one new symbol.

## Statements table

I created these two tables of statement types which differ only in its sorting.
I was hoping to show that all statement types are covered.
Under "Undefined", "Yes" means it may have undefined symbols
whereas "Yes!" mean it must have at least one undefined sysmbol.

| Type | Description   | Undefined | Pattern | Yields | Newlines | Heap | Validator |
|:----:|:--------------|:----------|:--------|:------:|:--------:|:----:|:---------:|
|  I   | Inference     | Yes       | Yes     | C      | 2        | -    | -         |
|  E   | Existential   | Yes       | Yes     | X      | 1        | -    | -         |
|  M   | Mapping       | Yes       | Yes     | R      | 1        | -    | -         |
|  A   | Axiom         | Yes       | Yes     | T      | 0        | -    | -         |
|  D   | Definition    | Yes!      | No      | -      | -        | -    | -         |
|  X   | Instantiation | Yes!      | No      | -      | -        | 1    | E         |
|  R   | Result        | No        | No      | -      | -        | 1    | M         |
|  C   | Conclusion    | No        | No      | -      | -        | 2    | I         |
|  T   | Tautology     | No        | No      | -      | -        | -    | A         |
|  P   | Postulate     | No        | No      | -      | -        | -    | -         |

| Type | Description   | Undefined | Pattern | Yields | Newlines | Heap | Validator |
|:----:|:--------------|:----------|:--------|:------:|:--------:|:----:|:---------:|
|  D   | Definition    | Yes!      | No      | -      | -        | -    | -         |
|  P   | Postulate     | No        | No      | -      | -        | -    | -         |
|  A   | Axiom         | Yes       | Yes     | T      | 0        | -    | -         |
|  T   | Tautology     | No        | No      | -      | -        | -    | A         |
|  M   | Mapping       | Yes       | Yes     | R      | 1        | -    | -         |
|  R   | Result        | No        | No      | -      | -        | 1    | M         |
|  I   | Inference     | Yes       | Yes     | C      | 2        | -    | -         |
|  C   | Conclusion    | No        | No      | -      | -        | 2    | I         |
|  E   | Existential   | Yes       | Yes     | X      | 1        | -    | -         |
|  X   | Instantiation | Yes!      | No      | -      | -        | 1    | E         |

In my beta testing I have come accros some possible new usefull statement types.
Currently `Korekto` expects all patterns to capture,
although no checking is done if a literal Regexp is given.
