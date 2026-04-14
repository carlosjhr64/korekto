# Handwaves

TODO...

## Hiding labels

Once labels(or indices) are shown, allow them to hide until needed.
```korekto
# HIDING
# The folowing hand-wave is for the Vector component label form:
# 1. Labels to hide? Check the antecedent for a term like ...ᵢʲ𝒂ⱼ...
# 2. Vector component labels? Check the heap for ᵢ₊ = ⱼ
# 3. Verify(in heap) that ⱼ → ʲ
# 4. Remove [ᵢʲ] globally
# 5. Replace ⱼ with ₊ globally... result should equal consequent
~ :M/ᵢʲ𝒂ⱼ/t|g/\A$1₊ = $4\Z/|g/\A$4 → $2\Z/|s/[$1$2]//g|s/$4/₊/g
# REVEALING
# The folowing hand-wave is for the Vector component label form:
# 1. Labels to show? Check consequent for term 𝑨ᵢʲ𝒂ⱼ
# 2. Check that ⱼ → ʲ
# 3. Chech ᵢ₊ = ⱼ
# 4. Find label ⱼ → ʲ
# 5+. Append the labels
~ :m/𝑨ᵢʲ𝒂ⱼ/t|g/$5 → $3/|g/$2₊ = $5/|s/([𝒂-𝒛])/\1$2/g|s/$1$4$2₊/$1$2$3$4$5/
```
## Set equations
```korekto
~ :M/𝕒/t|g/$1\[𝓍\]/t|s/$1/$2/g
```
