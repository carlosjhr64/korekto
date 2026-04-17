# Handwaves

Hanswaves have the following pattern:  `~ :<step 1>[|<step 2>...]`
Each step must pass in turn for the Handwave to succeed.
The steps look like a Vim command.

## Handwaves by examples

### Search and replace

```korekto
! scanner: ':\w+|.'
#> 1. Find the first ":key = k" up the heap('g/' means search up the heap)
#> 2. See if a global :key to k swap translates the antecedent into the consequent
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
