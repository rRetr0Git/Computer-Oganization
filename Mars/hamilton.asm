.data
	message_0: .asciiz "0\n"
	message_1: .asciiz "1\n"
	space: .asciiz " "
	graph: .space 400
	visited: .space 40
	stack:.space 1004
	
.text
	#prepare
	la $s0 , graph
	move $a2 , $s0 #graph address $a2
	la $s1 , visited
	move $a1 , $s1 #visited address $a1
	la $sp , stack
	add $sp , $sp , 1000 #stack address $sp
	li $t9 , 1
	li $t8 , 4
	li $t7 ,  0#column
	li $t6 , 0#row
	li $t2 , 1
	#input
	li $v0 , 5
	syscall
	move $t0 , $v0 #n
	move $a0 , $v0
	
	li $v0 , 5
	syscall
	move $t1 , $v0 #m
	
	li $t2 , 0 #set $t2 as i
	j getin

getin:
	beq $t2 , $t1 , hamilton
	nop
	
	li $v0 , 5
	syscall
	move $t3,$v0 
    
    li $v0,5
    syscall
    move $t4,$v0
    
    addi $t5,$t3,-1
    mult $t5,$t0
    mflo $t5
    add $t5,$t5,$t4
    addi $t5,$t5,-1
    mult $t5,$t8
    mflo $t5
    
    add $s0,$s0,$t5
    sw $t9,0($s0)
    sub $s0,$s0,$t5
    
    addi $t5,$t4,-1
    mult $t5,$t0
    mflo $t5
    add $t5,$t5,$t3
    addi $t5,$t5,-1
    mult $t5,$t8
    mflo $t5
    
    add $s0,$s0,$t5
    sw $t9,0($s0)
    sub $s0,$s0,$t5
    
    add $t2,$t2,1

	j getin
	

hamilton:
	move $t2 , $0
	jal judge
	
judge:
	beq $t2 , $t0 , read
	bne $t2,$t0,bfs
	nop
	li $v0 , 1
	jr $ra
	
bfs:
	sw $ra , 0($sp)
	sw $t2 , -4($sp)
	sw $t7 , -8($sp)
	sw $t6 , -12($sp)
	sw $a3,-16($sp)
    subi $sp,$sp,20
    move $t7,$t6
    move $t6,$0
    loop:
        beq $t6,$t0,no_0
        
        move $s0,$a2
        move $s1,$a1
        mult $t7,$t0
        mflo $t3
        add $t3,$t3,$t6
        mult $t3,$t8
        mflo $t3
        add $s0,$s0,$t3
        
        lw $t4,0($s0)
        mult $t6,$t8
        mflo $t3
        add $s1,$s1,$t3
        lw $t5,0($s1)
        
        xor $t5,$t5,1
        and $t4,$t4,$t5
        beq $t4,1,addition
        add $t6,$t6,1
        j loop

addition:
    sw $t9,0($s1)
    beq $t2,0,first
    add $t2,$t2,1
    jal judge
    lw $ra,20($sp)
    lw $t2,16($sp)
    lw $t7,12($sp)
    lw $t6,8($sp)
    add $sp,$sp,20
    beq $t2,0,output
    beq $a3,1,yes_0
    move $s1,$a1
    mult $t6,$t8
    mflo $t3
    add $s1,$s1,$t3
    sw $0,0($s1)
    sub $t2,$t2,1
    add $t6,$t6,1
    j loop

first:
    move $a0,$t6
    add $t2,$t2,1
    jal judge
    lw $ra,20($sp)
    lw $t2,16($sp)
    lw $t7,12($sp)
    lw $t6,8($sp)
    add $sp,$sp,20
    beq $t2,0,output
    beq $a3,1,yes_0
    sw $0,0($s1)
    beq $a3,0,no_0
    
read:
	mult $t6 , $t0
	mflo $t3 
	add $t3 , $t3 , $a0
	mult $t3 , $t8
	mflo $t3
	move $s0 , $a2
	add $s0 , $s0 , $t3
	lw $t4 , 0($s0)
	beq $t4 , 1 , yes_0
	beq $t4 , 0 , no_0

yes_0:
	li $a3 , 1
	jr $ra
	
no_0:
	li $a3 , 0
	jr $ra
	
output:
	beq $a3 , 1 , yes
	beq $a3 , 0 , no

yes:
    la $a0,message_1
    li $v0,4
    syscall
    li $v0,10
    syscall
no:
    la $a0,message_0
    li $v0,4
    syscall
    li $v0,10
    syscall
