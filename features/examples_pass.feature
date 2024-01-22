@examples_no_edits
Feature: examples_no_edits

  Background:
    * Given command "./bin/korekto"

  Scenario: ABC
    * Given option "< examples/ABC.md"
    * When we run command
    * Then exit status is "0"
    * Then stdout is ""
    * Then stderr is ""

  Scenario: Computation
    * Given option "--patch < examples/Computation.md"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout matches /:!:syntax/

  Scenario: Dxx
    * Given option "< examples/Dxx.md"
    * When we run command
    * Then exit status is "0"
    * Then stdout is ""
    * Then stderr is ""

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md"
    * When we run command
    * Then exit status is "0"
    * Then stdout is ""
    * Then stderr is ""

  Scenario: Squash
    * Given option "< examples/Squash.md"
    * When we run command
    * Then exit status is "0"
    * Then stdout is ""
    * Then stderr is ""

  Scenario: Tutorial
    * Given option "--patch < examples/Tutorial.md"
    * When we run command
    * Then exit status is "0"
    * Then stdout is ""
    * Then stderr is ""

  Scenario: TwoCube
    * Given option "< examples/two_cube.md"
    * When we run command
    * Then exit status is "0"
    * Then stdout is ""
    * Then stderr is ""
