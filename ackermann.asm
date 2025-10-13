.data
ask_m: .asciiz "m: "
ask_n: .asciiz "n: "
ans: .asciiz "ack = "
.text
.globl main

main:
    # get inputs
    li $v0, 4
    la $a0, ask_m
    syscall
    li $v0, 5         # get m
    syscall
    move $t8, $v0    
    li $v0, 4
    la $a0, ask_n
    syscall
    li $v0, 5         # get n
    syscall
    move $t9, $v0    
    # call ackermann
    move $a0, $t8
    move $a1, $t9
    jal ack
    # print result
    move $t0, $v0
    li $v0, 4
    la $a0, ans
    syscall
    move $a0, $t0
    li $v0, 1
    syscall
    li $v0, 10
    syscall

ack:
    # recursive ackermann func
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $t0, 8($sp)
    sw $t1, 4($sp)
    sw $t2, 0($sp)
    move $t0, $a0   # m
    move $t1, $a1   # n
    beqz $t0, m_zero # if m=0
    beqz $t1, n_zero # if n=0
    move $a0, $t0
    addi $a1, $t1, -1
    jal ack
    move $a1, $v0
    addi $a0, $t0, -1
    jal ack
    j done
m_zero:
    addi $v0, $t1, 1  # return n+1
    j done
n_zero:
    addi $a0, $t0, -1 # ack(m-1, 1)
    li $a1, 1
    jal ack
    j done
done:
    lw $t2, 0($sp)
    lw $t1, 4($sp)
    lw $t0, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
