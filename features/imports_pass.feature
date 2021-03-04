@examples_pass
Feature: examples_pass

  Background:
    * Given command "korekto"

  Scenario: Syntax
    * Given option "< imports/Syntax.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Logic
    * Given option "< imports/Logic.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Natural
    * Given option "< imports/Natural.md"
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

  Scenario: Real
    * Given option "< imports/Real.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Algebra
    * Given option "< imports/Algebra.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

  Scenario: Calculus
    * Given option "< imports/Calculus.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""



