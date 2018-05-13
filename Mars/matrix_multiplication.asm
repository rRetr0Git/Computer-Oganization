.data 
data1: .word 0:64
data2:.word 0:64
data3:.word 0:64
space:.asciiz " "
enter:.asciiz "\n"

.text
li $v0,5
syscall
move $t0,$v0 #set t0=n

li $s0,0 #row couter
li $s1,0	#column couter

#save first
loop1:
li $v0,5
syscall
move $t1,$v0
mult $s0,$t0
mflo $s2
add $s2,$s2,$s1
sll $s2,$s2,2
sw $t1,data1($s2)
addi $s1,$s1,1
bne $s1,$t0,loop1
move $s1,$0
addi $s0,$s0,1
bne $s0,$t0,loop1

li $s0,0 #row couter
li $s1,0	#column couter

#save second
loop2:
li $v0,5
syscall
move $t1,$v0
mult $s0,$t0
mflo $s2
add $s2,$s2,$s1
sll $s2,$s2,2
sw $t1,data2($s2)
addi $s1,$s1,1
bne $s1,$t0,loop2
move $s1,$0
addi $s0,$s0,1
bne $s0,$t0,loop2

li $s0,0
li $s1,0
li $s2,0
li $s7,0
li $s5,0
# t0=n,s0=i,s1=j,s3=address1,s6=value2
# s4=value1,s5=address2
li $t1,0 #value
li $t7,0 #temp
li $t6,0 #value counter

cal_and_save:
#beginning of row
mult $s0,$t0
mflo $s3
sll $s3,$s3,2
lw $s4,data1($s3)
#beginning of column
add $s5,$s5,$s1
sll $s5,$s5,2
lw $s6,data2($s5)

mult $s4,$s6
mflo $t2
add $t1,$t1,$t2
li $t7,4
mult $t0,$t7
mflo $t7
addi $t6,$t6,1

load:
addi $s3,$s3,4
lw $s4,data1($s3)
add $s5,$s5,$t7
lw $s6,data2($s5)

mult $s4,$s6
mflo $t2
add $t1,$t1,$t2
addi $t6,$t6,1
bne $t6,$t0,load

move $t6,$0
move $s3,$0
move $s5,$0

mult $s0,$t0
mflo $s2
add $s2,$s2,$s1
sll $s2,$s2,2
sw $t1,data3($s2)
addi $s1,$s1,1
li $t1,0
bne $s1,$t0,cal_and_save
move $s1,$0
addi $s0,$s0,1
bne $s0,$t0,cal_and_save

li $s0,0
li $s1,0
li $s2,0

print:
lw $a1,data3($s2)
move $a0,$a1
li $v0,1
syscall
la $a0,space
li $v0,4
syscall

addi $s1,$s1,1
addi $s2,$s2,4
bne $s1,$t0,print

la $a0,enter
li $v0,4
syscall

move $s1,$0
addi $s0,$s0,1
bne $s0,$t0,print
