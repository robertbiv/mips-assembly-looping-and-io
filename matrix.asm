.data
# hw3 matrices
matA: .word 1, 2, 3, 4  
matB: .word 5, 6, 7, 8  
matC: .word 1, 2, 3, 4, 5, 6  
matD: .word 7, 8, 9, 10, 11, 12  
res:  .space 64         
err_msg: .asciiz "cant multiply\n"
ok_msg:  .asciiz "result:\n"
spc:     .asciiz " "
newln:   .asciiz "\n"
.text
.globl main

main:
	# try 2x2 mult
	la $a0, matA    
	la $a1, matB    
	li $a2, 2          
	li $a3, 2          
	addi $sp, $sp, -4
	li $t0, 2          
	sw $t0, 0($sp)
	jal mult
	addi $sp, $sp, 4
	
	beqz $v0, fail
	
	# show result
	li $v0, 4
	la $a0, ok_msg
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
	la $a0, newln
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
	la $a0, newln
	syscall
	j done

fail:
	li $v0, 4
	la $a0, err_msg
	syscall

done:
	li $v0, 10
	syscall

# mult func
mult:
	addi $sp, $sp, -32
	sw $ra, 28($sp)
	sw $s0, 24($sp)    # i counter
	sw $s1, 20($sp)    # j counter  
	sw $s2, 16($sp)    # k counter
	sw $s3, 12($sp)    # m
	sw $s4, 8($sp)     # n
	sw $s5, 4($sp)     # p
	sw $s6, 0($sp)     # temp storage
	
	lw $s5, 32($sp)    
	move $s3, $a2      
	move $s4, $a3      
	
	# check dims
	blez $s3, bad    
	blez $s4, bad    
	blez $s5, bad    
	
	# clear result
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

	# do mult
	li $s0, 0           
i_loop:
	bge $s0, $s3, done_mult  
	
	li $s1, 0           
j_loop:
	bge $s1, $s5, next_i  
	
	li $s2, 0           
k_loop:
	bge $s2, $s4, next_j  
	
	# A[i][k] 
	mul $t0, $s0, $s4   
	add $t0, $t0, $s2   
	sll $t0, $t0, 2     
	add $t0, $a0, $t0   
	lw $t1, 0($t0)      
	
	# B[k][j] 
	mul $t2, $s2, $s5   
	add $t2, $t2, $s1   
	sll $t2, $t2, 2     
	add $t2, $a1, $t2   
	lw $t3, 0($t2)      
	
	# mult
	mul $t4, $t1, $t3
	
	# C[i][j] 
	mul $t5, $s0, $s5   
	add $t5, $t5, $s1   
	sll $t5, $t5, 2     
	la $t6, res
	add $t5, $t6, $t5   
	
	# add it
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

