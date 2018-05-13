.data
	row: .space 2500
	column: .space 2500
	val: .space 2500
	space: .asciiz " "
	return: .asciiz "\n"
	
.text
	li $v0 , 5
	syscall
	move $t0 , $v0 #row
	
	li $v0 , 5
	syscall
	move $t1 , $v0 #column
	
	mult $t0 , $t1
	mflo $t2 #number of elements
	
	
	li $t3 , 0 #set $t3 as i
	li $t5 , 0 #set $t5 as number of not zero
	
getin:
	beq $t3 , $t2 , print
	
	li $v0 , 5
	syscall
	move $t4 , $v0 #value
	addi $t3 , $t3 , 1
	
	beq $t4 , $zero , getin
	addi $t5 , $t5 , 1
	div $t3 , $t1
	mflo $s0 
	mfhi $s4
	beq $s4 , $zero , last
save:
	#save the row 
	la $s1 , row
	li $s2 , 4
	mult $t5 , $s2
	mflo $s3
	addu $s1 , $s1 , $s3
	sw $s0 , 0($s1)
	#save the column
	div $t3 , $t1
	la $s1 , column
	li $s2 , 4
	mult $t5 , $s2
	mflo $s3
	addu $s1 , $s1 , $s3
	sw $s4 , 0($s1)
	
	#save the value
	la $s1 , val
	li $s2 , 4
	mult $t5 , $s2
	mflo $s3
	addu $s1 , $s1 , $s3
	sw $t4 , 0($s1)
	j getin
	nop
last:
	addi $s0 , $s0 , -1
	add $s4 , $s4 , $t1
	j save
	nop
	
print:
	beq $t5 , $zero , end
	
	la $s1 , row
	li $s2 , 4
	mult $t5 , $s2
	mflo $s3
	addu $s1 , $s1 , $s3
	
	lw $a0 , 0($s1)
	addi $a0 , $a0 , 1
	li $v0 , 1
	syscall
	
	la $a0 , space
	li $v0 , 4
	syscall
	
	la $s1 , column
	li $s2 , 4
	mult $t5 , $s2
	mflo $s3
	addu $s1 , $s1 , $s3
	
	lw $a0 , 0($s1)
	li $v0 , 1
	syscall
	
	la $a0 , space
	li $v0 , 4
	syscall
	
	la $s1 ,val
	li $s2 , 4
	mult $t5 , $s2
	mflo $s3
	addu $s1 , $s1 , $s3
	
	lw $a0 , 0($s1)
	li $v0 , 1
	syscall
	
	la $a0 , return
	li $v0 , 4
	syscall
	
	addi $t5 , $t5 , -1
	
	j print
	nop
	
end:
	
	
