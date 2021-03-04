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
    * Then digest is "be4e25111000a0123b6f15be629291f4"

  Scenario: Natural
    * Given option "< imports/Natural.md | grep '^-:'"
    * When we run command
    * Then digest is "9b3b357203e368a57b86c51ca7ba5a15"

  Scenario: Integer
    * Given option "< imports/Integer.md | grep '^-:'"
    * When we run command
    * Then digest is "8e34d52e04a281f64e38c00ce2242a6d"

  Scenario: Rational
    * Given option "< imports/Rational.md | grep '^-:'"
    * When we run command
    * Then digest is "94186a4f3650a3b66a347ae8b3aa8017"

  Scenario: Real
    * Given option "< imports/Real.md | grep '^-:'"
    * When we run command
    * Then digest is "444400e566f6eec62a14ad8cc59f35cf"

  Scenario: Algebra
    * Given option "< imports/Algebra.md | grep '^-:'"
    * When we run command
    * Then digest is "d4477971fbae3cd6de63fb9f1cdaa26f"

  Scenario: Calculus
    * Given option "< imports/Calculus.md | grep '^-:'"
    * When we run command
    * Then digest is "24ac39b991d39ceaefa6a477fdd4862b"
