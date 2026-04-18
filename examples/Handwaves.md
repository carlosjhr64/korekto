# Handwaves

Handwaves have the following pattern:  `~ :<command 1>[|<command 2>...]`
Each command must pass in turn for the Handwave to succeed.
The commands look like Vim commands, but they use Ruby's Regexp.
The end result should transform the antecedent into the consequent.
The following commands are available:

* Match consequent(current statement): `m/<regexp>/`, `m/<pattern>/t`
* Match antecedent(previous statement): `M/<regexp>/`, `M/<pattern>/t`
* Match up the heap: `g/<regexp>/`, `g/<pattern>/t`
* Substitute in antecedent: `s/<template>/<replacement>/`
* Substitute in antecedent globaly: `s/<template>/<replacement>/g`

`regexp` is a valid Ruby Regexp pattern.

`pattern` has tokens that need to be translated into a valid `regexp`, thus
a command that uses it needs to specify the trailing `/t` in the command.
See the [Tutorial Patterns section](Tutorial#Patterns) for a explanation.

Matches may capture, with captures stored in numbered variables: `$1`, `$2`, `$3`...

`template` is a valid regexp which may contain numbered variables
where captures are interpolated in.

`replacement` is a string which may contain number variables
where captures are interpolated in.

## Handwaves by examples

### Search and replace

```korekto
! scanner: ':\w+|.'
#> 1. Find the first ":key = k" up the heap('g/' means search up the heap)
#> 2. See if a global :key to k translates the antecedent into the consequent
~ :g/^(:\w+) = ([^\s\w])$/|s/$1/$2/g
:PI = π	#D1
c = 2*:PI*r	#D2
#> Replace :PI with π globally in the antecedent
c = 2*π*r	#H3
:Alpha = α	#D4 : :Alpha α
:Alpha^2 = :Alpha*:Alpha	#D5 : ^
#> Replace :Alpha with α globally in the antecedent
α^2 = α*α	#H6
```

### Commutation

```korekto
~ :M/\((\S+) \+ (\S+)\)/|s/\($1 \+ $2\)/($2 + $1)/
z = k*(ax + by)	#D7
z = k*(by + ax)	#H8
```
