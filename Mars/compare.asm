.data
	s1: .asciiz "$t1 is greater than $t2\n"
	s2: .asciiz "$t1 is not greater than $t2\n"
	
.text
	li $t1, 23
	li $t2, -5
	
	slt $t3, $t1,$t2
	beq $t3, $0, if_1_else
	nop
	la $a0,s2
	li $v0,4
	syscall
	j if_1_end
	nop
	
	if_1_else:
		la $a0,s1
		li $v0, 4
		syscall
	
	if_1_end: