.data
ask_n: .asciiz "n: "
ask_r: .asciiz "r: "
ans: .asciiz "C = "
.text
.globl main

main:
    li $v0, 4
    la $a0, ask_n
    syscall  
    li $v0, 5         # get n
    syscall
    move $t0, $v0   
    li $v0, 4
    la $a0, ask_r
    syscall
    li $v0, 5         # get r
    syscall
    move $t1, $v0   
    move $a0, $t0
    move $a1, $t1
    jal combo
    move $t2, $v0
    li $v0, 4
    la $a0, ans
    syscall
    move $a0, $t2
    li $v0, 1
    syscall
    li $v0, 10
    syscall

combo:
    # recursive C(n,r) func
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)
    move $s0, $a0  # n
    move $s1, $a1  # r
    bltz $s1, zero # r < 0
    bgt $s1, $s0, zero # r > n
    beqz $s1, one  # r = 0
    beq $s0, $s1, one # n = r
    # C(n-1,r-1) + C(n-1,r)
    addi $a0, $s0, -1
    addi $a1, $s1, -1
    jal combo
    move $s2, $v0
    addi $a0, $s0, -1
    move $a1, $s1
    jal combo
    add $v0, $s2, $v0
    j exit_combo
one:
    li $v0, 1
    j exit_combo
zero:
    li $v0, 0
exit_combo:
    lw $s2, 0($sp)
    lw $s1, 4($sp)
    lw $s0, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra