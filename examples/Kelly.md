# The Kelly Kicker Bet

Examining Kelly bets in excruciating detail.

## Preliminaries

Although I don't have a proof checker that can check this text(yet),
I write it as though one exists.

    # Scans decimals | labels | compound operator | character
    ! scanner: '[\d.]+|:[A-Za-z]+|[-+*/:=<>&]+|.'

The symbols `=`, `:=`, and `::`
when loosely speaking are referred to as "equals".
But here I distinguish among:

* True when operands have the same value: `=`
* Asserts operands have the same value: `=`
* Left operand is defined as the right operand in context: `::`
* Left operand is assigned the value of the right operand: `:=`

Furthermore, `:=` can instantiate the left operand.
And `::` may instantiate the entire statement,
but preferably only the left operand.

## Instantiators

    :Real{x}     # ℝ choose x when instantiating
    1 :: x / x
    0 :: x - x
    :Fraction{x} :: :Real{x : 0 < x < 1 }
    :Postive{x}  :: :Real{x : x > 0 }
    :Integer{i}  # ℤ choose i when instantiating
    :Number{i}   :: :Integer{i : i > 0 }
    :Big{i}      :: :Integer{i : i >> 1 }

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
    :Win :: wB

The loose from a bet is a proportion of the bet:

    :Positive{l}
    :Loose :: lB

Typically, one forfeits the entire bet on a loss... `l:=1`.
Translate prediction market's "Yes" vs "No" to `w`(and vice-versa):

    :if l=1
      :Fraction{:yes}
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
      :Real{:money : :abs[:money] >= 100}
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

Initial(positive) wealth(`S`):

    :Potitive{ S[:initial] }
    S := S[:initial]

Bet(`B`) for binary event, a fraction(`f`) of wealth(`S`):

    :Fraction{ f }
    B[S] :: fS

If win, gain(`:Win`) amount won, a proportion(`w`) of bet(`B`):

    :Positive{ w }
    :Win[S] :: wB[S]
         = wfS

If loose, forfeit(`:Loose`) amount lost, a proportion(`l`) of bet(`B`):

    :Positive{ l }
    :Loose[S] :: lB[S]
         = lfS

Wealth after a win:

    S[:win] :: S + :Win[S]
            = S + wfS
            = S(1 + wf)

    P :: (1 + wf)

    S[:win] = SP

Wealth after a loose:

    S[:loose] :: S - :Loose[S]
              = S - lfS
              = S(1 - lf)

    Q :: (1 + lf)

    S[:loose] = SQ

The betting loop:

    S := S[:initial]
    :loop{
      # S :+= (:rand > p)? -:Loose[S] : :Win[S]
      # S :*= (:rand > p)? (1 - lf) : (1 + wf)
      S :*= (:rand > p)? Q : P
      # S :*= (:rand <= p)? P : Q
    }

The betting loop with history:

    S[0] := S[:initial]
    n := 0
    :loop{ S[n:+=1] = S[n](:rand > p ? Q : P) }

Wealth(bankroll) after `N` trials:

    :Number{N}
    G := 1
    :repeat[N]{ G :*= (:rand > p ? Q : P) }
    S[N] = GS[0]

Keep track of the components of `G`:

    :Number{N}
    G[0] := 1
    n := 0
    :repeat[N]{ G[n:+=1] := (:rand > p ? Q : P) }
    S[N] = S[0] :Product[G]

Note that the component of the product commute.
That means that we can collect all the `P`'s and all the `Q`'s and group them.
That is, for example: `PQQPQQQP = PPPQQQQQ = P^3 Q^5`:

    i :: :Count[G] {|g| g = P }
    j :: :Count[G] {|g| g = Q }
    S[N] = S[0] P^i G^j

