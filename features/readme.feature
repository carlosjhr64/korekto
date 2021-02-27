@readme
Feature: readme

  Background:
    * Given command "korekto"

  Scenario: README.md
    * Given option "< README.md"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /Modus Ponem$/
    * Then digest is "9e9381ddf7b2d4d291f7ac5e32fbe6bd"
