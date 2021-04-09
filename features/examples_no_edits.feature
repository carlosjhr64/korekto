@examples_no_edits
Feature: examples_no_edits

  Background:
    * Given command "korekto --edits"

  Scenario: Dxx
    * Given option "< examples/Dxx.md"
    * When we run command
    * Then stdout is ""

  Scenario: Sqrt2
    * Given option "< examples/Sqrt2.md"
    * When we run command
    * Then stdout is ""

  Scenario: Squash
    * Given option "< examples/Squash.md"
    * When we run command
    * Then stdout is ""