Consider a very large `N`:

    :Big{N}
    # By law of large numbers:
    i ~ pN
    j ~ qN
    S[N] ~ S[0] P^(pN) Q^(qN)

    :Limit[:infinity] {|N| (S[N]/S[0]) ^ (1/N) }
    = :Limit[:infinity] {|N| (S[0] P^i Q^j) ^ (1/N) }
    = :Limit[:infinity] {|N| (P^(i~pN) Q^(j~qN)) ^ (1/N) }
    = (P^(pN) Q^(qN)) ^ (1/N)
    =  P^p Q^q
    = (1 + wf)^p (1 - lf)^q

So that was a very long discussion to illustrate why we don't use
the arithmetic mean for the expected value of `S` after a bet:

    S[:arithmetic] :: pS[:win] + qS[:loose]   # Wrong!
                   = pS(1 + wf) + qS(1 - lf)
                   = S(p(1 + wf) + q(1 - lf))
                   = S(p + pwf + q - qlf)
                   = S(p + q + pwf - qlf)
                   = S(1 + pwf - qlf)
                   = S(1 + f(pw - ql))

    S[:geometric] :: S[:win]^p S[:loose]^q   # Correct!
                  = S (1 + wf)^p (1 - lf)^q
                  = S P^p Q^q

## Derivation of the Kelly fraction

We want to choose f that maximizes the growth of `S`.
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

    :Positive{B₀}     # A pre-existing bet
    :Positive{B₊}     # The additional bet to be determined
    B :: B₀ + B₊      # The total bet
    B₊ = B - B₀

    :Positive{w₀}     # The win factor for B₀
    :Positive{w₊}     # The win factor for B₊
    W₀ :: w₀B₀        # The win from B₀
    W₊ :: w₊B₊        # The win from B₊
    W :: W₀ + W₊      # The bets are tied to the save event
    w :: W/B          # The overall win factor for total bet B

