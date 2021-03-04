@examples_pass
Feature: examples_pass

  Background:
    * Given command "korekto"

  Scenario: Tutorial
    * Given option "< examples/Tutorial.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: ABC
    * Given option "< examples/ABC.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Dxx
    * Given option "< examples/Dxx.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
