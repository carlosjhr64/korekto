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
    * Then digest is "3881fc01a844afab191888653037448f"
