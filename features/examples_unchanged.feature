@examples_unchanged
Feature: Examples unchanged

  Background:
    * Given command "korekto"

  Scenario: Tutorial
    * Given option "--patch < examples/Tutorial.md | grep '^-:'"
    * When we run command
    * Then stderr is ""
    * Then stdout is ""

  Scenario: ABC
    * Given option "< examples/ABC.md | grep '^-:'"
    * When we run command
    * Then stderr is ""
    * Then stdout is ""

  Scenario: Dxx
    * Given option "< examples/Dxx.md | grep '^-:'"
    * When we run command
    * Then stderr is ""
    * Then stdout is ""

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md | grep '^-:'"
    * When we run command
    * Then stderr is ""
    * Then stdout is ""

  Scenario: Squash
    * Given option "< examples/Squash.md | grep '^-:'"
    * When we run command
    * Then stderr is ""
    * Then stdout is ""

  Scenario: Computation
    * Given option "--patch < examples/Computation.md | grep '^-:'"
    * When we run command
    * Then stderr is ""
    * Then stdout is "-:19:!:syntax: (is_equation?)? eval(self): true"

