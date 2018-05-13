.data
string:.word 0:20

.text
li $v0,5
syscall
move $s0,$v0 #set s0 as length

li $t1,0 #set t1 as counter
save:
li $v0,12
syscall
move $t0,$v0 #set t0 as value
sll $t2,$t1,2
sw $t0,string($t2)
addi $t1,$t1,1
bne $t1,$s0,save

li $t1,2
div $s0,$t1
mflo $t2 #total 
li $t3,0 #counter
addi $t4,$s0,-1
sll $t4,$t4,2 #set t4 as address1
li $t5,0 #set t5 as address2

compare:
beq $t3,$t2,print_1
lw $s1,string($t5)
lw $s2,string($t4)
addi $t5,$t5,4
addi $t4,$t4,-4
addi $t3,$t3,1
beq $s1,$s2,compare

print_0:
la $a0,0
li $v0,1
syscall
j end

print_1:
la $a0,1
li $v0,1
syscall

end:
