.data 
symbol:.word 0:8
array:.word 0:8
stack:.space 804
space:.asciiz " "
enter:.asciiz "\n"
.text
li $v0,5
syscall
move $s0,$v0 #set s0 as n

la $sp,stack
addi $sp,$sp,800
li $a2,0 #set a2 as index
li $t1,0 #set t1 as i

sw $ra,0($sp)
sw $a2,-4($sp)
sw $t1,-8($sp)
addi $sp,$sp,-12
jal fullarray
li $v0,10
syscall


fullarray:
slt $t7,$a2,$s0
beq $t7,0,print
move $t1,$0
for:
#set t2 as address
sll $t2,$t1,2
lw $s1,symbol($t2)
beq $s1,0,if
addi $t1,$t1,1 #i++
bne $t1,$s0,for
jr $ra
if:
sll $t2,$a2 2
addi $t3,$t1,1
sw $t3,array($t2) #array [index]=i+1
sll $t2,$t1,2
li $s1,1
sw $s1,symbol($t2) #symbol [i]=1
sw $ra,0($sp)
sw $a2,-4($sp)
sw $t1,-8($sp)
addi $sp,$sp,-12
addi $a2,$a2,1#fullarray[index+1]
jal fullarray #fullarray[index+1]
lw $ra,12($sp)
lw $a2,8($sp)
lw $t1,4($sp)
addi $sp,$sp,12
sll $t2,$t1,2
li $s1,0
sw $s1,symbol($t2) #symbol [i]=0
addi $t1,$t1,1 #i++
bne $t1,$s0,for
jr $ra

print:
li $t9,0
li $t8,0 #counter
reprint:
lw $a1,array($t9)
la $a0,($a1)
li $v0,1
syscall
addi $t9,$t9,4
addi $t8,$t8,1
la $a0,space
li $v0,4
syscall
bne $t8,$s0,reprint
la $a0,enter
li $v0,4
syscall
jr $ra
