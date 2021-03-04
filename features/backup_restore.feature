@simple
Feature: simple

```korekto
/(\w)=\1/	#A1
! save: 'backup'
/(\w)&!\1/	#A2
! restore: 'backup'
/(\w)&!\1/	#A3 Not a restatement
! restore: 'bckup'
/(\w)&!\1/	#A Does not get here
```

  Background:
    * Given command "korekto"

  Scenario: --version
    * Given option "< features/backup_restore.feature"
    * When we run command
    * Then exit status is "65"
    * Then stderr is ""
    * Then stdout is "-:5:A1:\n-:7:A2:\n-:9:A3:Not a restatement\n-:10:!:nothing saved as 'bckup'"

