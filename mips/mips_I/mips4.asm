# FOR (int i =0; i < n; i++)

li $t1, 5
li $t0, 0 

loop:
	beq $t0, $t1, exit 
	addi $t0, $t0, 1
	j loop
exit:
	li $v0, 10
	syscall
