@examples_unchanged
Feature: examples_unchanged

  Background:
    * Given command "korekto"

  Scenario: Tutorial
    * Given option "< examples/Tutorial.md | grep '^-:'"
    * When we run command
    * Then digest is "5e21b5bd40b855f6c717be0a5783cca3"

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

