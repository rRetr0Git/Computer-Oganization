.data 
list:.word 0:100
space:.asciiz " "

.text
li $v0,5
syscall
move $s0,$v0 #set s0 as n

li $t1,0 #set t1 as counter
save:
li $v0,5
syscall
move $t0,$v0 #set t0 as value
sll $t2,$t1,2
sw $t0,list($t2)
addi $t1,$t1,1
bne $t1,$s0,save

move $t1,$0 #set t1 as counter
move $t5,$0 #set t5 as another counter

choose:
sll $t2,$t1,2
addi $t5,$t1,1
lw $t0,list($t2) #set t0 as min
move $t9,$t2

next:
beq $t5,$s0,arrange
addi $t2,$t2,4 #set t2 as offset
addi $t5,$t5,1
lw $t3,list($t2) #set t3 as next number
slt $t4,$t3,$t0 #set t4 as mark
beq $t4,$0,next
move $t0,$t3
move $t9,$t2 #set t9 as the address of min
bne $t5,$s0,next

arrange:
sll $t7,$t1,2
lw $t8,list($t7)
sw $t0,list($t7) #swap
sw $t8,list($t9)
addi $t1,$t1,1
bne $t1,$s0,choose

li $a1,0 #set as address
li $s1,0 #set as counter

print:
lw $a0,list($a1)
li $v0,1
syscall
la $a0,space
li $v0,4
syscall
addi $s1,$s1,1
addi $a1,$a1,4
bne $s1,$s0,print