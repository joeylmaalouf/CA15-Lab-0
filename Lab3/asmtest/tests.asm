.data
  successmsg: .asciiz "All test cases passed succesfully."
  errormsgs:
    m0: .asciiz "Error: LW/SW test case(s) failed."
    m1: .asciiz "Error: ADD test case(s) failed."
    m2: .asciiz "Error: SUB test case(s) failed."
    m3: .asciiz "Error: SLT test case(s) failed."
    m4: .asciiz "Error: XORI test case(s) failed."
  # etc.
  erroraddrs:
    .word m0
    .word m1
    .word m2
    .word m3
    .word m4
    # etc.
    .word 0


.text
main:
  li $t6, 0 # LW/SW flag
  li $t0, 5
  sw $t0, 0x00007000
  lw $t1, 0x00007000
  bne $t0, $t1, error
  
  li $t6, 1 # ADD flag
  li $t1, 100
  li $t2, 200
  add $t0, $t1, $t2
  bne $t0, 300, error
  li $t1, 150
  li $t2, 250
  add $t0, $t1, $t2
  bne $t0, 400, error
  li $t2, -100
  add $t0, $zero, $t2
  bne $t0, -100, error
  li $t1, 244
  li $t2, -244
  add $t0, $t1, $t2
  bne $t0, 0, error

  li $t6, 2 # SUB flag
  li $t1, 200
  li $t2, 0
  sub $t0, $t1, $t2
  bne $t0, 200, error
  li $t0, 200
  subi $t0, $t0, 120
  bne $t0, 80, error
  li $t1, 5000
  li $t2, -1000
  sub $t0, $t1, $t2
  bne $t0, 6000, error
  li $t1, -10
  sub $t0, $t1, $t1
  bne $t0, 0, error

  li $t6, 3 # SLT flag
  li $t1, 100
  li $t2, 200
  slt $t0, $t1, $t2
  bne $t0, 1, error
  li $t1, 200
  li $t2, 100
  slt $t0, $t1, $t2
  bne $t0, 0, error
  li $t1, -100
  li $t2, 50
  slt $t0, $t1, $t2
  bne $t0, 1, error
  li $t1, -10
  li $t2, 10
  slt $t0, $t1, $t2
  bne $t0, 1, error
  li $t1, 5
  li $t2, 5
  slt $t0, $t1, $t2
  bne $t0, 0, error

  li $t6, 4 # XORI flag
  li $t1, 0x100
  xori $t0, $t1, 0x100
  bne $t0, 0x100, error
  li $t1, 0x0c20f
  xori $t0, $t1, 0x10f10
  bne $t0, 0x11011, error
  li $t1, 0x2030402
  li $t2, 0x0103040
  xor $t0, $t1, $t2
  bne $t0, 0x1111111, error

  # show off success
  li $v0, 4 # flag for syscall to print a string
  la $a0, successmsg # value to print
  syscall
  j end

error:
  li $v0, 4 # flag for syscall to print a string
  sll $t6, $t6, 2 # multiply our case flag by 4 to align to word boundaries
  lw $t7, erroraddrs($t6) # get the error message corresponding to the case
  la $a0, ($t7) # load it into the right register
  syscall

end:
