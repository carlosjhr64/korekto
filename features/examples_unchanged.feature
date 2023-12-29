@examples_unchanged
Feature: Examples unchanged

  Background:
    * Given command "korekto --trace"

  Scenario: Tutorial
    * Given option "--patch < examples/Tutorial.md | grep '^-:'"
    * When we run command
    * Then digest is "9df0ab00e86107928a5e13b3006ec9ac"

  Scenario: ABC
    * Given option "< examples/ABC.md | grep '^-:'"
    * When we run command
    * Then digest is "3881ffb508b141980d3597d14044ec96"

  Scenario: Dxx
    * Given option "< examples/Dxx.md | grep '^-:'"
    * When we run command
    * Then digest is "0400d8d3840067d0b1d1636e976c3da3"

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md | grep '^-:'"
    * When we run command
    * Then digest is "10b8525aa3f39fa202af672977e5cf03"

  Scenario: Squash
    * Given option "< examples/Squash.md | grep '^-:'"
    * When we run command
    * Then digest is "9dd6297dddaf4ebb19df70b0c01ac6c2"

  Scenario: Computation
    * Given option "--patch < examples/Computation.md | grep '^-:'"
    * When we run command
    * Then digest is "92488b70676d7ef82d73ff9fb5c3dbcb"

