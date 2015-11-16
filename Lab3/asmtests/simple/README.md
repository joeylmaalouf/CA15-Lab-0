# Assembly Test Suite

#### Expected Test Results
* `$v0 == 0` means everything passed
* `$v0 == 1` means LW/SW failed
etc.

#### Memory Layout Requirements
``` asm
.data
  ...
```

#### Non-Subset Instructions Used
* `addi` (to store values in registers for testing, as an alternative to `li`)
