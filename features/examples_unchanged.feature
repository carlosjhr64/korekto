@examples_unchanged
Feature: examples_unchanged

  Background:
    * Given command "korekto"

  Scenario: Tutorial
    * Given option "--patch < examples/Tutorial.md | grep '^-:'"
    * When we run command
    * Then digest is "7b0b95ac3e229a3d8e9401a5fbb7a192"

  Scenario: ABC
    * Given option "< examples/ABC.md | grep '^-:'"
    * When we run command
    * Then digest is "3881ffb508b141980d3597d14044ec96"

  Scenario: Dxx
    * Given option "< examples/Dxx.md | grep '^-:'"
    * When we run command
    * Then digest is "307b66fbda4b407b5b29a0033c720e16"

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

