# Computation
In this quick example,
I show how one can combine a syntax rule with a pattern to create a complete test.
In this given case, the work is entirely done by the syntax rule and
the pattern is just to set a statement type(A=>T).
All I'm really doing is evaluation ruby code of the form `a == b`:
```korekto
######################################################################
::String#is_equation? = match?(/^[\d\.\+\-\*\/ ]+==[\d\.\+\-\*\/ ]+$/)
? (is_equation?)? eval(self): true
##################################
/^.*==.*$/	#A1
0123456789 .+-*/=	#D2
#############################
1+2+3+4 == 10	#T3/A1
1*2*3*4 == 24	#T4/A1
5.0/2 == 2.5	#T5/A1
# ERROR: syntax: (is_equation?)? eval(self): true
5 * 2 == 15 #W
```
