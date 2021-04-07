@examples_unchanged
Feature: examples_unchanged

  Background:
    * Given command "korekto"

  Scenario: Tutorial
    * Given option "< examples/Tutorial.md | grep '^-:'"
    * When we run command
    * Then digest is "7b0b95ac3e229a3d8e9401a5fbb7a192"

  Scenario: ABC
    * Given option "< examples/ABC.md | grep '^-:'"
    * When we run command
    * Then digest is "3881ffb508b141980d3597d14044ec96"

  Scenario: Dxx
    * Given option "< examples/Dxx.md | grep '^-:'"
    * When we run command
    * Then digest is "d047ba5459fb8923dc5ca34579207bd3"

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md | grep '^-:'"
    * When we run command
    * Then digest is "8e14483f82e325796019e11c78f5940f"

  Scenario: Squash
    * Given option "< examples/Squash.md | grep '^-:'"
    * When we run command
    * Then digest is "9dd6297dddaf4ebb19df70b0c01ac6c2"

  Scenario: Computation
    * Given option "< examples/Computation.md | grep '^-:'"
    * When we run command
    * Then digest is "92488b70676d7ef82d73ff9fb5c3dbcb"

