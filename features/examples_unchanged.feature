@examples_unchanged
Feature: examples_unchanged

  Background:
    * Given command "korekto"

  Scenario: Tutorial
    * Given option "< examples/Tutorial.md | grep '^-:'"
    * When we run command
    * Then digest is "cfe03e9ee7a6086513f8525ceaa63249"

  Scenario: ABC
    * Given option "< examples/ABC.md | grep '^-:'"
    * When we run command
    * Then digest is "3881ffb508b141980d3597d14044ec96"

  Scenario: Dxx
    * Given option "< examples/Dxx.md | grep '^-:'"
    * When we run command
    * Then digest is "7b2bdb376bb55aa3580118f6a35279db"

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md | grep '^-:'"
    * When we run command
    * Then digest is "c58436e84db2c7d5713fcb4141d3d461"

