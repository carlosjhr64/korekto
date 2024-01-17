# Korekto kernel

## Ruby patches

### Balanced

* `balanced?(g)`: for balanced brackets

Canonical use:

* `balanced?('(){}[]')`
```korekto
::Array#blp(k,m)      = (m==0)?self<<k:(k==last)?self[0..-2]:self<<k
::Array#bli           = inject([]){|a,km| a.blp(*km)}
::Array#blm(g)        = map{|c| g.index(c).divmod(2)}
::Array#bls(g)        = select{|c| g.include?(c)}
::String#balance(g)   = chars.bls(g).blm(g).bli
::String#balanced?(g) = balance(g).empty?
```
### Tight

* `ltight?(c)`: each c follows non-space
* `rtight?(c)`: each c followed by non-space
* `tight?(c)`: each c surrounded by non-space

Canonical use:

* Exponentiation: `tight?('^')`
* Factorial: `ltight?('!')`
```korekto
::String#ltight?(c) = !include?(' '+c)
::String#rtight?(c) = !include?(c+' ')
::String#tight?(c) = ltight?(c) && rtight?(c)
```
