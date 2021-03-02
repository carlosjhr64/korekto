@examples_pass
Feature: examples_pass

  Background:
    * Given command "korekto"

  Scenario: ABC
    * Given option "< examples/ABC.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Tutorial
    * Given option "< examples/Tutorial.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Algebra
    * Given option "< imports/Algebra.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Bootstrap
    * Given option "< imports/Bootstrap.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Integer
    * Given option "< imports/Integer.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Rational
    * Given option "< imports/Rational.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
