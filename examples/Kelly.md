# The Kelly Kicker Bet

Examining Kelly bets in excruciating detail.

## Abstract

The additional Kelly bet when odds improve is:

      B₊ = Bₖ - B₀(1 - w₀/w)

Where:

* B₊ is the additional amount to bet
* Bₖ is the Kelly bet without a preexisting bet
* B₀ is the preexisting bet
* w₀ is the win proportion for the preexisting bet
* w is the win proportion for the additional bet

## Preliminaries

Although I don't have a proof checker that can check this text(yet),
I write it as though one exists.

    ! scanner: ':[A-Za-z]+|:\W+|[\d.]+|.'

The symbols `=`, `:=`, and `::`
when loosely speaking are often referred to as "equals".
But here I distinguish among:

* True when operands have the same value: `=`
* Asserts operands have the same value: `=`
* Left operand is defined as the right operand in context: `::`
* Left operand is assigned the value of the right operand: `:=`

Furthermore, ` and `:=` can instantiate the left operand.
And `::` can instantiate the entire statement.

## Instantiators

    :Real{x}     # ℝ
    1 :: x / x
    0 :: x - x
    :Fraction{x} :: :Real{x}{ 0 < x < 1 }
    :Postive{x}  :: :Real{x}{ x > 0 }
    :Integer{i}  # ℤ
    :Number{i}   :: :Integer{i}{ i > 0 }
    :Big{i}      :: :Integer{i}{ i :>> 1 }

## Probabilites `p` and `q`

Note that probabilities technically could equal one or zero, but
these create trivial cases.
Probability to win:

    :Fraction{ p }

Probability to loose:

    q :: 1 - p

Probabilities sum to one:

    p + q = 1

Probabilities are bound:

    0 < p < 1
    0 < q < 1

Note that `p` and `q` are the actual probabilities of a win and loose, but
in practice these may be one's own best estimates.

## Bets

The win from a bet is a proportion of the bet:

    :Positive{B}
    :Positive{w}
    W :: wB

The loose from a bet is a proportion of the bet:

    :Positive{l}
    L :: lB

Typically, one forfeits the entire bet on a loss... `l:=1`.
Translate prediction market's "Yes" vs "No" to `w`(and vice-versa):

    :if l=1
      :Faction{:yes}
      :no :: 1 - :yes
      #######################
      w :: :no / :yes       #
        = (1 - :yes)/:yes   #
      #######################
      w:yes = 1 - :yes
      w:yes + :yes = 1
      :yes(w + 1) = 1
      ##################
      :yes = 1/(w+1)   #
      ##################
    :end

Translate money-line odds to `w`:

    :if l=1
      :Real{:money}{:abs[:money] :>= 100}
      :if :Positive{:money}
        :underdog :: :money
        :total :: :underdog + 100
        :underdog = :total - 100
        :yes :: 100/:total
             = 100/(:underdog + 100)
        w :: :no/:yes
        w = (1 - :yes)/:yes
        w = (1 - 100/:total)/(100/:total)
        w = :total(1 - 100/:total)/100
        w = (:total - 100)/100
        ##############################
        # Bets $100 to get $underdog #
        w = :underdog / 100          #
        :underdog = 100w             #
        ##############################
      :else
        :favorite :: :abs[:money]
        :total :: :favorite + 100
        100 = :total - :favorite
        :yes = :favorite/:total
             = :favorite/(:favorite + 100)
        w :: :no/:yes
        w = (1 - :yes)/:yes
          = (1 - :favorite/:total)/(:favorite/:total)
          = :total(1 - :favorite/:total)/:favorite
          = (:total - :favorite)/:favorite
        ##############################
        # Bets $favorite to get $100 #
        w = 100 / :favorite          #
        :favorite = 100/w            #
        ##############################
      :end
    :end

Fractional odds is straight forward... It's `w`:`l`.

Finally, I want to define the "edge" a bet has:

    :if l=1
      :yes = 1/(w+1)
      #######################
      :edge :: p - :yes     #
      :edge = p - 1/(w+1)   #
      #######################
      :edge(w+1) = p(w+1) - 1
      w:edge + :edge = pw + p - 1
      w:edge + :edge = pw + q
      w:edge - pw = q - :edge
      w(:edge - p) = q - :edge
      ###############################
      w = (q - :edge)/(:edge - p)   #
      ###############################
    :end

A bet with a positive edge is a winning bet and
is a measure of how good a bet is.

## Bankroll

Initial(positive) wealth(S):

    :Potitive{ S[:Initial] }
    S := S[:Initial]

Bet(B) for binary event, a fraction(f) of wealth(S):

    :Fraction{ f }
    B[S] :: fS

If win, gain(W) amount won, a proportion(w) of bet(B):

    :Positive{ w }
    W[S] :: wB[S]
         = wfS


If loose, forfeit(L) amount lost, a proportion(l) of bet(B):

    :Positive{ l }
    L[S] :: lB[S]
         = lfS

Wealth after a win:

    S[:Win] :: S + W[S]
            = S + wfS
            = S(1 + wf)

    P :: (1 + wf)

    S[:Win] = SP

Wealth after a loose:

    S[:Loose] :: S - L[S]
              = S - lfS
              = S(1 - lf)

    Q :: (1 + lf)

    S[:Loose] = SQ

The betting loop:

    S := S[:Initial]
    :loop{
      # S :+= (:rand > p)? -L[S] : W[S]
      # S :*= (:rand > p)? (1 - lf) : (1 + wf)
      S :*= (:rand > p)? Q : P
      # S :*= (:rand :<= p)? P : Q
    }

The betting loop with history:

    S[0] := S[:Initial]
    n := 0
    :loop{ S[n:+=1] = S[n](:rand > p ? Q : P) }

Wealth(bankroll) after N trials:

    :Number{N}
    G := 1
    :repeat[N]{ G :*= (:rand > p ? Q : P) }
    S[N] = GS[0]

Keep track of the components of G:

    :Number{N}
    G[0] := 1
    n := 0
    :repeat[N]{ G[n:+=1] := (:rand > p ? Q : P) }
    S[N] = S[0] :Product[G]

Note that the component of the product commute.
That means that we can collect all the P's and all the Q's and group them.
That is, for example: `PQQPQQQP = PPPQQQQQ = P^3 Q^5`:

    i :: :Count[G] {|g| g = P }
    j :: :Count[G] {|g| g = Q }
    S[N] = S[0] P^i G^j

Consider a very large N:

    :Big{N}
    # By law of large numbers:
    i ~ pN
    j ~ qN
    S[N] ~ S[0] P^(pN) Q^(qN)

    :Limit[:Infinity] {|N| (S[N]/S[0]) ^ (1/N) }
    = :Limit[:Infinity] {|N| (S[0] P^i Q^j) ^ (1/N) }
    = :Limit[:Infinity] {|N| (P^(i~pN) Q^(j~qN)) ^ (1/N) }
    = (P^(pN) Q^(qN)) ^ (1/N)
    =  P^p Q^q
    = (1 + wf)^p (1 - lf)^q

So that was a very long discussion to illustrate why we don't use
the arithmetic mean for the expected value of S after a bet:

    S[:Arithmetic] :: pS[:Win] + qS[:Loose]   # Wrong!
                   = pS(1 + wf) + qS(1 - lf)
                   = S(p(1 + wf) + q(1 - lf))
                   = S(p + pwf + q - qlf)
                   = S(p + q + pwf - qlf)
                   = S(1 + pwf - qlf)
                   = S(1 + f(pw - ql))

    S[:Geometric] :: S[:Win]^p S[:Loose]^q   # Correct!
                  = S (1 + wf)^p (1 - lf)^q
                  = S P^p Q^q

## Derivation of the Kelly fraction

We want to choose f that maximizes the growth of S.
For that we find the solution to `D[S[n],f]=0`:

    S[n] ~ S P^(pN) Q^(qN)
         = S(P^p Q^q)^N
         = S((1 + wf)^p (1 - lf)^q)^n

    r :: P^p Q^q
      = (1 + wf)^p (1 - lf)^q

    S[n] ~ S r^n

    D[S[n],f] ~ D[ S r^n, f]
              = nSr^(n-1) D[r,f]

    :if D[Sr^n, f]=0
      nSr^(n-1) D[r,f] = 0
      D[r,f] = 0
    :end

So we require `D[r,f]=0`:

    D[r,f] = D[P^p Q^q, f]
           = Q^q D[P^p, f] + P^p D[Q^q, f]                       # Product Rule
           = Q^q pP^(p-1) D[P,f] + P^p qQ^(q-1) D[Q,f]           # Power Rule
           = Q^q pP^(p-1) D[1+fw, f] + P^p qQ^(q-1) D[1-fl, f]   # Substitution
           = Q^q pP^(p-1)(w) + P^p qQ^(q-1)(-l)                  # D[kx,x]=k
           # Pay attention to the sign in -l
           = pw Q^qP^(p-1) - ql P^pQ^(q-1)                       # Rearrange

    :if D[r,f] = 0
      pw Q^qP^(p-1) - ql P^pQ^(q-1) = 0
      pw P^(p-1) - ql P^pQ^(-1) = 0       # /Q^q
      pw P^(-1) - ql Q^(-1) = 0           # /P^q
      pw/P - ql/Q = 0
      (pwQ - qlP)/(PQ) = 0
      pwQ - qlP = 0                       # *PQ
      pw(1-fl) - ql(1+fw) = 0             # Substitution
      pw - pwfl - ql - qlfw = 0           # Expand
      pw - ql - pwfl - qlfw = 0           # Rearrange
      pw - ql - fwl(p + q) = 0            # Factor out -fwl
      pw - ql - fwl = 0                   # p+q=1
      pw - ql = fwl
      (pw - ql)/(wl) = f
      f = (pw - ql)/(wl)
      f = pw/(wl) - ql/(wl)
      f = p/l - q/w
    :end
    ###################
    fₖ :: p/l - q/w   # The Kelly Fraction
    ###################

## Alternate forms of the Kelly fraction

    fₖ :: p/l - q/w
    :if l = 1
      fₖ = p - q/w
      w = :no/:yes
      ######################
      fₖ = p - q:yes/:no   # Prediction Market Kelly
      ######################
      :if :Positive[:money]
        w = :underdog/100
        ###########################
        fₖ = p - 100q/:underdog   # Underdog Kelly
        ###########################
      :else
        w = 100/:favorite
        ###########################
        fₖ = p - q:favorite/100   # Favorite Kelly
        ###########################
      :end
      w = (q - :edge)/(:edge - p)
      fₖ = p - q(:edge - p)/(q - :edge)
         = (p(q - :edge) - q(:edge - p))/(q - :edge)
         = (pq - p:edge - q:edge + qp)/(q - :edge)
         = (2pq - p:edge - q:edge)/(q - :edge)
         = (2pq - :edge(p + q)/(q - :edge)
      ##################################
      fₖ = (2pq - :edge)/(q - :edge)   # Edge Kelly
      ##################################
    :end

## The kicker bet

If after placing a bet one later is offered worse odds,
one would obviously not place an additional bet.
An additional bet is not a new independent bet.
But if later offered better odds...
The question becomes what an addition bet should be
given one already has an amount at risk for the same event.
The overall effect is a change in the P and Q:

    ... 
    S[:Win] = S + w₀f₀+ wfS
    ... 
    S[:Loose] = S - l₀f₀- lfS
    ...
    P :: (1 + w₀f₀ + wf)
    Q :: (1 - l₀f₀ - lf)

The redefinition is a generalization of the case without f₀:

    :if f₀
      P = (1 + wf)
      Q = (1 - lf)
    :end

Note that along with `w`, `w₀`, `l`, and `l₀`; `f₀` is a constant!
The `f₀` bet has been placed and cannot be changed.
The derivation above proceeds mostly unchanged as shown here:

    D[r,f] = D[P^p Q^q, f]
           ...
           # Substitution
           = Q^q pP^(p-1) D[1+w₀f₀+fw, f] + P^p qQ^(q-1) D[1-l₀f₀-fl, f]
           # D[kx,x]=k
           = Q^q pP^(p-1)(w) + P^p qQ^(q-1)(-l) # Same
           ...

    :if D[r,f] = 0
      ...
      pwQ - qlP = 0                               # *PQ
      pw(1 - l₀f₀ - lf) - ql(1 + w₀f₀ + wf) = 0   # Substitution

After that point we can make the algebra more familiar(look nearly the same)
by introducing some helper substitutions:

      ...
      pw(1 - l₀f₀ - lf) - ql(1 + w₀f₀ + wf) = 0   # Substitution
      P₀ :: 1 + w₀f₀
      Q₀ :: 1 - l₀f₀
      pw(Q₀ - lf) - ql(P₀ + wf) = 0    # Substitution
      pwQ₀ - pwlf - qlP₀ - qlwf = 0    # Expand
      pwQ₀ - qlP₀ - pwlf - qlwf = 0    # Rearrage
      pwQ₀ - qlP₀ - fwl(p + q) = 0     # Factor out -fwl
      pwQ₀ - qlP₀ - fwl = 0            # p+q=1
      pwQ₀ - qlP₀ = fwl
      pwQ₀/(wl) - qlP₀/(wl) = f
      pQ₀/l - qP₀/w = f
      f = pQ₀/l - qP₀/w
      f = p(1 - l₀f₀)/l - q(1 + w₀f₀)/w
    :end
    #######################################
    f₊ :: p(1 - l₀f₀)/l - q(1 + w₀f₀)/w   # Kelly Added Fraction
    #######################################

NOTE: `f₊` and `f₀` act on the same bankroll(`S`).
Given `B₀`:

    f₀ :: B₀/S
    B₊ :: f₊S   # The additional bet

Furthermore, `B₀` could be any amount, it need not have been a "Kelly" bet.

## Exploring the kicker bet

As one's original bet becomes vanishingly small,
one recovers the standard Kelly Fraction:

    :Limit[0]{|f₀| p(1 - l₀f₀)/l - q(1 + w₀f₀)/w }
    = p/l - q/w
    = fₖ

The normal case where `l` and `l₀` are one:

    f₊ :: p(1 - l₀f₀)/l - q(1 + w₀f₀)/w
    :if l=1 && l₀=1
      ##################################
      f₊ = p(1 - f₀) - q(1 + w₀f₀)/w   #
      ##################################

      # If f₀ was a Kelly Fraction...
      :if f₀ = p - q/w₀
        # As w approaches w₀, f₊ aproaches zero:
        :Limit[w₀]{|w| p(1 - f₀) - q(1 + w₀f₀)/w }
        = p(1 - f₀) - q(1 + w₀f₀)/w₀
        = p - pf₀ - q/w₀ - qw₀f₀/w₀
        = p - pf₀ - q/w₀ - qf₀
        = p - q/w₀ - pf₀ - qf₀
        = p - q/w₀ - f₀(p + q)
        = p - q/w₀ - f₀
        = f₀- f₀   # f₀=p-q/w₀
        = 0
      :end
    :end

    fₖ :: p/l - q/w
    f₊ :: p(1 - l₀f₀)/l - q(1 + w₀f₀)/w
    Bₖ :: fₖB
    B₊ :: f₊S
    f₀ :: B₀/S
    B₀ = Sf₀
    :if l=1 && l₀=1
      fₖ = p - q/w
      f₊ = p(1 - f₀) - q(1 + w₀f₀)/w
      B₊/S = f₊
           = p(1 - f₀) - q(1 + w₀f₀)/w
           = p(1 - B₀/S) - q(1 + w₀B₀/S)/w   # f₀::B₀/S
      B₊ = Sp(1 - B₀/S) - Sq(1 + w₀B₀/S)/w
      B₊ = Sp - B₀ - (Sq - w₀B₀)/w
      B₊ = Sp - B₀ - Sq/w - B₀w₀/w
      B₊ = S(p - q/w) - B₀(1 - w₀/w)
      B₊ = Sfₖ - B₀(1 - w₀/w)
      ##########################
      B₊ = Bₖ - B₀(1 - w₀/w)   # Kelly Added Bet
      ##########################
      :if :Positive{:money}
        # :underdog GREATER THAN :underdog₀ presumably, else no kiker bet
        w = :underdog / 100
        w₀ = :underdog₀ / 100
        ########################################
        B₊ = Bₖ - B₀(1 - underdog₀/underdog)   # Underdog Kelly Added Bet
        ########################################
      :else
        # :favorite LESS THAN :favorite₀ presumably, else no kiker bet
        w = 100 / :favorite
        w₀ = 100 / :favorite₀
        ########################################
        B₊ = Bₖ - B₀(1 - favorite/favorite₀)   # Favorite Kelly Added Bet
        ########################################
      :end
    :end

## Final comments

I mentioned the possibility of proof checker.
I don't have one for this text, but
I've been working on proof checkers in my project, [Korekto](https://github.com/carlosjhr64/korekto).
I believe notation should focus on the problem being tackled
rather than the proof checker.
Having said that, notation must be unambiguous, precise, concise, and
above all... Human readable.
I appreciate any suggestions on how to improve notation.

### Credits

I'm not familiar enough with the field to give proper credits.
The explanation to support the Kelly Criterion I've seen
are based on using logs, which is equivalent, but
the rational seems to be different.
The proof given here is my own work, and
my "Kelly Added Bet" seems to go against
[Proebsting's paradox](https://en.wikipedia.org/wiki/Proebsting%27s_paradox).
The YouTube video that got me started on this work was:

>> [Kelly Criterion:](https://www.youtube.com/watch?v=x9EuFSTnXOE)
>> The Math of Gambling, Proebsting's Paradox, and the Stock Market
>> by [Luck by Numbers](https://www.youtube.com/@LuckbyNumbers)

Also helpful was the first chapter of the following book:

>> The Kelly Capital Growth Investment Criterion
>> Editors: Leonard C MacLean, Edward O Thorp, William T Ziemba
>> 1. Introduction to the Early Ideas and Contributions

My Kindle e-version has notation problems(apparently due to OCR issues) which
for me made it barely readable, and
so I did not continue past the first chapter.
But it did give me some hints on how the proof goes
in applying the law of large numbers.

So with that caveat, the original source for the
[Kelly Criterion](https://en.wikipedia.org/wiki/Kelly_criterion)
is obviously
[John Larry Kelly Jr.](https://en.wikipedia.org/wiki/John_Larry_Kelly_Jr.).
