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
    * Then digest is "19b229f1c74bd69cb7593cc2e706998a"
