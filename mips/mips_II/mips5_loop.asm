.data
    msg: .ascii "Loop running! "
.text
	li $t1, 5
	li $t0, 0

loop:
	la $a0, msg
	li $v0, 4
	syscall
	
	addi $t0, $t0, 1
	bne $t0, $t1, loop
	
	li $v0, 10         
    	syscall