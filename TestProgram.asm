.text

	addi $s0, $s0, 1
	addi $s1, $s1, 2
	addi $s2, $s3, 3
	
	jal store1
load1: 
	lw $s0, 8($sp)
	lw $s1, 4($sp)
	lw $s2, 0($sp)
	
	addi $s0, $s0, 0
	addi $s1, $s1, 0
	addi $s2, $s2, 0
	j fin

store1:
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $s2, 0($sp)
	
	addi $s0, $s0, 4
	addi $s1, $s1, 3
	addi $s2, $s2, 2
	
	jr $ra
fin:
