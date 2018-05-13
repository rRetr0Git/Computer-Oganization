.data
	message_1: .asciiz "1\n"
	message_0: .asciiz "0\n" 
.text
	li $v0 , 5
	syscall
	
	move $t0 , $v0
	li $t1 , 4
	li $t2 , 100
	li $t3 , 400
	
	div $t0 , $t1
	mfhi $t4
	div $t0 , $t2
	mfhi $t5
	div $t0 , $t3
	mfhi $t6
	
	beq $t4 , $zero, if_else

print0:
	beq $t6 , $zero , print1
	
	la $a0 , message_0
	li $v0 , 4
	syscall
	j if_end
	nop
	
	if_else:
	beq $t5 , $zero , print0
	
print1:
	la $a0 , message_1
	li $v0 , 4
	syscall
	
	if_end:
