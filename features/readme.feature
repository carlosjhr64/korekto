@readme
Feature: readme

  Background:
    * Given command "korekto"

  Scenario: README.md
    * Given option "< README.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /:Modus ponens$/
    * Then digest is "6f9dd799341d50720d5c4837031c1dcf"