Note that when considering an additional bet,
the current bank will have had the pre-existing bet deducted.
Since the additional bet will be tied to the that bet,
one needs to adjust the bank by that bet, and
treat the total bet as a single bet.

    :Positive{S₀}     # The current bank excluding the previous bet B₀
    S :: S₀ + B₀      # The effective bank
    fₖ :: p/l - q/w   # Kelly factor
    Bₖ :: Sfₖ         # Kelly bet

    :if l=1 :and B=Bₖ
      fₖ = p - q/w
      Bₖ = S(p - q/w)   # So now solve for the B₊ that's in there!
      B₀ + B₊ = S(p - q/w)       # Bₖ = B :: B₀+B₊
      B₀ + B₊ = S(p - q/(W/B))   # w :: W/B
      B₀ + B₊ = S(p - qB/W)
      B₀ + B₊ = S(p - q(B₀ + B₊)/W)               # B :: B₀+B₊
      B₀ + B₊ = S(p - q(B₀ + B₊)/(W₀ + W₊))       # W :: W₀ + W₊
      B₀ + B₊ = S(p - q(B₀ + B₊)/(w₀B₀ + w₊B₊))   # W₀ :: w₀B₀ :and W₊ :: w₊B₊

      # So I asked Google's Gemini to solve for B₊! :))
      # Turns out we can actually solve for the total bet B:

      B = S(p - qB/(w₀B₀ + w₊B₊))   # Swap back in B instead of B₀+B₊
      B/S = p - qB/(w₀B₀ + w₊B₊)                                 # /S
      qB/(w₀B₀ + w₊B₊) = p - B/S
      (w₀B₀ + w₊B₊)/qB = 1/(p - B/S)                             # Invert
      w₀B₀ + w₊B₊ = qB/(p - B/S)                                 # *qB
      w₀B₀ + w₊(B-B₀) = qB/(p - B/S)                             # B₊=B-B₀
      w₀B₀ + w₊B - w₊B₀ = qB/(p - B/S)                           # Expand
      B₀(w₀ - w₊) + w₊B = qB/(p - B/S)                           # Group B₀
      B₀(w₀ - w₊) + w₊B = qSB/(Sp - B)                           # *(S/S)
      (B₀(w₀ - w₊) + w₊B)(Sp - B) = qSB                          # *(Sp-B)
      (B₀(w₀ - w₊) + w₊B)Sp - (B₀(w₀ - w₊) + w₊B)B = qSB
      B₀(w₀ - w₊)Sp + w₊BSp - B₀(w₀ - w₊)B - w₊BB = qSB
      (w₀ - w₊)SpB₀ + w₊SpB - (w₀ - w₊)B₀B - w₊BB = qSB
      (w₀ - w₊)SpB₀ + w₊SpB - (w₀ - w₊)B₀B - w₊BB - qSB = 0
      -(w₀ - w₊)SpB₀ - w₊SpB + (w₀ - w₊)B₀B + w₊BB + qSB = 0      # *(-1)
      (w₊ - w₀)SpB₀ - w₊SpB + (w₀ - w₊)B₀B + w₊BB + qSB = 0
      w₊BB - w₊SpB + (w₀ - w₊)B₀B + qSB + (w₊ - w₀)SpB₀  = 0
      w₊BB + ( -w₊Sp + (w₀ - w₊)B₀ + qS)B + (w₊ - w₀)SpB₀  = 0
      w₊BB + ((w₀ - w₊)B₀ + qS - w₊Sp)B + (w₊ - w₀)SpB₀ = 0
      w₊BB + (-(w₊ - w₀)B₀ + qS - w₊Sp)B + (w₊ - w₀)SpB₀ = 0
      w₊BB + (qS - (w₊ - w₀)B₀ - w₊Sp)B + (w₊ - w₀)SpB₀ = 0
      w₊BB + (qS - w₊Sp - (w₊ - w₀)B₀ )B + (w₊ - w₀)SpB₀ = 0
      w₊BB + (S(q - w₊p) - (w₊ - w₀)B₀)B + (w₊ - w₀)SpB₀ = 0
      BB + (S(q/w₊ - p) - (1 - w₀/w₊)B₀)B + (1 - w₀/w₊)SpB₀ = 0   # /w₊
      BB - (S(p - q/w₊) + (1 - w₀/w₊)B₀)B + (1 - w₀/w₊)SpB₀ = 0

      ##################
      δ :: 1 - w₀/w₊   # Payoff Adjustment Factor
      ##################

      BB - (S(p - q/w₊) + δB₀)B + SpδB₀ = 0

      ##################
      f₊ :: p - q/w₊   # The Kicker(w₊) Kelly Factor
      ##################

      B² - (Sf₊ + δB₀)B + SpδB₀ = 0

      K :: Sf₊ + δB₀
      C :: SpδB₀

      B² - KB + C = 0

      ################################################################
      B = (K + √[K² - 4C])/2                                          #
      B = (Sf₊ + δB₀ + √[(Sf₊ + δB₀)² - 4SpδB₀])/2                    #
      B = (S(p - q/w₊) + (1 - w₀/w₊)B₀ +                              #
          √[(S(p - q/w₊) + (1 - w₀/w₊)B₀)² - 4(Sp(1 - w₀/w₊)B₀)])/2   #
      #################################################################

      # Given the total bet,
      # we deduct the preexisting bet to get the additional bet
      ###############
      B₊ = B - B₀   #
      ###############
    :end

## Exploring the kicker bet

It's obvious what happens when there's no previous bet:

    :if B₀=0
      B₊ = B - B₀ = B - 0
         = B
      K :: Sf₊ + δB₀ = Sf₊ + δ0
        = Sf₊
      C :: SpδB₀ = Spδ0
        = 0
      B² - KB + C = 0
      B² - Sf₊B + 0 = 0
      B² = Sf₊B
      ###########
      B = Sf₊   # B is the Kelly bet given w₊
      ###########
    :end

