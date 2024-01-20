@tutorial
Feature: Tutorial

  Background:
    * Given command "./bin/korekto --trace"

  Scenario: Tutorial.md
    * Given option "--patch < examples/Tutorial.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /Modus ponen/
    * Then stdout matches /Synthesis/
    * Then stdout matches /Reflection/
