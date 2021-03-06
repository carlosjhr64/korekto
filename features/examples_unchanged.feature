@examples_unchanged
Feature: examples_unchanged

  Background:
    * Given command "korekto"

  Scenario: Tutorial
    * Given option "< examples/Tutorial.md | grep '^-:'"
    * When we run command
    * Then digest is "86208d5bc4f22763ed1a85a4a4a2a95d"

  Scenario: ABC
    * Given option "< examples/ABC.md | grep '^-:'"
    * When we run command
    * Then digest is "3881ffb508b141980d3597d14044ec96"

  Scenario: Dxx
    * Given option "< examples/Dxx.md | grep '^-:'"
    * When we run command
    * Then digest is "9a914819e2a5f34a62335aa6cdedf973"

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md | grep '^-:'"
    * When we run command
    * Then digest is "b867abb82c76b3d5c233c27e2326589c"

  Scenario: Squash
    * Given option "< examples/Squash.md | grep '^-:'"
    * When we run command
    * Then digest is "20407add9020d04a7ba00c866ef32be5"

