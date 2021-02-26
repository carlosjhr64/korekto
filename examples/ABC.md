# [ABC music notation](https://abcnotation.com/)

This is just of a proof a concept...
An ABC music notation validator written in `Korekto`.
Not fully implemented but just enough for the demonstration song.
```korekto
# The default scanner is ':\w+|.'.
# Need to change it:
! scanner: '".*"|.'
# Then proceed with the validations:
/^X:\d+ %$/	#A1
/^T:".*" %$/	#L2
/^M:\d+/\d+ %$/	#A3
/^C:".*" %$/	#L4
/^K:[A-G] %$/	#A5
/^\|:[A-Ga-g\d]+ [A-Ga-g\d]+(\|[A-Ga-g\d]+ [A-Ga-g\d]+)*\| %$/	#A6
/^[A-Ga-g\d]+ [A-Ga-g\d]+(\|[A-Ga-g\d]+ [A-Ga-g\d]+)*:\| %$/	#A7
# And the allowed symbols:
XTMCK |/:%	#D8
0123456789	#D9
ABCDEFG	#D10
abcdefg	#D11
# Finally, redefine the fence:
! fence: 'abc'
```
Now the song in ABC notation:
```abc
X:1 %	#T12/A1
T:"Speed the Plough" %	#S13/L2
M:4/4 %	#T14/A3
C:"Trad." %	#S15/L4
K:G %	#T16/A5
|:GABc dedB|dedB dedB|c2ec B2dB|c2A2 A2BA| %	#T17/A6
  GABc dedB|dedB dedB|c2ec B2dB|A2F2 G4:| %	#T18/A7
|:g2gf gdBd|g2f2 e2d2|c2ec B2dB|c2A2 A2df| %	#T19/A6
  g2gf g2Bd|g2f2 e2d2|c2ec B2dB|A2F2 G4:| %	#T20/A7
```
