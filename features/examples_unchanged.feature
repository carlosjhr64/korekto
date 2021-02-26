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
    * Then digest is "163f0688422536440130c99896954896"

  Scenario: Tutorial
    * Given option "< examples/Tutorial.md"
    * When we run command
    * Then digest is "17b20169ab24a553adaae490c631c0d6"

  Scenario: Algebra
    * Given option "< examples/imports/Algebra.md"
    * When we run command
    * Then digest is "de6034ae992024cce3f1b8edee785782"

  Scenario: Bootstrap
    * Given option "< examples/imports/Bootstrap.md"
    * When we run command
    * Then digest is "91480a1b9242ff2a797932d27d54709b"

  Scenario: Integer
    * Given option "< examples/imports/Integer.md"
    * When we run command
    * Then digest is "54b95e081c333d9a53855b4b513334b1"

  Scenario: Rational
    * Given option "< examples/imports/Rational.md"
    * When we run command
    * Then digest is "fe743fb291a65b127839a58e1825c6a9"
