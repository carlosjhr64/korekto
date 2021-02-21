@readme
Feature: readme

  Background:
    * Given command "korekto"

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
    * Given option "< examples/imports/Algebra.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Bootstrap
    * Given option "< examples/imports/Bootstrap.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Integer
    * Given option "< examples/imports/Integer.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Rational
    * Given option "< examples/imports/Rational.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
