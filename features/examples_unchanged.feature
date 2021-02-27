@examples_unchanged
Feature: examples_unchanged

  Background:
    * Given command "korekto"

  Scenario: Sqrt2
    * Given option "< examples/ABC.md | grep '^-:'"
    * When we run command
    * Then digest is "3881ffb508b141980d3597d14044ec96"

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md | grep '^-:'"
    * When we run command
    * Then digest is "8885a10ca111a42d5a5cdfa2983b2574"

  Scenario: Tutorial
    * Given option "< examples/Tutorial.md | grep '^-:'"
    * When we run command
    * Then digest is "17b20169ab24a553adaae490c631c0d6"

  Scenario: Algebra
    * Given option "< examples/imports/Algebra.md | grep '^-:'"
    * When we run command
    * Then digest is "fbc215bd16d7fd247e2165a0d14fca5d"

  Scenario: Bootstrap
    * Given option "< examples/imports/Bootstrap.md | grep '^-:'"
    * When we run command
    * Then digest is "a02c9629973bf87725e1088c203b48c5"

  Scenario: Integer
    * Given option "< examples/imports/Integer.md | grep '^-:'"
    * When we run command
    * Then digest is "6df9310a5a117ee6f412b8a52fb5daba"

  Scenario: Rational
    * Given option "< examples/imports/Rational.md | grep '^-:'"
    * When we run command
    * Then digest is "c15984d460f8389a7023cd87e83b0371"
