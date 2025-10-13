.data
ask:     .asciiz "num: "
yes_msg: .asciiz " prime\n"
no_msg:  .asciiz " not prime\n"
.text
.globl main

main:
	li $v0, 4
	la $a0, ask
	syscall

	li $v0, 5
	syscall
	move $t0, $v0    

	move $a0, $t0
	jal isPrime

	move $t1, $v0      

	move $a0, $t0
	li $v0, 1
	syscall            

	beqz $t1, not_prime
	li $v0, 4
	la $a0, yes_msg
	syscall
	j done

not_prime:
	li $v0, 4
	la $a0, no_msg
	syscall

done:
	li $v0, 10
	syscall


isPrime:
	move $t1, $a0      

	blez $t1, no

	li $t2, 2
	beq $t1, $t2, yes

	li $t2, 2
	div $t1, $t2
	mfhi $t3           
	beqz $t3, no

	li $t4, 3          

loop:
	mult $t4, $t4
	mflo $t5           
	bgt $t5, $t1, yes

	div $t1, $t4
	mfhi $t3
	beqz $t3, no

	addi $t4, $t4, 2   
	j loop

yes:
	li $v0, 1
	jr $ra

no:
	li $v0, 0
	jr $ra

