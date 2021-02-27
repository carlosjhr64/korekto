@examples_unchanged
Feature: examples_unchanged

  Background:
    * Given command "korekto"

  Scenario: Sqrt2
    * Given option "< examples/ABC.md"
    * When we run command
    * Then digest is "3881ffb508b141980d3597d14044ec96"

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md"
    * When we run command
    * Then digest is "6c8d288a89d1bd4eab0992c6497b7ec2"

  Scenario: Tutorial
    * Given option "< examples/Tutorial.md"
    * When we run command
    * Then digest is "17b20169ab24a553adaae490c631c0d6"

  Scenario: Algebra
    * Given option "< examples/imports/Algebra.md"
    * When we run command
    * Then digest is "435708e70483456df51e1129a45c4435"

  Scenario: Bootstrap
    * Given option "< examples/imports/Bootstrap.md"
    * When we run command
    * Then digest is "a02c9629973bf87725e1088c203b48c5"

  Scenario: Integer
    * Given option "< examples/imports/Integer.md"
    * When we run command
    * Then digest is "f80e1fc63a839b83fb3c6c462e69b6dd"

  Scenario: Rational
    * Given option "< examples/imports/Rational.md"
    * When we run command
    * Then digest is "a997c44fde0ef5e8ad37e12ca7b99381"
