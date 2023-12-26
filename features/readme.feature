@readme
Feature: readme

  Background:
    * Given command "korekto --trace"

  Scenario: README.md
    * Given option "< README.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /:Modus ponens$/
    * Then digest is "6d1a555645cf58e7d757f3c30c71b8a3"
