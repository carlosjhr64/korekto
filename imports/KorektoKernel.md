# Kernel

## Ruby patches

### Balanced
```korekto
::Array#blp(k,m) = (m==0)?self<<k:(k==last)?self[0..-2]:self<<k
::Array#bli      = inject([]){|a,km| a.blp(*km)}
::Array#blm(g)   = map{|c| g.index(c).divmod(2)}
::Array#bls(g)   = select{|c| g.include?(c)}
::String#balance(g)   = chars.bls(g).blm(g).bli
::String#balanced?(g) = balance(g).empty?
```
### Tight
```korekto
# If it includes s, s is between non-spaces.
::String#tight?(*s) = s.all?{include?(_1)? match?(Regexp.new("\S#{_1}\S")) : true}
```