Does the model say to bet extra when `w₊=w₀`!?

    :if w₊=w₀
      δ :: 1 - w₀/w₊ = 1 - 1
        = 0
      K :: Sf₊ + δB₀ = Sf₊ + 0B₀
        = Sf₊
      C :: SpδB₀ = Sp0B₀
        = 0
      B² - KB + C = 0
      B² - Sf₊B + 0 = 0
      B² = Sf₊B
      B = Sf₊
      B₊ = B - B₀
      f₀ :: p - q/w₀      # The Kelly factor for w₀
      :if B₀=Sf₀          # If B₀ was a Kelly bet of S
          f₀ = p - q/w₊   # w₊=w₀
          f₀ = f₊
          B₀ = Sf₊
             = B
          B₊ = B - B
          B₊ = 0
      :end
    :end

So normally you would not increase your bet unless the odds improve.
If after you place your bet, your bankroll increases though,
you are justified to increase your bet accordingly.

## Credits

The YouTube video got me started on this overview:

* [Kelly Criterion...](https://www.youtube.com/watch?v=x9EuFSTnXOE) by [Luck by Numbers](https://www.youtube.com/@LuckbyNumbers)

Gemini gave valuable help in solving for `B₊`:

* Google's [Gemini](https://gemini.google.com/app)

The "Kelly criterion" is attributed to Larry Kelly Jr.:

* [Kelly criterion](https://en.wikipedia.org/wiki/Kelly_criterion)

I've spent over $100 in books trying to verify my solutions to the kicker bet,
but was unable to see anything that made sense(or was readable) to me.
And Gemini(Google's AI) was hallucinating sources.
People who very likely would have worked on this:

* [Edward O. Thorp](https://en.wikipedia.org/wiki/Edward_O._Thorp)
* Edmund Noon's [Extending Kelly...](https://www.doc.ic.ac.uk/~wjk/publications/noon-2014.pdf)
* Stewart N. Ethier.'s [The Doctrine of Chances](https://www.amazon.com/Doctrine-Chances-Probabilistic-Probability-Applications-ebook/dp/B00DWKPJRY/)

## Bloopers?

### The kicker bet

If after placing a bet one later is offered worse odds,
one would obviously not place an additional bet.
An additional bet is not a new independent bet.
But if later offered better odds...
The question becomes what an additional bet should be
given one already has an amount at risk for the same event.
The overall effect is a change in the `P` and `Q`.

But the setup has pitfalls.

    # WRONG!
    S[:win] = S + w₀B₀ + wB
            = S + w₀f₀S + wfS
            = S(1 + w₀f₀ + wf)

    # WRONG!
    S[:loose] = S - l₀B₀ - lB
              = S - l₀f₀S - lfS
              = S(1 - l₀f₀ - lf)

The bankroll `S` is the amount after the bet `B₀` has been made.
Presumably, the entire amount `B₀` is no longer available.
Consider also that while `B₀` was being held, other expenses may have occurred.
So I'm very motivated to define `f₀` (somewhat awkwardly) as:

    # NOPE!
    f₀ :: B₀/S   # B₀ and S are known to the current state

So how would `S` change on a `:win` and a `:loose`?
Firstly `B₀` is released to which then the wins or losses are applied.

    # Still WRONG!
    S[:win] = S + B₀ + w₀B₀ + wB
            = S + B₀(1 + w₀) + wB

    # Still WRONG!
    S[:loose] = S + B₀ - l₀B₀ - lB
              = S + B₀(1 - l₀) - lB

The problem is that it makes it look like `B₀` is getting an extra win.
We need to put both `B₀` and `B` on the same "footing".

    S₀ :: S+B₀
    f₀ :: B₀/S₀
    B :: f/S₀

    S[:win] = S₀ + w₀B₀ + wB
            = S₀ + S₀w₀f₀ + S₀wf
            = S₀(1 + w₀f₀ + wf)

    P₀ :: 1 + w₀f₀
    P :: P₀ + wf
    P = 1 + w₀f₀ + wf

    S[:loose] = S₀ - l₀B₀ - lB
              = S₀ - S₀l₀f₀ - S₀lf
              = S₀(1 - l₀f₀ - lf)

    Q :: Q₀ - lf
    Q₀ :: 1 - l₀f₀
    Q = 1 - l₀f₀ - lf

    r :: P^p Q^q

It almost looks like I went back to my original "WRONG!" setup, except that
I'm working with `S₀` instead of `S`.
The redefinition is a generalization of the case without f₀:

    :if f₀ = 0
      P :: P₀ + wf
        = 1 + w₀f₀ + wv
        = 1 + w₀*0 + wf
        = 1 + wf

      Q :: Q₀ - lf
        = 1 - l₀f₀ - lf
        = 1 - l₀*0 - lf
        = 1 - lf
    :end

Note that P₀ and Q₀ are constants with respect to f.
The derivation for the additional Kelly bet is structurally the same as before:

    D[r,f] = D[P^p Q^q, f]
           = Q^q D[P^p, f] + P^p D[Q^q, f]               # Product Rule
           = Q^q pP^(p-1) D[P,f] + P^p qQ^(q-1) D[Q,f]   # Power Rule
           #######################################################
           = Q^q pP^(p-1) D[P₀+fw,f] + P^p qQ^(q-1) D[Q₀-fl,f]   # SUBSTITUTION
           ################ ^ ####################### ^ ##########
           = Q^q pP^(p-1)(w) + P^p qQ^(q-1)(-l)   # SAME! D[kx,x]=k
           # Pay attention to the sign in -l
           = pw Q^qP^(p-1) - ql P^pQ^(q-1)        # Rearrange

    :if D[r,f] = 0
      pw Q^qP^(p-1) - ql P^pQ^(q-1) = 0
      pw P^(p-1) - ql P^pQ^(-1) = 0   # /Q^q
      pw P^(-1) - ql Q^(-1) = 0       # /P^q
      pw/P - ql/Q = 0
      (pwQ - qlP)/(PQ) = 0
      pwQ - qlP = 0               # *PQ
      #############################
      pw(Q₀-lf) - ql(P₀+wf) = 0   # SUBSTITUTION
      ## ^ ######### ^ ############
      pwQ₀ - pwlf - qlP₀ - qlwf = 0   # Expand
      pwQ₀ - qlP₀ - fwlp - fwlq = 0   # Rearrange
      pwQ₀ - qlP₀ - fwl(p + q) = 0    # Factor out fwl
      pwQ₀ - qlP₀ - fwl = 0           # p+q=1
      pwQ₀ - qlP₀ = fwl
      f = (pwQ₀ - qlP₀)/wl
      f = pQ₀/l - qP₀/w
      f = p(1 + l₀f₀)/l - q(1 + w₀f₀)/w
    :end
    #######################################
    S₀ :: S + B₀                          #
    f₀ :: B₀/S₀                           #
    f₊ :: p(1 + l₀f₀)/l - q(1 + w₀f₀)/w   # Additional Kelly Fraction
    B₊ :: S₀f₊                            # Additional Kelly Bet
    #######################################

### Exploring the kicker bet

If there's no prior bet, `B₀=0`, and one recovers the standard Kelly fraction:

    if B₀=0
      S₀ :: S + B₀
         = S + 0
         = S
      f₀ :: B₀/S₀
         = 0/S
         = 0
      f₊ :: p(1 + l₀f₀)/l - q(1 + w₀f₀)/w
         = p(1 + l₀0)/l - q(1 + w₀0)/w
         = p(1 + 0)/l - q(1 + 0)/w
         = p/l - q/w
         = fₖ
      B₊ :: S₀f₊
         = Sfₖ
         = Bₖ
    end

The normal case where `l` and `l₀` are one:

    :if l=1 & l₀=1
      f₊ :: p(1 + l₀f₀)/l - q(1 + w₀f₀)/w
         = p(1 + 1f₀)/1 - q(1 + w₀f₀)/w
      #################################
      f₊ = p(1 + f₀) - q(1 + w₀f₀)/w  # Additional Kelly fraction given l=l₀=1
      #################################
    :end

Kelly added bet `B₊` in terms of `Bₖ` and `B₀`:

    fₖ :: p/l - q/w
    Bₖ :: Sfₖ
    S₀ :: S + B₀
    f₀ :: B₀/S₀  =>  B₀ = S₀f₀
    f₊ :: p(1 + l₀f₀)/l - q(1 + w₀f₀)/w
    B₊ :: S₀f₊

    :if l=1 & l₀=1
      fₖ = p - q/w
      f₊ = p(1 + f₀) - q(1 + w₀f₀)/w
      B₊ :: S₀f₊
         = S₀(p(1 + f₀) - q(1 + w₀f₀)/w)
         = S₀(p + pf₀ - (q + qw₀f₀)/w)
         = S₀p + S₀pf₀ - S₀(q + qw₀f₀)/w
         = S₀p + S₀pf₀ - (S₀q + S₀qw₀f₀)/w
         = S₀p + S₀pf₀ - S₀q/w - S₀qw₀f₀/w       # Keep track of signs
         = S₀p + (S₀f₀)p - S₀q/w - (S₀f₀)qw₀/w
         = S₀p + B₀p - S₀q/w - B₀qw₀/w           # B₀=S₀f₀
         = S₀p - S₀q/w + B₀p - B₀qw₀/w
         = S₀(p - q/w) + B₀(p - qw₀/w)
         = S₀fₖ + B₀(p - qw₀/w)
         = (S + B₀)fₖ + B₀(p - qw₀/w)            # S₀=S+B
         = Sfₖ + B₀fₖ + B₀(p - qw₀/w)
         = Bₖ + B₀fₖ + B₀(p - qw₀/w)             # Bₖ::Sfₖ
         = Bₖ + B₀fₖ + B₀p - B₀qw₀/w
         = Bₖ + B₀(fₖ + p - qw₀/w)
         = Bₖ + B₀(p - q/w + p - qw₀/w)
         = Bₖ + B₀(2p - q/w - qw₀/w)
      ####################################
      B₊ = Bₖ + B₀(2p - (q/w)(1 + w₀))   #
      ####################################
         = Bₖ + B₀(p + p - (q/w)(1 + w₀))
         = Bₖ + B₀(p + p - q/w - qw₀/w))
         = Bₖ + B₀(p + fₖ - qw₀/w)
      ################################
      B₊ = Bₖ + B₀(fₖ + p - qw₀/w)   #
      ################################
      B₊ = Bₖ - B₀(qw₀/w - fₖ - p)
      B₊ = Bₖ - B₀(qw₀/w - (fₖ+p))
      B₊ = Bₖ - B₀qw₀/w + B₀(fₖ+p)
      :if w₀=w
        B₊ = Bₖ - B₀q(w₀/w) + B₀(fₖ+p)
           = Bₖ - B₀q(1) + B₀(fₖ+p)
           = Bₖ - B₀q + B₀(fₖ+p)
           = Bₖ - B₀q + B₀((p -q/w) + p)
           = Bₖ - B₀q + B₀p - B₀q/w + B₀p
           = Bₖ - B₀q/w + B₀p
           = Bₖ - B₀(p - q/w)
           = Bₖ - B₀fₖ
           = Sfₖ - B₀fₖ
        B₊ = (S - B₀)fₖ # Should be zero!!! :-??
      :end
    :end

The solution does not make sense...
As I said prior... As long as `w₀=w`, we would not add to the bet!
And yet I have `B₊=(S-B₀)fₖ` as an additional bet when `w₀=w`?
So what's going on?
