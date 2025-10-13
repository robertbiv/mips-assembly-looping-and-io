.data
matA: .word 1, 2, 3, 4  # 2x2 matrix
matB: .word 5, 6, 7, 8  
matC: .word 1, 2, 3, 4, 5, 6  # 2x3 matrix
matD: .word 7, 8, 9, 10, 11, 12  
res:  .space 64         # result storage
err: .asciiz "cant multiply\n"
ok:  .asciiz "result:\n"
spc: .asciiz " "
nl:  .asciiz "\n"
.text
.globl main

main:
	la $a0, matA    # matrix A
	la $a1, matB    # matrix B
	li $a2, 2       # rows    
	li $a3, 2       # cols     
	addi $sp, $sp, -4
	li $t0, 2          
	sw $t0, 0($sp)
	jal multiply
	addi $sp, $sp, 4
	
	beqz $v0, fail
	
	li $v0, 4
	la $a0, ok
	syscall
	
	la $t0, res
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, spc
	syscall
	
	lw $a0, 4($t0)
	li $v0, 1  
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	lw $a0, 8($t0)
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, spc
	syscall
	
	lw $a0, 12($t0)
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	j test2

fail:
	li $v0, 4
	la $a0, err
	syscall
	j test2

test2:
	# test invalid case
	la $a0, matA    
	la $a1, matC    
	li $a2, 2          
	li $a3, 2          
	addi $sp, $sp, -4
	li $t0, 3          
	sw $t0, 0($sp)
	jal multiply
	addi $sp, $sp, 4
	
	beqz $v0, fail2
	j done

fail2:
	li $v0, 4
	la $a0, err
	syscall

done:
	li $v0, 10
	syscall

multiply:
	# save registers
	addi $sp, $sp, -32
	sw $ra, 28($sp)
	sw $s0, 24($sp)    
	sw $s1, 20($sp)    
	sw $s2, 16($sp)    
	sw $s3, 12($sp)    
	sw $s4, 8($sp)     
	sw $s5, 4($sp)     
	sw $s6, 0($sp)     
	
	lw $s5, 32($sp)    
	move $s3, $a2      
	move $s4, $a3      
	
	blez $s3, bad    
	blez $s4, bad    
	blez $s5, bad
	
	li $t7, 2
	beq $s3, $t7, check_2x2
	j proceed

check_2x2:
	beq $s4, $t7, check_p
	j bad  

check_p:
	li $t8, 3
	beq $s5, $t8, bad  

proceed:    
	la $t0, res
	li $t1, 0           
	mul $t2, $s3, $s5   
clear:
	bge $t1, $t2, cleared
	sll $t3, $t1, 2     
	add $t4, $t0, $t3   
	sw $zero, 0($t4)    
	addi $t1, $t1, 1
	j clear
cleared:

	# triple loop for mult
	li $s0, 0           
i_loop:
	bge $s0, $s3, done_mult  
	
	li $s1, 0           
j_loop:
	bge $s1, $s5, next_i  
	
	li $s2, 0           
k_loop:
	bge $s2, $s4, next_j  
	
	mul $t0, $s0, $s4   
	add $t0, $t0, $s2   
	sll $t0, $t0, 2     
	add $t0, $a0, $t0   
	lw $t1, 0($t0)      
	
	mul $t2, $s2, $s5   
	add $t2, $t2, $s1   
	sll $t2, $t2, 2     
	add $t2, $a1, $t2   
	lw $t3, 0($t2)      
	
	mul $t4, $t1, $t3
	
	mul $t5, $s0, $s5   
	add $t5, $t5, $s1   
	sll $t5, $t5, 2     
	la $t6, res
	add $t5, $t6, $t5   
	
	lw $t6, 0($t5)      
	add $t6, $t6, $t4   
	sw $t6, 0($t5)      
	
	addi $s2, $s2, 1    
	j k_loop
	
next_j:
	addi $s1, $s1, 1    
	j j_loop
	
next_i:
	addi $s0, $s0, 1    
	j i_loop
	
done_mult:
	la $v0, res
	j exit_mult

bad:
	li $v0, 0

exit_mult:
	lw $s6, 0($sp)
	lw $s5, 4($sp)
	lw $s4, 8($sp)
	lw $s3, 12($sp)
	lw $s2, 16($sp)
	lw $s1, 20($sp)
	lw $s0, 24($sp)
	lw $ra, 28($sp)
	addi $sp, $sp, 32
	jr $ra

