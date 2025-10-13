.data
ask: .asciiz "num: "
yes: .asciiz " prime\n"
no:  .asciiz " not prime\n"
.text
.globl main

main:
	li $v0, 4
	la $a0, ask
	syscall
	li $v0, 5      # get num
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
	la $a0, yes
	syscall
	j done
not_prime:
	li $v0, 4
	la $a0, no
	syscall
done:
	li $v0, 10
	syscall

isPrime:
	move $t1, $a0      
	blez $t1, no_prime     # <= 1 not prime
	li $t2, 2
	beq $t1, $t2, is  # 2 is prime
	li $t2, 2
	div $t1, $t2      # check even
	mfhi $t3           
	beqz $t3, no_prime
	li $t4, 3          # start at 3

loop:
	mult $t4, $t4
	mflo $t5           
	bgt $t5, $t1, is   # if i*i > n, prime
	div $t1, $t4
	mfhi $t3
	beqz $t3, no_prime      # if divisible, not prime
	addi $t4, $t4, 2   # next odd
	j loop
is:
	li $v0, 1
	jr $ra
no_prime:
	li $v0, 0
	jr $ra

