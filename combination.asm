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
    li $v0, 5
    syscall
    move $t0, $v0   

    li $v0, 4
    la $a0, ask_r
    syscall
    li $v0, 5
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
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $t0, 4($sp)
    sw $t1, 0($sp)
    
    move $t0, $a0
    move $t1, $a1
    
    beqz $t1, one
    beq $t0, $t1, one
    
    addi $a0, $t0, -1
    addi $a1, $t1, -1
    jal combo
    move $t2, $v0
    
    addi $a0, $t0, -1
    move $a1, $t1
    jal combo
    
    add $v0, $t2, $v0
    j exit_combo

one:
    li $v0, 1

exit_combo:
    lw $t1, 0($sp)
    lw $t0, 4($sp)
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra
