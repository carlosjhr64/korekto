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
    * Then digest is "1f81d9d56657ad38a266561168428299"
