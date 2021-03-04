@examples_unchanged
Feature: examples_unchanged

  Background:
    * Given command "korekto"

  Scenario: Syntax
    * Given option "< imports/Syntax.md | grep '^-:'"
    * When we run command
    * Then stdout is ""

  Scenario: Logic
    * Given option "< imports/Logic.md | grep '^-:'"
    * When we run command
    * Then digest is "14927f2166089a0ae16c722351007696"

  Scenario: Natural
    * Given option "< imports/Natural.md | grep '^-:'"
    * When we run command
    * Then digest is "9ee05a031074f9d7c06e13da5303cfc0"

  Scenario: Integer
    * Given option "< imports/Integer.md | grep '^-:'"
    * When we run command
    * Then digest is "9e6002b46a6cfb0f5b3842e408da181d"

  Scenario: Rational
    * Given option "< imports/Rational.md | grep '^-:'"
    * When we run command
    * Then digest is "cf54ae15f379cc1196767735a03ce92d"

  Scenario: Real
    * Given option "< imports/Real.md | grep '^-:'"
    * When we run command
    * Then digest is "f802daa1b3e8e135f3e7458e9276dc4e"

  Scenario: Algebra
    * Given option "< imports/Algebra.md | grep '^-:'"
    * When we run command
    * Then digest is "195ce3f3f3372f7cb38b91373ac22517"

  Scenario: Calculus
    * Given option "< imports/Calculus.md | grep '^-:'"
    * When we run command
    * Then digest is "1fa033edeb14d8f5074afb45cf7827c2"
