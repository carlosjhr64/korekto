@tutorial
Feature: tutorial

  Background:
    * Given command "korekto"

  Scenario: README.md
    * Given option "--patch < examples/Tutorial.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /Modus ponen/
    * Then stdout matches /Synthesis/
    * Then stdout matches /Reflection/
